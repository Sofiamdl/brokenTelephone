import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IVotedRepository } from "../../repositories/voted-repository";
import { IThreadsRepository } from "../../repositories/threads-repository";

export async function vote(socket: Socket, gameRepository: IGamesRepository, votedRepository: IVotedRepository, threadRepository: IThreadsRepository, data: any) {
    const gameObjectId = data;

    const { code } = await gameRepository.findRoomByUserId(socket.id);

    const gameObject = await threadRepository.findGameObjectInThreadById(socket.id, gameObjectId);

    if (!gameObject) {
        return null;
    }

    const existingGameObject = await votedRepository.findById(code, gameObjectId)

    if (existingGameObject) {
        await votedRepository.saveGameObjectToThread(code, gameObjectId, existingGameObject.votes + 1);
    } else {
        gameObject.votes++;
        await votedRepository.addGameObjetToVoted(gameObject, code);
    }
}