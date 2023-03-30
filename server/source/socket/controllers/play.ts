import { Server, Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IPhrasesRepository } from "../../repositories/phrases-repository";
import { IGameObject, IThreadsRepository } from "../../repositories/threads-repository";

export async function play(socket: Socket, phrasesRepository: IPhrasesRepository, gameRepository: IGamesRepository, threadRepository: IThreadsRepository, data: any, io: Server) {
    const roomCode = data;

    const room = await gameRepository.findRoomByCode(roomCode)
    
    if(!room) {
        throw new Error("Bad request")
    }

    const users = room.users

    const usersIds = users.map(({id}) => id)
    const thread = await threadRepository.createRoomThreads(usersIds)
    console.log(thread)

    const phrases = await phrasesRepository.findMany(users.length)

    for (let i = 0; i< users.length; i++){
        io.to(users[i].id).emit("phrase", phrases[i])
        const userGameObject: IGameObject = { data:phrases[i], type: "phrase", userId:users[i].id}
        await threadRepository.addGameObjectToThread(users[i].id, userGameObject)
    }

}
// JOGO var = (indiceUsuarioNoArray + 1) mod (quantidadeUsuarios)