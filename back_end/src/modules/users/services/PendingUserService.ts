import User from "../../../infra/entity/User";

export default class PendingUserService {

  public async execute(users: User[]): Promise<User[]> {

    users = users.map(u => {
      delete u.password;
      return u;
    });

    return users;
  }

}