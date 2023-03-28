import { FastifyInstance } from "fastify";
import fastifySocketIO from "fastify-socket.io";
import { IGamesRepository } from "../repositories/games-repository";
import { IThreadsRepository } from "../repositories/threads-repository";
import { InMemoryThreadRepository } from "../repositories/in-memory/inmemory-threads-repository";
import { InMemoryGamesRepository } from "../repositories/in-memory/inmemory-game-repository";
import { generateRandomRoomCode } from "../utilities/generateRandomRoomCode";



export async function createGameRooms(app: FastifyInstance)  {
    app.register(fastifySocketIO);

    const gameRepository: IGamesRepository = new InMemoryGamesRepository();
    const threadRepository: IThreadsRepository = new InMemoryThreadRepository();

    app.ready(err => {
        if (err) {
            throw err
        }

        app.io.on("connect", (socket) => {
            console.log(`Connection: ${socket.id}`)

            socket.on("create_room", function(data) {
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
            })

            socket.on("join_room", function(data) {
                console.log("Joining room...")

                const roomCode = data;
                const room = gameRepository.findRoomByCode(roomCode)

                if(!room) {
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
            })
        })

    })
}