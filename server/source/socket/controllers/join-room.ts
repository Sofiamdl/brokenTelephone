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
        await gameRepository.addUserToGameRoom({
            id: socket.id,
            name: socket.id,
            roomCode,
            score: 0,
        }, roomCode)

        const user = await gameRepository.findUserInRoom(socket.id, roomCode)

        if(!user) {
            throw new Error();
        }

        io.to(roomCode).emit("new_player", user?.name);
        socket.emit("joined", true)
    }
}