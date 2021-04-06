import { getRepository, SimpleConsoleLogger } from "typeorm";

import Curso from "../../../infra/entity/Curso";
import AppError from "../../../infra/errors/AppError";

export default class ListCursosService {

  public async execute(): Promise<Curso[]> {
    const repository = getRepository(Curso);

    var cursos = await repository.find();
    if (!cursos || cursos.length == 0) {
      throw new AppError('Nenhum Curso encontrado', 400);
    }

    cursos = cursos.map(c => {
      delete c.created_at;
      delete c.updated_at;
      delete c.curso_id;
      return c;
    });

    return cursos;
  }

}