# MonopolyGameMapFactory

## Schema

```js
MonopolyGameMapFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  askHelpLimit,
  bossHP,
  bossHPReduce,
  bossHelpLimit,
  bossIcon,
  bossLevel,
  bossLimit,
  bossRewardList: [
    {
      id,
      num,
    }
  ],
  boxFightLimit,
  boxInitNum,
  boxLimit,
  boxList: [
    {
      id,
      weight,
    }
  ],
  boxRefresh: [
    {
      id,
    }
  ],
  boxRefreshLimit,
  buffGodList: [
    {
      id,
    }
  ],
  cityList: [
    {
      id,
    }
  ],
  endTime,
  eventLimit: [
    {
      id,
      num,
    }
  ],
  gameGradeList: [
    {
      exp,
      rewardId, // -> ListFactory.id
    }
  ],
  godRefreshTime,
  gridList: [
    {
      id,
      initLV,
      x,
      y,
    }
  ],
  helpFightLimit,
  initDice,
  initMoney,
  investItem,
  investLimit,
  investList: [
    {
      id,
      num,
    }
  ],
  jigsawHeight,
  jigsawWidth,
  mapBinPath,
  maxThrowNum,
  minThrowNum,
  rankGridList: [
    {
      id,
    }
  ],
  scheduleList: [
    {
      gameEnd,
      gameStart,
      signEnd,
      signStart,
    }
  ],
  signEndTime,
  startTime,
}
```
