# RogueEventFactory

## Schema

```js
RogueEventFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  iconPath,
  bgPath,
  bookDes,
  breakPriceNList: [
    {
      id,
      num,
    }
  ],
  breakPriceRList: [
    {
      id,
      num,
    }
  ],
  breakPriceSRList: [
    {
      id,
      num,
    }
  ],
  breakPriceSSRList: [
    {
      id,
      num,
    }
  ],
  buffLimit,
  coinLimit,
  completeNum,
  difficultLimit,
  endTime,
  enemyId,
  eventLimitList: [
    {
      id,
    }
  ],
  firstPlotId,
  func,
  isBoss,
  isCertainly,
  levelId, // -> LevelFactory.id
  nextEvent,
  npcId,
  optionLimitList: [
    {
      id,
    }
  ],
  optionList: [
    {
      id,
    }
  ],
  recruitPriceNList: [
    {
      id,
      num,
    }
  ],
  recruitPriceRList: [
    {
      id,
      num,
    }
  ],
  recruitPriceSRList: [
    {
      id,
      num,
    }
  ],
  recruitPriceSSRList: [
    {
      id,
      num,
    }
  ],
  restEventList: [
    {
      id,
      btnPng,
      diPng,
      iconPng,
      prepositionId,
    }
  ],
  resurgencePriceNList: [
    {
      id,
      num,
    }
  ],
  resurgencePriceRList: [
    {
      id,
      num,
    }
  ],
  resurgencePriceSRList: [
    {
      id,
      num,
    }
  ],
  resurgencePriceSSRList: [
    {
      id,
      num,
    }
  ],
  rewardList: [
    {
      id,
      num,
    }
  ],
  startTime,
  storeList: [
    {
      id,
    }
  ],
  typeId, // -> TagFactory.id
  uiPath,
  weaponLimit,
  weeklyExperienceNum,
}
```
