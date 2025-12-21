# FoodFactory

## Schema

```js
FoodFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  PriceIndex: [any],
  battleBuffDes,
  battleBuffImagePath,
  battleBuffList: [
    {
      id,
      weight,
    }
  ],
  bgmPlay,
  chefImagePath,
  cost: [
    {
      id,
      num,
    }
  ],
  energy,
  expirationDate,
  foodImagePath,
  foodName,
  foodPrefab,
  foodRes,
  foodSettlementImagePath,
  foodSettlementPrefab,
  iconBuffDesLCZ,
  iconBuffDesMember,
  isPickFood,
  mealTypeNum,
  memberTrust: [
    {
      id,
      buff,
      like,
    }
  ],
  npcList: [
    {
      npcAni,
      npcId,
    }
  ],
  numBuffDesLCZ,
  numBuffDesMember,
  performFurnitureList: [
    {
      furnitureId,
      isPerformEffect,
      normalPath,
      performPath,
    }
  ],
  playerAni: [
    {
      animation,
    }
  ],
  rewards: [
    {
      id,
      num,
    }
  ],
  speed: [
    {
      id,
      weight,
    }
  ],
  tipBuffDesLCZ,
  tipBuffDesMember,
  trust,
}
```
