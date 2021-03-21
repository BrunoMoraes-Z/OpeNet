import { Column, CreateDateColumn, Entity, JoinColumn, ManyToMany, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import User from "./User";

@Entity('opportunitys')
export default class Opportunity {

  @PrimaryGeneratedColumn('uuid')
  opportunity_id: string;

  @ManyToOne(() => User)
  @JoinColumn({name: 'user_id'})
  author: User;

  @Column()
  tittle: string;

  @Column()
  description: string;

  @Column()
  requirements: string;

  @Column()
  benefits: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

}