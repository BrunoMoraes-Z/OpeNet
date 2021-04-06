import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from "typeorm";

@Entity('users')
export default class User {

    @PrimaryGeneratedColumn('uuid')
    user_id: string;

    @Column()
    first_name: string;

    @Column()
    last_name: string;

    @Column()
    email: string;

    @Column()
    curso: string;

    @Column()
    periodo: number;

    @Column()
    dt_nascimento: Date;

    @Column()
    password: string;

    @Column()
    g_id: string;

    @CreateDateColumn()
    created_at: Date;

    @UpdateDateColumn()
    updated_at: Date;

}