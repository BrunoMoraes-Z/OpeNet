import * as nodemailer from 'nodemailer';

import config from '../../config/auth';
import AppError from '../errors/AppError';

class MailService {

  constructor(
    public to?: string,
    public subject?: string,
    public message?: string
  ) { }

  public sendMail() {
    let options = {
      from: config.mail.user,
      to: this.to,
      subject: this.subject,
      html: this.message
    };
    const transporter = nodemailer.createTransport(
      {
        host: config.mail.host,
        port: config.mail.post,
        secure: false,
        auth: {
          user: config.mail.user,
          pass: config.mail.password
        },
        tls: {
          rejectUnauthorized: false
        }
      }
    );

    if (config.mail.user.trim().length > 0 && config.mail.password.trim().length > 0) {
      transporter.sendMail(options, (error, info) => {
        if (error) {
          return error;
        } else {
          return 'Email Enviado com sucesso!';
        }
      });
    } else {
      console.log();
      console.log('Nenhuma conta para envio de mensagems configurada.');
      console.log();
    }
  }

}

export default new MailService;