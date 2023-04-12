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
import { IVotedRepository } from "../repositories/voted-repository";
import { InMemoryVotedRepository } from "../repositories/in-memory/inmemory-voted-repository";
import { vote } from "./controllers/vote";



export async function createGameRooms(app: FastifyInstance)  {
    app.register(fastifySocketIO);

    const gameRepository: IGamesRepository = new InMemoryGamesRepository();
    const phrasesRepository: IPhrasesRepository = new InMemoryPhrasesRepository();
    const votedRepository: IVotedRepository = new InMemoryVotedRepository();
    const gameIndexCalculator: GameIndexCalculator = new GameIndexCalculator();
    const threadRepository = InMemoryThreadRepository.getInstance();

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
                joinRoom(socket, gameRepository, data, app.io);
            })

            socket.on("play", async function(data) {
                play(socket, phrasesRepository, gameRepository, threadRepository, votedRepository, data, app.io);
            })

            socket.on("game", async function(data) {
                game(socket, gameRepository, threadRepository, gameIndexCalculator, data, app.io);
            })

            socket.on("host-timeout", async function(data) {
                hostTimeout(socket, gameRepository, threadRepository, gameIndexCalculator, data, app.io);
            })

            socket.on("vote", async function(data) {
                vote(socket, gameRepository, votedRepository, threadRepository, data);
            })

            socket.on("get-threads", async function(data) {
                const room = await gameRepository.findRoomByUserId(socket.id);

                for(const user of room.users) {
                    const thread = await threadRepository.findThreadByUserId(user.id);
                    app.io.to(room.code).emit("threads", { data: thread });
                    console.log(thread)
                }
            })


        })

    })
}
