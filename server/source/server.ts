/*
import fastify from "fastify";
import { z } from "zod";
import { Prisma } from "@prisma/client";

import { PrismaClient } from "@prisma/client";


export const prisma = new PrismaClient({
    log: ["query"],
});

const app = fastify()

app.post("/auth", async (request, reply) => {

    const registerBodySchema = z.object({
        id: z.string(),
        name: z.string(),
        email: z.string().email(),
        token: z.string(),
    });

    const { name, email, id, token } = registerBodySchema.parse(request.body);

    const user = await prisma.user.findUnique({where: {id} })

    if (user) return reply.status(200).send(user);

    const data: Prisma.UserCreateInput = {
        id,
        email,
        name,
        token,
    }

    const createdUser = await prisma.user.create({ data });

    return reply.status(201).send(createdUser);
})

app.get("/user/:id", async (request, reply) => {

    const registerBodySchema = z.object({
        id: z.string(),
    });

    const {id} = registerBodySchema.parse(request.params)

    const user = await prisma.user.findUnique({where: {id} })

    if (!user){
        return reply.status(404).send("User not found")
    }
   
    return reply.status(200).send(user)
    
})

app.delete ("/user/:id", async (request, reply) => {
    const registerBodySchema = z.object({
        id: z.string(),
    });

    const {id} = registerBodySchema.parse(request.params)

    const user = await prisma.user.findUnique({where: {id} })

    if (!user){
        return reply.status(404).send("User not found")
    }
   
    await prisma.user.delete( {where: {id} })
    return reply.status(200).send("User deleted succesfully")

})
*/

import { app } from "./app"

app.listen({
    host: "0.0.0.0",
    port: 3001,
}).then(() => {
    console.log("Server running")
})