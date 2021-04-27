import { Request, Response } from "express";
import { getRepository } from "typeorm";
import User from "../../../infra/entity/User";
import AvailableUserNameService from "../services/AvailableUserNameService";
import CreateUserService from "../services/CreateUserService";
import FindUserService from "../services/FindUserService";
import RecoverPasswordService from "../services/RecoverPasswordService";

export default class UserController {

  public async create(request: Request, response: Response): Promise<Response> {
    const { first_name, last_name, user_name, email, curso_id, periodo, ano_curso, dt_nascimento, password, g_id } = request.body;
    const service = new CreateUserService();
    const splitted = dt_nascimento.split('/');
    const dt_nasc = new Date(`${splitted[1]}/${splitted[0]}/${splitted[2]}`);

    const user = await service.execute({ first_name, last_name, user_name, email, curso_id, periodo, ano_curso, dt_nasc, password, g_id });

    delete user.password;

    return response.json(user);
  }

  public async hasUser(request: Request, response: Response): Promise<Response> {
    const key = request.headers['server-key'];
    const email = request.headers['email'];

    const service = new FindUserService();

    const result = await service.execute(email.toString(), key.toString());

    return response.status(result ? 200 : 400).json();
  }

  public async available(request: Request, response: Response): Promise<Response> {
    const key = request.headers['server-key'];
    const user_name = request.headers['user_name'];

    const service = new AvailableUserNameService();

    const result = await service.execute(user_name.toString(), key.toString());

    return response.status(result ? 200 : 400).json();
  }

  public async recover(request: Request, response: Response): Promise<Response> {
    const { email } = request.body;

    const repository = getRepository(User);
    const user = await repository.findOne({ where: { email } });
    if (user) {
      new RecoverPasswordService().execute(user);
    }

    return response.json({
      message: 'Se o E-Mail informado estiver cadastrado será enviado uma mensagem para recuperação.'
    });
  }

}