import { Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IPhrasesRepository } from "../../repositories/phrases-repository";

export function play(socket: Socket, phrasesRepository: IPhrasesRepository, gameRepository: IGamesRepository, data: any) {
    const roomCode = data;
    const room = gameRepository.findRoomByCode(roomCode)

    room.then(function (val) {
        val.users.length
        console.log(val);
    })
    const phrases = phrasesRepository.findMany(6)
    //criar thread
    // pego o vetor de usuarios, pra cada um da um emit com a frase dele

}