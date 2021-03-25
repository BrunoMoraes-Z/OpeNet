import { Request, Response } from "express";
import AuthenticateUserService from "../services/AuthenticateUserService";

export default class SessionController {

  public async create(request: Request, response: Response): Promise<Response> {
    const { email, password } = request.body;
    const service = new AuthenticateUserService();

    const { user, token } = await service.execute({ email, password });

    return response.json({ user, token });
  }

}