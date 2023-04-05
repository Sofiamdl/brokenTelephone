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

        console.log(this.threads);

        return this.threads;
    }

    async findThreadByUserId(userId: string) {        
        return this.threads[userId]
    }

    async findGameObjectInThreadById(userId: string, gameObjectId: string) {
        const gameObject = this.threads[userId].find(item => item.id === gameObjectId);

        if(!gameObject) {
            return null
        }

        return gameObject
    }
}