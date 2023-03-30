import { IGameRoom, IGamesRepository, IGameUser } from "../games-repository"

export class InMemoryGamesRepository implements IGamesRepository {
    public gameRooms: IGameRoom[] = [];

    async createRoom(gameRoomCode: string, host: IGameUser) {
        const newGameRoom: IGameRoom = {
            code: gameRoomCode,
            hostId: host.id,
            users: [host],
        }
        
        this.gameRooms.push(newGameRoom);

        console.log(this.gameRooms);

        return newGameRoom;
    }

    async findRoomByCode(gameRoomCode: string) {
        console.log(gameRoomCode)
        const room = this.gameRooms.find(item => item.code === gameRoomCode);
        console.log(room)

        if (!room) {
            return null;
        }

        return room;
    }

    async removeGameRoom(gameRoomCode: string) {
        const roomIndex = this.gameRooms.findIndex(item => item.code === gameRoomCode);

        const deletedRoom = this.gameRooms[roomIndex];

        const newRooms = this.gameRooms.splice(roomIndex, 1);

        this.gameRooms = newRooms;

        return deletedRoom;
    }

    async findUserInRoom(userId: string, gameRoomCode: string) {
        const gameRoom = this.gameRooms.find(item => item.code === gameRoomCode);

        if(!gameRoom) {
            return null;
        }

        const userInRoom = gameRoom.users.find(item => item.id === userId);

        if(!userInRoom) {
            return null;
        }

        return userInRoom;
    }

    async saveGameUser(user: IGameUser) {
        const gameRoomIndex = this.gameRooms.findIndex(item => item.code === user.roomCode);

        if(gameRoomIndex < 0) {
            throw new Error();
        }

        const userIndex = this.gameRooms[gameRoomIndex].users.findIndex(item => item.id === user.id);

        if(userIndex < 0) {
            throw new Error();
        }

        this.gameRooms[gameRoomIndex].users[userIndex] = user;

        return this.gameRooms[gameRoomIndex].users[userIndex];
    }

    async addUserToGameRoom(user: IGameUser, gameRoomCode: string) {
        const gameRoomIndex = this.gameRooms.findIndex(item => item.code === gameRoomCode);

        if(gameRoomIndex < 0) {
            throw new Error();
        }

        this.gameRooms[gameRoomIndex].users.push(user);

        console.log(this.gameRooms);

        return this.gameRooms[gameRoomIndex];
    }

    async removeUserFromGameRoom(userId: string, gameRoomCode: string) {
        const gameRoomIndex = this.gameRooms.findIndex(item => item.code === gameRoomCode);

        if(gameRoomIndex < 0) {
            throw new Error();
        }

        const userIndex = this.gameRooms[gameRoomIndex].users.findIndex(item => item.id === userId);

        if(userIndex < 0) {
            throw new Error();
        }

        const newRoomUsers = this.gameRooms[gameRoomIndex].users.splice(userIndex, 1);

        this.gameRooms[gameRoomIndex] = {
            code: this.gameRooms[gameRoomIndex].code,
            hostId: this.gameRooms[gameRoomIndex].hostId,
            users: newRoomUsers,
        };

        return this.gameRooms[gameRoomIndex];
    }
}