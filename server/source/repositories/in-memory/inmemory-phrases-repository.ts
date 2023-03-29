import { IPhrasesRepository } from "../phrases-repository";

export class InMemoryPhrasesRepository implements IPhrasesRepository {
  async findMany(userAmount: Number) {
    return ["oi", "ola", "porra"];
  }
  
}