# ActivityListFactory

## Schema

```js
ActivityListFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  RareTradeData: [any],
  activityBuyList: [
    {
      probability: [any],
      quotation: [any],
    }
  ],
  activityBuyVal,
  activityGradeList: [
    {
      id,
    }
  ],
  activityLeafletNum,
  activityPassengerList: [
    {
      activityPond,
      activityPondNumMax: [any],
      activityPondNumMin: [any],
      cityId,
      desc,
    }
  ],
  activitySellList: [
    {
      probability: [any],
      quotation: [any],
    }
  ],
  activitySellVal,
  activityTriggerList: [any],
  city,
  endDes,
  enemyList: [
    {
      id,
      isBoss,
    }
  ],
  func,
  goodsList: [
    {
      buyQuotationMaxDown,
      buyQuotationMaxUp,
      buyQuotationMinDown,
      buyQuotationMinUp,
      buyStationList,
      goodsId, // -> HomeGoodsFactory.id
      reversalProbability,
      sellQuotationMaxDown,
      sellQuotationMaxUp,
      sellQuotationMinDown,
      sellQuotationMinUp,
      sellStationList,
    }
  ],
  gradeIncomeList: [
    {
      id,
    }
  ],
  isChangeLeaflet,
  isChangePond,
  isFinishEvent,
  levelList: [
    {
      id,
    }
  ],
  materialList: [
    {
      id,
    }
  ],
  optionDes,
  optionFuncList: [
    {
      id,
    }
  ],
  optionName,
  orderUpList: [
    {
      id,
      param,
    }
  ],
  packageType,
  passengerBufflList: [
    {
      id,
    }
  ],
  priceSeatList: [
    {
      id,
    }
  ],
  qualityType,
  questList: [
    {
      id,
    }
  ],
  recycleCityList: [
    {
      cityId,
      highCoefficient,
      materialList,
    }
  ],
  refreshNum,
  resetType,
  rewardsList: [
    {
      id,
      num,
    }
  ],
  rogueEventList: [
    {
      id,
      weight,
    }
  ],
  rogueEventTypeList: [
    {
      id,
      weight,
    }
  ],
  rogueRefreshList: [
    {
      id,
      weight,
    }
  ],
  selectNum,
  settlementMaxList: [
    {
      num,
    }
  ],
  stationList: [
    {
      id,
    }
  ],
  typeId, // -> TagFactory.id
}
```

## Relations

### Suspected
- ActivityListFactory.recycleCityList[].cityId -> HomeStationFactory.id (hit_ratio=1.000000, gap=1.000000, total=51; total<60)
