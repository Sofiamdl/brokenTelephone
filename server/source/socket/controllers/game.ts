import { Server, Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IGameObject, IThreadsRepository } from "../../repositories/threads-repository";
import { GameIndexCalculator } from "../../utilities/game-index-calculator";
import { randomUUID } from "crypto";

export async function game(socket: Socket, gameRepository: IGamesRepository, threadRepository: IThreadsRepository, gameIndexCalculator: GameIndexCalculator, data: any, io: Server) {
    const room = await gameRepository.findRoomByUserId(socket.id);

    const gameObject: IGameObject = {
        id: randomUUID(),
        data,
        type: (room.round % 2) === 0 ? "phrase" : "drawing",
        userId: socket.id,
        votes: 0,
    }

    const userIndex = room.users.findIndex(item => item.id === socket.id);

    const parentThread = gameIndexCalculator.getParentThreadIndex(room.round - 1, room.users.length, userIndex);

    await threadRepository.addGameObjectToThread(room.users[parentThread].id, gameObject);
    let nextIndex
    if (room.round <= 1){
        nextIndex = gameIndexCalculator.getIndexToNext(room.round, room.users.length, userIndex);
    } else {
        nextIndex = gameIndexCalculator.getIndexToNext(1, room.users.length, userIndex);
    }
    io.to(room.users[nextIndex].id).emit((room.round % 2) === 0 ? "phrase": "drawing", data);
    
}
