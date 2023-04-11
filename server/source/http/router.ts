import { FastifyInstance } from "fastify";
import { auth } from "./controllers/users/auth-user";
import { deleteUser } from "./controllers/users/delete-user";
import { getUser } from "./controllers/users/get-user";
import { getThread } from "./controllers/threads/get-thread";

export async function appRoutes(app: FastifyInstance) {
    app.post("/auth", auth);
    app.delete("/users/:id", deleteUser);
    app.get("/users/:id", getUser)

    app.get("/thread/:id", getThread);
}