import { InsertQueryBuilder, MigrationInterface, QueryRunner } from "typeorm";

export class PopulateCursos1621899990539 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.manager.createQueryBuilder()
            .insert().into('cursos')
            .values([
                { name: 'Administração', max_periodo: 8 },
                { name: 'Análise Desenvolvimento De Sistema', max_periodo: 5 },
                { name: 'Arquitetura e Urbanismo', max_periodo: 10 },
                { name: 'Biomedicina', max_periodo: 8 },
                { name: 'Ciências Contábeis', max_periodo: 8 },
                { name: 'Comércio Exterior', max_periodo: 4 },
                { name: 'Direito', max_periodo: 10 },
                { name: 'Engenharia Civil', max_periodo: 10 },
                { name: 'Engenharia De Produção', max_periodo: 10 },
                { name: 'Engenharia Mecânica', max_periodo: 10 },
                { name: 'Estética e Cosmética', max_periodo: 6 },
                { name: 'Fisioterapia', max_periodo: 10 },
                { name: 'Gestão de Recursos Humanos', max_periodo: 4 },
                { name: 'Gestão Financeira', max_periodo: 4 },
                { name: 'Logística', max_periodo: 4 },
                { name: 'Marketing', max_periodo: 4 },
                { name: 'Medicina Veterinária', max_periodo: 10 },
                { name: 'Nutrição', max_periodo: 8 },
                { name: 'Processos Gerencias', max_periodo: 4 },
                { name: 'Psicologia', max_periodo: 10 },
                { name: 'Publicidade e Propaganda', max_periodo: 8 },
            ]).execute();
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.dropTable('cursos');
    }

}
