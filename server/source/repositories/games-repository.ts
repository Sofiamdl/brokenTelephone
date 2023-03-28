
export interface IGameUser {
    name: string
    id: string
    score: number
    roomCode: string
}

export interface IGameRoom {
    hostId: string
    code: string
    users: IGameUser[];
}

export interface IGamesInterface {
    createRoom(gameRoomCode: string, host: IGameUser): Promise<IGameRoom>;
    findRoomByCode(gameRoomCode: string): Promise<IGameRoom | null>;
    removeGameRoom(gameRoomCode: string): Promise<IGameRoom>;
    
    addUserToGameRoom(user: IGameUser, gameRoomCode: string): Promise<IGameRoom>;
    findUserInRoom(userId: string, gameRoomCode: string): Promise<IGameUser | null>;
    removeUserFromGameRoom(userId: string, gameRoomCode: string): Promise<IGameRoom>;
    
    saveGameUser(user: IGameUser): Promise<IGameUser>;
}