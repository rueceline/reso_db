# ManufacturingOrderFactory

## Schema

```js
ManufacturingOrderFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  isProductionGet,
  isSpecial,
  isTeam,
  moneyList: [
    {
      id,
      num,
    }
  ],
  rarity,
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
  timeLimit,
}
```
