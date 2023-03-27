
export interface GameUser {
    name: string
    id: string
    score: number
}

export interface GameRoom {
    hostId: string
    code: string
    users: GameUser[];
}

export interface GamesInterface {
    createRoom(gameRoom: GameRoom, host: GameUser): Promise<GameRoom>;
    findRoomByCode(code: string): Promise<GameRoom | null>;
    removeGameRoom(gameRoomId: string): Promise<GameRoom>;
    
    addUserToGameRoom(user: GameUser, gameRoomId: string): Promise<GameRoom>;
    findUserInRoom(userId: string, gameRoomId: string): Promise<GameUser | null>;
    removeUserFromGameRoom(userId: string, gameId: string): Promise<GameRoom>;
    
    updateUserScore(userId: string, newScore: number): Promise<GameUser>;
}