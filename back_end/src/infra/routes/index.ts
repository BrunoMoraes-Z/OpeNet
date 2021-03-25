import { Router } from 'express';
import SessionController from '../../modules/users/controllers/SessionController';

import usersRouter from '../../modules/users/routes/users.routes';

const routes = Router();
const sessionController = new SessionController();

routes.use('/users', usersRouter);
routes.post('/sessions', sessionController.create);

export default routes;