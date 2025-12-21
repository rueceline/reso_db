# LeaderCardConditionFactory

## Schema

```js
LeaderCardConditionFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  OnlyEnemy,
  buffFO,
  buffFoList: [any],
  buffOwnerId,
  cardId,
  cardNum,
  condition,
  cost_SN,
  isContinue,
  isContinuous,
  isIncludeDeck,
  isIncludeGrave,
  isIncludeHand,
  isNegative,
  isOnlyDeck,
  isPositive,
  isTimeProg,
  judgeType,
  progAddNum,
  progressMax,
  reverseTagList: [
    {
      tagId,
    }
  ],
  reverseTagType,
  tagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  tagType,
  targetType,
}
```
