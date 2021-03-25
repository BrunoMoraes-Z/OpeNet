import * as crypto from 'crypto';
import * as path from 'path';
import * as multer from 'multer';

const tmpFolder = path.resolve(__dirname, '..', '..', 'temp');

export default {
  directory: tmpFolder,
  storage: multer.diskStorage({
    destination: tmpFolder,
    filename (request, file, callback) {
      const hash = crypto.randomBytes(10).toString('hex');
      const name = `${hash}-${file.originalname}`;
      return callback(null, name);
    }
  })
}