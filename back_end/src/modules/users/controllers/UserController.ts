import { Request, Response } from "express";
import CreateUserService from "../services/CreateUserService";

export default class UserController {

  public async create(request: Request, response: Response): Promise<Response> {
    const { first_name, last_name, email, password } = request.body;
    const service = new CreateUserService();

    const user = await service.execute({ first_name, last_name, email, password });

    delete user.password;

    return response.json(user);
  }

}