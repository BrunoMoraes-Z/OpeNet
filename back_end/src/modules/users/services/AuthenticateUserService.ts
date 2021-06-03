import { compare } from "bcryptjs";
import { sign } from "jsonwebtoken";
import { getRepository } from "typeorm";

import config from '../../../config/auth';
import User from "../../../infra/entity/User";
import AppError from "../../../infra/errors/AppError";

interface Request {
  email: string;
  password: string;
}

export default class AuthenticateUserService {

  public async execute({ email, password }: Request): Promise<{ user: User, token: string }> {
    const repository = getRepository(User);

    const user = await repository.createQueryBuilder().where({ email })
    .orWhere('"user_name" = :user_name', { user_name: email }).getOne();

    // const user = await repository.findOne({ where: { email } });
    if (!user) {
      throw new AppError('Email/Senha inválidos.', 401);
    } else {
      if (user.pending) {
        throw new AppError('Cadastro ainda pendente.', 404);
      }
    }

    const similar = await compare(password, user.password);
    if (!similar) {
      if (user.g_id.length > 0) {
        if (user.g_id != password) {
          throw new AppError('Email/Senha inválidos.', 401);
        }
      } else {
        throw new AppError('Email/Senha inválidos.', 401);
      }
    }

    const token = sign({}, config.jwt.secret, {
      subject: user.user_id,
      expiresIn: config.jwt.expiresIn
    });

    delete user.password;
    delete user.g_id;
    delete user.pending;

    return { user, token };
  }

}