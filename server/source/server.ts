import fastify from "fastify";
import { z } from "zod";
import { Prisma, User } from "@prisma/client";

import { PrismaClient } from "@prisma/client";

export const prisma = new PrismaClient({
    log: ["query"],
});

const app = fastify()

app.post("/auth/register", async (request, reply) => {
    const registerBodySchema = z.object({
        id: z.string(),
        name: z.string(),
        email: z.string(),
        token: z.string(),
    });

    const { name, email, id, token } = registerBodySchema.parse(request.body);

    const data: Prisma.UserCreateInput = {
        id,
        email,
        name,
        token,
    }

    const createdUser = await prisma.user.create({ data });




    return reply.status(201).send(createdUser);
})

app.listen({
    host: "0.0.0.0",
    port: 3001,
}).then(() => {
    console.log("Server running")
})