import { hash } from "bcryptjs";
import { getRepository } from "typeorm";
import User from "../../../infra/entity/User";
import AppError from "../../../infra/errors/AppError";

interface Request {
  first_name: string;
  last_name: string;
  user_name: string;
  email: string;
  curso_id: string;
  periodo: number;
  ano_curso: number;
  dt_nasc: Date;
  password: string;
  g_id: string;
}

export default class CreateUserService {

  public async execute({ first_name, last_name, user_name, email, curso_id, periodo, ano_curso, dt_nasc, password, g_id }: Request): Promise<User> {
    const repository = getRepository(User);
    const exists = await repository.createQueryBuilder().where({ email }).orWhere('"user_name" = :user_name', { user_name }).getOne();
    // const exists = await repository.findOne({ where: { email } });
    if (exists) {
      throw new AppError('Email ou nome de usuário já está sendo utilizado.', 404);
    }
    if (ano_curso < dt_nasc.getFullYear() || ((ano_curso - dt_nasc.getFullYear()) < 18)) {
      throw new AppError('O ano de inicio é um ano inválido.', 404);
    }
    const hashed = await hash(password, 8);
    const user = repository.create({
      first_name,
      last_name,
      user_name,
      email,
      curso_id,
      periodo,
      ano_curso,
      dt_nascimento: dt_nasc,
      password: hashed,
      g_id
    });

    await repository.save(user);

    return user;
  }

}