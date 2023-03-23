import { FastifyInstance } from "fastify";
import fastifySocketIO from "fastify-socket.io";
import { generateRandomRoomCode } from "../utilities/generateRandomRoomCode";


export async function createGameRooms(app: FastifyInstance)  {
    app.register(fastifySocketIO);

    app.ready(err => {
        if (err) {
            throw err
        }

        app.io.on("connect", (socket) => {
            console.log(`Connection: ${socket.id}`)

            socket.on("create_room", function(data) {
                console.log("Creating room...")
                const roomCode = generateRandomRoomCode();
                socket.join(roomCode);
                socket.emit("code", roomCode);
            })

            socket.on("join_room", function(data) {
                console.log("Joining room...")
                const roomCode = data;
                socket.join(roomCode);
            })
        })

    })
}