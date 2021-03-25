import 'reflect-metadata';

import * as express from 'express';
import 'express-async-errors';
import * as cors from 'cors';
import routes from './infra/routes';
import AppError from './infra/errors/AppError';

import './infra/database';

const app = express();
app.use(cors());
app.use(express.json());
app.use(routes);

app.use((err: Error, request: express.Request, response : express.Response, next: express.NextFunction) => {
  if (err instanceof AppError) {
    return response.status(err.statusCode).json({
      status: 'error',
      message: err.message
    });
  }
  return response.status(500).json({
    status: 'error',
    message: 'Internal Server Error.'
  });
});

app.listen(3333, () => {
  console.log('🚀 Servidor ligado');
});