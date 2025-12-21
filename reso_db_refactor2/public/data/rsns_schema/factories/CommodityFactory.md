# CommodityFactory

## Schema

```js
CommodityFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  quality,
  iconPath,
  commodityFunction,
  commodityItemList: [
    {
      id,
      num,
    }
  ],
  commodityName,
  commodityNum,
  commodityView,
  continueTime,
  discountVariable,
  endTime,
  extraGiveList: [any],
  firstGifts,
  firstGiftsNum,
  furnitureCondition,
  gradeCondition,
  gradeRefresh,
  initTime,
  isBuyCondition,
  isChange,
  isPurchaseLv,
  isRefresh,
  isTime,
  isTriggerTime,
  limitBuyType,
  monetaryView,
  moneyList: [
    {
      moneyID,
      moneyNum,
    }
  ],
  oneTimeMax,
  prisonGradeCondition,
  purchase,
  purchaseLvInit,
  purchaseLvMax,
  purchaseLvNum,
  purchaseLvSpace,
  purchaseNum,
  recycleItem,
  recycleMoneyList: [
    {
      moneyID,
      moneyNum,
    }
  ],
  refreshDay,
  repGradeCondition,
  startTime,
  stationCondition,
}
```
