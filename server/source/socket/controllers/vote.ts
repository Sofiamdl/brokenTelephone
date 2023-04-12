import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IVotedRepository } from "../../repositories/voted-repository";
import { IThreadsRepository } from "../../repositories/threads-repository";

export async function vote(socket: Socket, gameRepository: IGamesRepository, votedRepository: IVotedRepository, threadRepository: IThreadsRepository, data: any) {
    console.log("IN voted")

    const gameObjectId = data;

    const { code, users } = await gameRepository.findRoomByUserId(socket.id);

    let gameObject = await threadRepository.findGameObjectInThreadById(socket.id, gameObjectId);

    if (!gameObject) {
        for (const user of users) {
            gameObject = await threadRepository.findGameObjectInThreadById(user.id, gameObjectId);
            if(gameObject != null) {
                break;
            }
        }
    }

    if(!gameObject) {
        throw new Error();
    }

    if (!gameObject) {
        console.log("NULL")
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