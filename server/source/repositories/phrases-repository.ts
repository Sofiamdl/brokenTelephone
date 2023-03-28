export interface IPhrasesRepository {
  findMany(userAmount: Number): Promise<string[]>
}