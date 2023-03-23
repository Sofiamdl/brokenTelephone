import { User, Prisma } from "@prisma/client";
import { IUsersRepository } from "../users-repository";
import { prisma } from "../../lib/prisma";

export class PrismaUsersRepository implements IUsersRepository {
    async findByIdAndToken(id: string, token: string) {
        console.log(id)
        console.log(token)

        const user = await prisma.user.findFirst({
            where: {
                id
            }
        })

       return user;
    }

    async create(data: Prisma.UserCreateInput) {
        const createdUser = await prisma.user.create({
            data
        })
    
        return createdUser;
    }

    async delete(id: string) {
        const user = await prisma.user.delete({
            where: {
                id
            }
        })

        return user;
    }

}