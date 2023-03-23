import { PrismaUsersRepository } from "../../repositories/prisma/prisma-users-repository";
import { GetUserUseCase } from "../get-user";

export function makeGetUserUseCase() {
    const userRepository = new PrismaUsersRepository();
    const getUserUseCase = new GetUserUseCase(userRepository);

    return getUserUseCase;
}