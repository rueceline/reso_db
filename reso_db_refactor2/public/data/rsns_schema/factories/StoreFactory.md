# StoreFactory

## Schema

```js
StoreFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  TextLockId,
  activityId,
  autoRefresh,
  capacityType: [
    {
      id,
    }
  ],
  commodityFixedList: [
    {
      id,
    }
  ],
  conditions,
  currencyShow: [
    {
      id,
      click,
    }
  ],
  endTime,
  freeRefreshNum,
  isRecordTimes,
  isStationRefresh,
  isTab,
  isTime,
  maxShopNum,
  moneyList: [
    {
      moneyID,
      moneyNum,
    }
  ],
  pngNotSelect,
  pngSelect,
  recommendList: [
    {
      id,
      type,
      andPath,
      comSequence,
      funcId,
      iosPath,
      isBattlePass,
      name,
      otherUI,
      png,
      sequence,
      storeId,
      tabPng,
    }
  ],
  recycleShopList: [
    {
      id,
    }
  ],
  refreshTimeList: [
    {
      refreshTime,
    }
  ],
  refreshType,
  rewardList: [any],
  shopList: [
    {
      id,
      weight,
    }
  ],
  showUI,
  startTime,
  storeName,
  storeType,
  unlockConditions,
}
```
