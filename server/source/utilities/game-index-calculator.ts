export class GameIndexCalculator {
    
    getIndexToNext(round: number, userAmount: number, userIndex: number) {
        return (userIndex + round) % userAmount;
    }

    getParentThreadIndex(round: number, userAmount: number, userIndex: number) {
        let parentThreadIndex = (userIndex - round)

        if (parentThreadIndex < 0) {
            parentThreadIndex += userAmount;
        }

        return parentThreadIndex;
    }
}


/*
IDA: (idx + round) mod (qtd users)
VOLTA: (idx - round)
        if (volta < 0) -> volta = users.length + volta
*/