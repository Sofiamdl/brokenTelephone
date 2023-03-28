import fastify from "fastify";
import { appRoutes } from "./http/router";
import { createGameRooms } from "./socket/socket";

export const app = fastify()

app.register(appRoutes);
app.register(createGameRooms);