import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { generateRandomRoomCode } from "../../utilities/generateRandomRoomCode";

export function createRoom(socket: Socket, gameRepository: IGamesRepository) {
    console.log("Creating room...")
    const roomCode = generateRandomRoomCode();

    gameRepository.createRoom(roomCode, {
        id: socket.id,
        name: socket.id,
        roomCode,
        score: 0,
    })

    socket.join(roomCode);
    socket.emit("code", roomCode);
}