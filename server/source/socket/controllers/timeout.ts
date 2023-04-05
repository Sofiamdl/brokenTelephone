import { Server, Socket } from "socket.io";
import { IGamesRepository } from "../../repositories/games-repository";
import { IGameObject, IThreadsRepository } from "../../repositories/threads-repository";
import { GameIndexCalculator } from "../../utilities/game-index-calculator";

export async function hostTimeout(socket: Socket, gameRepository: IGamesRepository, threadRepository: IThreadsRepository, gameIndexCalculator: GameIndexCalculator, data: any, io: Server) {
  const room = await gameRepository.findRoomByUserId(socket.id);

  io.to(room.code).emit("timeout", "");

  const { round } = await gameRepository.incrementGameRoomRound(room.code);

  if (round == room.users.length) {
    io.to(room.code).emit("game-over", "")
    console.log("game-over")
  }
  return
}