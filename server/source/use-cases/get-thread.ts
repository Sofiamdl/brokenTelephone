import { IThreadsRepository, IGameObject } from "../repositories/threads-repository"

interface IGetTreadUseCaseRequest {
    id: string
}

interface IGetTreadUseCaseReply {
    thread: IGameObject[]
}

export class GetThreadUseCase {
    constructor(private threadsRepository: IThreadsRepository) {}

    async handle({
        id,
    }: IGetTreadUseCaseRequest): Promise<IGetTreadUseCaseReply> {
        const thread = await this.threadsRepository.findThreadByUserId(id);

        return {
            thread,
        }
    }
}