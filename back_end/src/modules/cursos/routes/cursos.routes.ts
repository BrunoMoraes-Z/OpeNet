import { Router } from 'express';

import CursoController from '../controllers/CursoController';

const cursoController = new CursoController();
const routers = Router();

routers.get('/', cursoController.list);

export default routers;