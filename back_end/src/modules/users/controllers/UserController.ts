import { Request, Response } from "express";
import { getRepository } from "typeorm";
import User from "../../../infra/entity/User";
import AcceptPendingService from "../services/AcceptPendingService";
import AvailableUserNameService from "../services/AvailableUserNameService";
import CreateUserService from "../services/CreateUserService";
import FindUserService from "../services/FindUserService";
import PendingUserService from "../services/PendingUserService";
import RecoverPasswordService from "../services/RecoverPasswordService";
import RejectPendingService from "../services/RejectPendingService";

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

  public async listPending(request: Request, response: Response): Promise<Response> {
    const repository = getRepository(User);
    const users = await repository.find({ where: { pending: true } });
    console.log(users.length);
    if (users != null && users.length > 0) {
      const result = await new PendingUserService().execute(users);
      return response.json(result);
    }

    return response.json({
      message: 'Nenhum cadastro pendente encontrado.'
    });
  }

  public async acceptPending(request: Request, response: Response): Promise<Response> {
    const { user_id } = request.body;

    const repository = getRepository(User);
    const user = await repository.findOne({ where: { user_id, pending: true } });
    if (user) {
      const result = await new AcceptPendingService().execute(user);

      return response.status(result ? 200 : 400).json(result ? { message: 'Cadastro aprovado com sucesso.' } : { error: 'Ouve um erro ao tentar aprovar este cadastro.' });
    }

    return response.json({
      message: 'Nenhum cadastro pendente encontrado.'
    });
  }

  public async rejectPending(request: Request, response: Response): Promise<Response> {
    const { user_id } = request.body;

    const repository = getRepository(User);
    const user = await repository.findOne({ where: { user_id, pending: true } });
    if (user) {
      const result = await new RejectPendingService().execute(user);

      return response.status(result ? 200 : 400).json(result ? { message: 'Cadastro rejeitado com sucesso.' } : { error: 'Ouve um erro ao tentar rejeitar este cadastro.' });
    }

    return response.json({
      message: 'Nenhum cadastro pendente encontrado.'
    });
  }

}