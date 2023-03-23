import { User } from "@prisma/client";
import { IUsersRepository } from "../repositories/users-repository";

interface IGetUserUseCaseRequest {
    id: string
}

interface IGetUserUseCaseResponse {
    user: User
}

export class GetUserUseCase {
    constructor (private usersRepository: IUsersRepository) {}

    async handle({
        id,
    }: IGetUserUseCaseRequest): Promise<IGetUserUseCaseResponse> {
        const user = await this.usersRepository.findById(id)

        if(!user) {
            throw new Error("Bad request.")
        }

        return {
            user,
        };
    }
}