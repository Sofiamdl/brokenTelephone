
export interface IGameUser {
    name: string
    id: string
    score: number
}

export interface IGameRoom {
    hostId: string
    code: string
    users: IGameUser[];
}

export interface IGamesInterface {
    createRoom(code: string, host: IGameUser): Promise<IGameRoom>;
    findRoomByCode(code: string): Promise<IGameRoom | null>;
    removeGameRoom(gameRoomId: string): Promise<IGameRoom>;
    
    addUserToGameRoom(user: IGameUser, gameRoomId: string): Promise<IGameRoom>;
    findUserInRoom(userId: string, gameRoomId: string): Promise<IGameUser | null>;
    removeUserFromGameRoom(userId: string, gameId: string): Promise<IGameRoom>;
    
    updateUserScore(userId: string, newScore: number): Promise<IGameUser>;
}