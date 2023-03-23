import { PrismaUsersRepository } from "../../repositories/prisma/prisma-users-repository";
import { AuthUseCase } from "../auth-user";

export function makeAuthUseCase() {
    const userRepository = new PrismaUsersRepository();
    const authUseCase = new AuthUseCase(userRepository);

    return authUseCase;
}