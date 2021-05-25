import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, JoinColumn, OneToOne } from "typeorm";
import Curso from "./Curso";

@Entity('users')
export default class User {

    @PrimaryGeneratedColumn('uuid')
    user_id: string;

    @Column()
    first_name: string;

    @Column()
    last_name: string;

    @Column()
    user_name: string;

    @Column()
    email: string;

    @Column()
    curso_id: string;

    @JoinColumn({ name: 'curso_id' })
    curso: Curso;

    @Column()
    periodo: number;

    @Column()
    ano_curso: number;

    @Column()
    dt_nascimento: Date;

    @Column()
    password: string;

    @Column()
    g_id: string;

    @Column()
    pending: boolean;

    @CreateDateColumn()
    created_at: Date;

    @UpdateDateColumn()
    updated_at: Date;

}