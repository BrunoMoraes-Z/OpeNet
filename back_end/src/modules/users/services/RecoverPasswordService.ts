import User from "../../../infra/entity/User";
import * as path from 'path';
import Mail from "../../../infra/services/mailService";
import MailTemplateService from '../../../infra/services/mailTemplateService';

export default class RecoverPasswordService {

  public async execute(user: User): Promise<string> {
    const filePath = path.resolve(__dirname, '..', '..', '..', 'infra', 'views', 'recover.hbs');

    const content = await new MailTemplateService().parse({
      file: filePath, variables: {
        name: user.first_name,
        link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
      }
    });
    
    Mail.to = user.email;
    Mail.subject = 'Solicitação para configurar nova senha';
    Mail.message = content;
    Mail.sendMail();

    return 'E-Mail enviado com sucesso.';
  }

}