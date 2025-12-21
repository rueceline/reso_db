# MapControlFactory

## Schema

```js
MapControlFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  antedate,
  clickLimit,
  diceItemList: [
    {
      id,
    }
  ],
  diceLimit,
  diceNum,
  diceTimeNum: [
    {
      endTime,
      num,
      startTime,
    }
  ],
  diceTimeWeekendNum: [
    {
      endTime,
      num,
      startTime,
    }
  ],
  diceWeekendNum,
  gameDate,
  gameMinLV,
  itemLimit,
  itemUseLimit,
  joinTicket: [
    {
      id,
      num,
    }
  ],
  moneyId,
  monopolyList: [
    {
      id,
    }
  ],
  monopolyRank,
  pathLimit,
  playerNum,
  refreshLimit,
  refreshRankTime,
  roundItemList: [
    {
      id,
    }
  ],
  showRankNum,
}
```
