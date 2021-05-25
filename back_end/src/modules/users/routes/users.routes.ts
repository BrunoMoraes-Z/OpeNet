import { Router } from 'express';
import UserController from '../controllers/UserController';

const userController = new UserController();
const routers = Router();

routers.post('/', userController.create);
routers.post('/recover', userController.recover);
routers.get('/has', userController.hasUser);
routers.get('/available', userController.available);
routers.get('/pending', userController.listPending);
routers.patch('/pending', userController.acceptPending);
routers.delete('/pending', userController.rejectPending);

export default routers;