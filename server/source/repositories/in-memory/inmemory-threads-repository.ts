import { IThreadsRepository, IGameObject, IThreadObject } from "../threads-repository";

export class InMemoryThreadRepository implements IThreadsRepository {
    public threads: IThreadObject = {};

    async createRoomThreads(users: string[]) {
        for (const user of users) {

            this.threads[user] = []
        }

        return this.threads;
    }

    async addGameObjectToThread(userId: string, gameObject: IGameObject) {
        this.threads[userId].push(gameObject);

        return this.threads;
    }

    async findThreadByUserId(userId: string) {        
        return this.threads[userId]
    }

}