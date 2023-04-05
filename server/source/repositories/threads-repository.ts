
export interface IGameObject {
    id: string
    userId: string
    type: string
    data: string
    votes: number
}

export interface IThreadObject {
    [userId: string]: IGameObject[]
    
}

export interface IThreadsRepository {
    createRoomThreads(users: string[]): Promise<IThreadObject>
    addGameObjectToThread(userId: string, gameObject: IGameObject): Promise<IThreadObject>
    findThreadByUserId(userId: string): Promise<IGameObject[]>
    findGameObjectInThreadById(userId: string, gameObjectId: string): Promise<IGameObject | null>;
}