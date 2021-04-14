import { MigrationInterface, QueryRunner, TableColumn, TableForeignKey } from "typeorm";

export class AlterUserCurso1618267930291 implements MigrationInterface {

    public async up(qr: QueryRunner): Promise<void> {
        await qr.dropColumn('users', 'curso');
        await qr.addColumn('users', new TableColumn({
            name: 'curso_id',
            type: 'uuid',
            isNullable: true
        }));

        await qr.createForeignKey('users', new TableForeignKey({
            name: 'cursoUser',
            columnNames: ['curso_id'],
            referencedColumnNames: ['curso_id'],
            referencedTableName: 'cursos',
            onDelete: 'SET NULL',
            onUpdate: 'CASCADE'
        }));
    }

    public async down(qr: QueryRunner): Promise<void> {
        await qr.dropForeignKey('users', 'cursoUser');
        await qr.dropColumn('users', 'curso_id');
        await qr.addColumn('users', new TableColumn({
            name: 'curso',
            type: 'varchar'
        }));
    }

}
