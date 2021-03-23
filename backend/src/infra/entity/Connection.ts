import { Column, CreateDateColumn, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import User from "./User";

@Entity('connections')
export default class Connection {

  @PrimaryGeneratedColumn('uuid')
  connection_id: string;

  @Column()
  user_1_id: string

  @OneToOne(() => User)
  @JoinColumn({name: 'user_id'})
  user_1: User

  @Column()
  user_2_id: string

  @OneToOne(() => User)
  @JoinColumn({name: 'user_id'})
  user_2: User

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}