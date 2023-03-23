import { FastifyInstance } from "fastify";
import { auth } from "./controllers/users/auth-user";

export async function appRoutes(app: FastifyInstance) {
    app.post("/auth", auth);
}