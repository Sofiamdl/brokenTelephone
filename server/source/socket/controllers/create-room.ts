import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { generateRandomRoomCode } from "../../utilities/generateRandomRoomCode";

export async function createRoom(socket: Socket, gameRepository: IGamesRepository) {
    console.log("Creating room...")
    const roomCode = generateRandomRoomCode();

    await gameRepository.createRoom(roomCode, {
        id: socket.id,
        name: socket.id,
        roomCode,
        score: 0,
        votes: 0,
    })

    socket.join(roomCode);
    socket.emit("code", roomCode);
    socket.emit("new-player", socket.id);
}