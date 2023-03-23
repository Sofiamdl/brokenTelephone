import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetUserUseCase } from "../../../use-cases/factories/make-get-user";

export async function getUser(request: FastifyRequest, reply: FastifyReply) {
    const getParamSchema = z.object({
        id: z.string(),
    });

    const { id } = getParamSchema.parse(request.params);

    try {
        const getUserUseCase = makeGetUserUseCase()

        const user = await getUserUseCase.handle({
            id,
        })

        return reply.status(200).send(user);
    } catch(err) {
        throw new Error(err)
    }

    
}