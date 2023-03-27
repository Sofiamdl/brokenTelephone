
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
    createRoom(IgameRoom: IGameRoom, host: IGameUser): Promise<IGameRoom>;
    findRoomByCode(code: string): Promise<IGameRoom | null>;
    removeIGameRoom(IgameRoomId: string): Promise<IGameRoom>;
    
    addUserToIGameRoom(user: IGameUser, IgameRoomId: string): Promise<IGameRoom>;
    findUserInRoom(userId: string, IgameRoomId: string): Promise<IGameUser | null>;
    removeUserFromIGameRoom(userId: string, gameId: string): Promise<IGameRoom>;
    
    updateUserScore(userId: string, newScore: number): Promise<IGameUser>;
}