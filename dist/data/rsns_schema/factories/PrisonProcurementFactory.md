# PrisonProcurementFactory

## Schema

```js
PrisonProcurementFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  costList: [
    {
      id,
      num,
    }
  ],
  costTime,
  expGet: [
    {
      id,
      num,
    }
  ],
  levelLimited,
  rarity,
  recommendedLevel,
  requireItemList: [
    {
      id,
      num,
    }
  ],
  requireProduction,
  rewardsList: [
    {
      id,
      num,
    }
  ],
  target,
  targetNum,
  weekPerRewardsList: [
    {
      id,
      num,
    }
  ],
  weekRequireItemList: [
    {
      id,
      perNum,
      totalNum,
    }
  ],
  weekRequireProduction,
  weekTotalRewardsList: [
    {
      id,
      num,
    }
  ],
}
```
