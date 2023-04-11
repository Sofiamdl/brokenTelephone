import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetThreadUseCase } from "../../../use-cases/factories/make-get-thread";

export async function getRequest(request: FastifyRequest, reply: FastifyReply) {
    const getThreadParamsSchema = z.object({
        id: z.string()
    })

    const { id } = getThreadParamsSchema.parse(request.params);

    try {
        const getThreadUseCase = makeGetThreadUseCase();
        
        const { thread } = await getThreadUseCase.handle({
            id,
        })

        return reply.status(200).send({ data: thread });

    } catch(err) {
        return reply.status(500).send(err)
    }
}