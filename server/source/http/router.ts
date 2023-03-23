import { FastifyInstance } from "fastify";
import { auth } from "./controllers/users/auth-user";
import { deleteUser } from "./controllers/users/delete-user";

export async function appRoutes(app: FastifyInstance) {
    app.post("/auth", auth);
    app.delete("/users/:id", deleteUser);
}