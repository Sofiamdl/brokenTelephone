import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";

export async function joinRoom(socket: Socket, gameRepository: IGamesRepository, data: any) {
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

        socket.emit("joined", true)
    }
}