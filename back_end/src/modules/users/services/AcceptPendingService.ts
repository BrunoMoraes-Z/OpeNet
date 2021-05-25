import { getRepository } from "typeorm";
import User from "../../../infra/entity/User";

export default class AcceptPendingService {

  public async execute(user: User): Promise<boolean> {

    const repository = getRepository(User);

    try {
      user.pending = !user.pending;
      repository.save(user);
      return true;
    } catch (error) {
      return false;
    }
  }

}