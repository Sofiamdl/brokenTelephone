import { IGameObject } from "./threads-repository";

export interface IVotedThread {
    [roomId: string]: IGameObject[]
}

export interface IVotedRepository {
    create(gameRoomCode: string): Promise<IVotedThread>;
    addGameObjetToVoted(gameObject: IGameObject, gameRoomCode: string): Promise<IGameObject>;
    saveGameObjectToThread(gameRoomCode: string, gameObjectId: string, newLikes: number): Promise<IGameObject | null>;
    findById(gameRoomCode: string, gameObjectId: string): Promise<IGameObject | null>;
}