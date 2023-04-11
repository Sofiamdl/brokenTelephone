import { Server, Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";

export async function joinRoom(socket: Socket, gameRepository: IGamesRepository, data: any, io: Server) {
    console.log("Joining room...")

    const roomCode = data;
    const room = await gameRepository.findRoomByCode(roomCode)

    if (!room) {
        console.log("Sala nao existe")

        socket.emit("joined", false)
    } else {
        socket.join(roomCode);

        for(const user of room.users) {
            socket.emit("new-player", user.id);
        }

        await gameRepository.addUserToGameRoom({
            id: socket.id,
            name: socket.id,
            roomCode,
            score: 0,
        }, roomCode)

        io.to(roomCode).emit("new-player", socket.id);

        socket.emit("joined", true)
    }
}