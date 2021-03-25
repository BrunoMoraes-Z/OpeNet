import { compare, hash } from "bcryptjs";
import { sign } from "jsonwebtoken";
import { getRepository, SimpleConsoleLogger } from "typeorm";
import { print } from "util";

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

    const user = await repository.findOne({ where: { email } });
    if (!user) {
      throw new AppError('Email/Senha inválidos.', 401);
    }

    const similar = await compare(password, user.password);
    if (!similar) {
      throw new AppError('Email/Senha inválidos.', 401);
    }

    const token = sign({}, config.jwt.secret, {
      subject: user.user_id,
      expiresIn: config.jwt.expiresIn
    });

    delete user.password;

    return { user, token };
  }

}