import { Request, Response } from "express";
import ListCursosService from "../services/ListCursosService";

export default class CursoController {

  public async list(request: Request, response: Response): Promise<Response> {
    const service = new ListCursosService();

    const cursos = await service.execute();

    return response.json(cursos);
  }

}