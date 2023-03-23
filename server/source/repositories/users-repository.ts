import { Prisma, User } from "@prisma/client";

export interface IUsersRepository {
    findByIdAndToken(id: string, token: string): Promise<User | null>;
    create(data: Prisma.UserCreateInput): Promise<User>;
    delete(id: string): Promise<User | null>;
}