
export interface IGameObject {
    userId: string
    type: string
    data: string
}

export interface IThreadObject {
    [userId: string]: IGameObject[]
    
}

export interface IThreadsRepository {
    createRoomThreads(users: string[]): Promise<IThreadObject>
    addGameObjectToThread(userId: string, gameObject: IGameObject): Promise<IThreadObject>
    findThreadByUserId(userId: string): Promise<IGameObject[]>
}