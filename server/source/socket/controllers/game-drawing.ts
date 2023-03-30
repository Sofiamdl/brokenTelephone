import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IGameObject, IThreadsRepository } from "../../repositories/threads-repository";
import { GameIndexCalculator } from "../../utilities/game-index-calculator";

export async function gameDrawing(socket: Socket, gameRepository: IGamesRepository, threadRepository: IThreadsRepository, gameIndexCalculator: GameIndexCalculator, data: any) {
    const gameObject: IGameObject = {
        data,
        type: "drawing",
        userId: socket.id,
    }

    const room = await gameRepository.findRoomByUserId(socket.id);

    const userIndex = room.users.findIndex(item => item.id === socket.id);

    const parentThread = gameIndexCalculator.getParentThreadIndex(room.round, room.users.length, userIndex);

    threadRepository.addGameObjectToThread(room.users[parentThread].id, gameObject);
}