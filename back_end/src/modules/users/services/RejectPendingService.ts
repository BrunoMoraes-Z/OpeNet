import { getRepository } from "typeorm";
import User from "../../../infra/entity/User";

export default class RejectPendingService {

  public async execute(user: User): Promise<boolean> {

    const repository = getRepository(User);

    try {
      repository.remove(user);
      return true;
    } catch (error) {
      return false;
    }
  }

}