import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import Question from "./Question";
import User from "./User";

@Entity('answers')
export default class Answer {

  @PrimaryGeneratedColumn('uuid')
  answer_id: string;

  @Column()
  author_id: string;

  @ManyToOne(() => User)
  @JoinColumn({name: 'user_id'})
  author: User;

  @Column()
  question_id: string;

  @OneToOne(() => Question)
  @JoinColumn({name: 'question_id'})
  question: Question;

  @Column()
  content: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}