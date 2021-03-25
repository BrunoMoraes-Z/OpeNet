import { hash } from "bcryptjs";
import { getRepository } from "typeorm";
import User from "../../../infra/entity/User";
import AppError from "../../../infra/errors/AppError";

interface Request {
  first_name: string;
  last_name: string;
  email: string;
  password: string;
}

export default class CreateUserService {

  public async execute({ first_name, last_name, email, password }: Request): Promise<User> {
    const repository = getRepository(User);
    const exists = await repository.findOne({ where: { email } });
    if (exists) {
      throw new AppError('Email já cadastrado.', 404);
    }
    const hashed = await hash(password, 8);
    const user = repository.create({
      first_name,
      last_name,
      email,
      password: hashed
    });

    await repository.save(user);

    return user;
  }

}