import { User } from "@prisma/client";
import { IUsersRepository } from "../repositories/users-repository";
import { compare, hash } from "bcryptjs";

interface IAuthUseCaseRequest {
    id: string
    name: string
    email: string
    token: string
}

interface IAuthUseCaseResponse {
    user: User
}

export class AuthUseCase {
    constructor (private usersRepository: IUsersRepository) {}

    async handle({
        id,
        name,
        email,
        token,
    }: IAuthUseCaseRequest): Promise<IAuthUseCaseResponse> {
        const token_hash = await hash(token, 6);

        const existingUser = await this.usersRepository.findById(id);

        if(existingUser) {
            console.log("HERE")

            const tokenMatches = await compare(token, existingUser.token)

            if (!tokenMatches) {
                throw new Error("Wrong credentials");
            }

            return {
                user: existingUser
            }
        }

        const user = await this.usersRepository.create({
            id,
            name,
            email,
            token: token_hash,
        })

        return {
            user,
        };
    }
}