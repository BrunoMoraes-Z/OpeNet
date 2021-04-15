import * as handlebars from 'handlebars';
const fs = require('fs');

interface ITemplate {
  file: string;
  variables: any;
}

export default class MailTemplateService {

  public async parse({file, variables}: ITemplate): Promise<string> {
    const content = await fs.promises.readFile(file, {
      encoding: 'utf-8',
    });
    const template = handlebars.compile(content);
    return template(variables);
  }

}