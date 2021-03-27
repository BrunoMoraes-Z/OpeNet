import { Request, Response } from "express";
import CreateUserService from "../services/CreateUserService";
import FindUserService from "../services/FindUserService";

export default class UserController {

  public async create(request: Request, response: Response): Promise<Response> {
    const { first_name, last_name, email, curso, periodo, dt_nascimento, password } = request.body;
    const service = new CreateUserService();
    const splitted = dt_nascimento.split('/');
    const dt_nasc = new Date(`${splitted[1]}/${splitted[0]}/${splitted[2]}`);

    const user = await service.execute({ first_name, last_name, email, curso, periodo, dt_nasc, password });

    delete user.password;

    return response.json(user);
  }

  public async hasUser(request: Request, respose: Response): Promise<Response> {
    const key = request.headers['server-key'];

    const { email } = request.body;
    const service = new FindUserService();

    const result = await service.execute(email, key.toString());

    return respose.status(result ? 200 : 400).json({});
  }

}