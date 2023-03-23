import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeAuthUseCase } from "../../../use-cases/factories/make-auth";

export async function auth(request: FastifyRequest, reply: FastifyReply) {
    const registerBodySchema = z.object({
        id: z.string(),
        name: z.string(),
        email: z.string().email(),
        token: z.string(),
    });

    const { name, email, id, token } = registerBodySchema.parse(request.body);

    try {
        const authUseCase = makeAuthUseCase();

        const user = await authUseCase.handle({
            id,
            name,
            email,
            token,
        })

        return reply.status(200).send(user);
    } catch(err) {
        throw new Error(err)
    }

    
}