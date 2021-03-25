import { Column, CreateDateColumn, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import User from "./User";

@Entity('questions')
export default class Question {

  @PrimaryGeneratedColumn('uuid')
  question_id: string;

  @Column()
  auhor_id: string

  @OneToOne(() => User)
  @JoinColumn({name: 'user_id'})
  author: User

  @Column()
  title: string;

  @Column()
  description: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}