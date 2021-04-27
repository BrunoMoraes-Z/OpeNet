import { Router } from 'express';
import UserController from '../controllers/UserController';

const userController = new UserController();
const routers = Router();

routers.post('/', userController.create);
routers.post('/recover', userController.recover);
routers.get('/has', userController.hasUser);
routers.get('/available', userController.available);

export default routers;