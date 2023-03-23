import fastify from "fastify";
import { appRoutes } from "./http/router";

export const app = fastify()

app.register(appRoutes);