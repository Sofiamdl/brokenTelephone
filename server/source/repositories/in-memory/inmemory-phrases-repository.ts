import { IPhrasesRepository } from "../phrases-repository";

export class InMemoryPhrasesRepository implements IPhrasesRepository {
  async findMany(userAmount: Number) {
    return ["Capivara dando conselho amoroso", "Jogando bola com guaraná", "Arara fazendo malabarismo", "Cuscuz na gravidade zero", "Chapéu de pandeiro"];
  }
  
}
