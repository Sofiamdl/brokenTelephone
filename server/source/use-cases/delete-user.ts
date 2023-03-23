import { User } from "@prisma/client";
import { IUsersRepository } from "../repositories/users-repository";

interface IDeleteUserUseCaseRequest {
    id: string
}

interface IDeleteUserUseCaseResponse {
    user: User
}

export class DeleteUserUseCase {
    constructor (private usersRepository: IUsersRepository) {}

    async handle({
        id,
    }: IDeleteUserUseCaseRequest): Promise<IDeleteUserUseCaseResponse> {
        const user = await this.usersRepository.findById(id)

        if(!user) {
            throw new Error("Bad request.")
        }

        const deletedUser = await this.usersRepository.delete(id);

        return {
            user: deletedUser,
        };
    }
}