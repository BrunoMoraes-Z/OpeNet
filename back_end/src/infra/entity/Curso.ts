import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";

@Entity('cursos')
export default class Curso {

  @PrimaryGeneratedColumn('uuid')
  curso_id: string;
  
  @Column()
  name: string;

  @Column()
  max_periodo: number;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}