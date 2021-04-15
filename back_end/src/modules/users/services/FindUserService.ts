import { getRepository } from "typeorm";

import config from '../../../config/auth';
import User from "../../../infra/entity/User";
import AppError from "../../../infra/errors/AppError";

export default class FindUserService {

  public async execute(email: String, key: String): Promise<boolean> {
    const repository = getRepository(User);

    if (key !== config.server_key) {
      throw new AppError('Internal Server Error.', 500);
    }

    const user = await repository.findOne({ where: { email } });
    if (!user) {
      throw new AppError('Nenhum Email encontrado.', 400);
    }

    return true;
  }

}