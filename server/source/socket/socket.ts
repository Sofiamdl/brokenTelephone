import { FastifyInstance } from "fastify";
import fastifySocketIO from "fastify-socket.io";
import { IGamesRepository } from "../repositories/games-repository";
import { InMemoryGamesRepository } from "../repositories/in-memory/inmemory-game-repository";
import { IGameObject, IThreadsRepository } from "../repositories/threads-repository";
import { InMemoryThreadRepository } from "../repositories/in-memory/inmemory-threads-repository";
import { IPhrasesRepository } from "../repositories/phrases-repository";
import { InMemoryPhrasesRepository } from "../repositories/in-memory/inmemory-phrases-repository";
import { createRoom } from "./controllers/create-room";
import { joinRoom } from "./controllers/join-room";
import { play } from "./controllers/play";
import { GameIndexCalculator } from "../utilities/game-index-calculator";
import { game } from "./controllers/game";
import { hostTimeout } from "./controllers/timeout";



export async function createGameRooms(app: FastifyInstance)  {
    app.register(fastifySocketIO);

    const gameRepository: IGamesRepository = new InMemoryGamesRepository();
    const threadRepository: IThreadsRepository = new InMemoryThreadRepository();
    const phrasesRepository: IPhrasesRepository = new InMemoryPhrasesRepository();
    const gameIndexCalculator: GameIndexCalculator = new GameIndexCalculator();

    app.ready(err => {
        if (err) {
            throw err
        }

        app.io.on("connect", (socket) => {
            console.log(`Connection: ${socket.id}`)

            socket.on("create_room", function(data) {
                createRoom(socket, gameRepository);
            })

            socket.on("join_room", function(data) {
                joinRoom(socket, gameRepository, data);
            })

            socket.on("play", function(data) {
                play(socket, phrasesRepository, gameRepository, threadRepository, data, app.io);
            })

            socket.on("game", async function(data) {
                game(socket, gameRepository, threadRepository, gameIndexCalculator, data, app.io);
            })

            socket.on("host-timeout", async function(data) {
                hostTimeout(socket, gameRepository, threadRepository, gameIndexCalculator, data, app.io);
            })


        })

    })
}
