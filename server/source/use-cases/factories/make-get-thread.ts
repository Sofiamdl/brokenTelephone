import { InMemoryThreadRepository } from "../../repositories/in-memory/inmemory-threads-repository"
import { GetThreadUseCase } from "../get-thread";

export function makeGetThreadUseCase() {
    const threadsRepository = InMemoryThreadRepository.getInstance();
    const getThreadUseCase = new GetThreadUseCase(threadsRepository);

    return getThreadUseCase;
}