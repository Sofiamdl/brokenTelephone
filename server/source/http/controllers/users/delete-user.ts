import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeDeleteUserUseCase } from "../../../use-cases/factories/make-delete-user";

export async function deleteUser(request: FastifyRequest, reply: FastifyReply) {
    const deleteParamSchema = z.object({
        id: z.string(),
    });

    const { id } = deleteParamSchema.parse(request.params);

    try {
        const deleteUserUseCase = makeDeleteUserUseCase()

        const user = await deleteUserUseCase.handle({
            id,
        })

        return reply.status(200).send(user);
    } catch(err) {
        throw new Error(err)
    }

    
}