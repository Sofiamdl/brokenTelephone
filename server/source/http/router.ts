import { FastifyInstance } from "fastify";
import { auth } from "./controllers/users/auth-user";
import { deleteUser } from "./controllers/users/delete-user";
import { getUser } from "./controllers/users/get-user";

export async function appRoutes(app: FastifyInstance) {
    app.post("/auth", auth);
    app.delete("/users/:id", deleteUser);
    app.get("/users/:id", getUser)
}