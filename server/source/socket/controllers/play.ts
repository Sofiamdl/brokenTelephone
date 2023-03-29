import { Server, Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IPhrasesRepository } from "../../repositories/phrases-repository";

export async function play(socket: Socket, phrasesRepository: IPhrasesRepository, gameRepository: IGamesRepository, data: any, io: Server) {
    const roomCode = data;
    const room = await gameRepository.findRoomByCode(roomCode)

    const users = room.users

    const phrases = await phrasesRepository.findMany(users.length)

    for (let i = 0; i< users.length; i++){
        io.to(users[i].id).emit("phrase", phrases[i])
    }
    //criar thread
    // pego o vetor de usuarios, pra cada um da um emit com a frase dele

}

// export interface IGameUser {
//     name: string
//     id: string
//     score: number
//     roomCode: string
// }