# MonopolyGameGridFactory

## Schema

```js
MonopolyGameGridFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  downGrid,
  gridEventList: [
    {
      id,
    }
  ],
  gridImg,
  gridStreet,
  isRank,
  isTurnRound,
  leftGrid,
  rankInningList: [
    {
      rank,
      reward,
    }
  ],
  rankIssueList: [
    {
      rank,
      reward,
    }
  ],
  refreshTime,
  rightGrid,
  stationGradeList: [
    {
      investNum,
      num,
      saveMax,
    }
  ],
  upGrid,
}
```
