import { IGameObject } from "../threads-repository";
import { IVotedRepository, IVotedThread } from "../voted-repository";

export class InMemoryVotedRepository implements IVotedRepository {
    public voted: IVotedThread = {}

    async create(gameRoomCode: string) {
        this.voted[gameRoomCode] = [];

        console.log("CREATE VOTED:")
        console.log(this.voted[gameRoomCode]);
        console.log("------------------")

        return this.voted;
    }

    async addGameObjetToVoted(gameObject: IGameObject, gameRoomCode: string) {
        this.voted[gameRoomCode].push(gameObject);

        console.log("ADD VOTED:")
        console.log(this.voted[gameRoomCode]);

        return gameObject;
    }

    async saveGameObjectToThread(gameRoomCode: string, gameObjectId: string, newLikes: number) {
        const gameObjectIndex = this.voted[gameRoomCode].findIndex(item => item.id === gameObjectId);

        if(gameObjectIndex < 0) {
            return null;
        }

        const newGameObject = this.voted[gameRoomCode][gameObjectIndex]

        newGameObject.votes = newLikes;

        this.voted[gameRoomCode][gameObjectIndex] = newGameObject;

        console.log("SAVE VOTED:")
        console.log(this.voted[gameRoomCode]);
        
        return this.voted[gameRoomCode][gameObjectIndex];
    }

    async findById(gameRoomCode: string, gameObjectId: string) {
        const gameObject = this.voted[gameRoomCode].find(item => item.id === gameObjectId);

        if(!gameObject) {
            return null;
        }

        return gameObject;
    }
}