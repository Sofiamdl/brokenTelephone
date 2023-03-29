import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";

export function joinRoom(socket: Socket, gameRepository: IGamesRepository, data: any) {
    console.log("Joining room...")

    const roomCode = data;
    const room = gameRepository.findRoomByCode(roomCode)

    if (!room) {
        console.log("Sala nao existe")
    } else {
        socket.join(roomCode);
        gameRepository.addUserToGameRoom({
            id: socket.id,
            name: socket.id,
            roomCode,
            score: 0,
        }, roomCode)
    }
}