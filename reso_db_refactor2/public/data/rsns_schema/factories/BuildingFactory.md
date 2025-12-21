# BuildingFactory

## Schema

```js
BuildingFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  PlaceDesc,
  RecycleStoreList: [
    {
      id,
    }
  ],
  StoreList: [
    {
      id,
    }
  ],
  acquisitionList: [any],
  activityOrderList: [
    {
      id,
      limitNum,
      onceNum,
      rewardId,
    }
  ],
  barStoreList: [any],
  bgColor,
  bgPath,
  bottomPath,
  buildLevelName,
  buildingIconPath,
  buildingPath,
  buyPrice: [any],
  buyReward: [any],
  changeRefreshTime,
  cocStoreList: [any],
  commodityPath,
  constructionLevelList: [
    {
      id,
      allConstruction,
      bossId,
      conditionId,
      icon,
      levelPng,
      levelPngLock,
      levelX: [any],
      levelY: [any],
    }
  ],
  correspondingActivity,
  createQuestList: [
    {
      id,
      repCondition,
    }
  ],
  drinkCost: [any],
  drinkVideo,
  eventList: [
    {
      activityId,
      endTime,
      eventId,
      eventType,
      questId,
      startTime,
    }
  ],
  exchangeAffirmPath,
  exchangeBuildId,
  exchangeCompletePath,
  exchangeName,
  exchangeOpenPageList: [
    {
      icon,
      isStore,
      isTalk,
      name,
      showUI,
    }
  ],
  exchangePath,
  exchangeStoreList: [
    {
      id,
    }
  ],
  exchangeWeaponList: [
    {
      id,
    }
  ],
  expelBgPath,
  firstPlotId,
  helpId,
  initCOCQuestList: [any],
  initialOrderPrisonList: [
    {
      id,
    }
  ],
  integralCoefficient,
  integralRewardList: [
    {
      id,
      index,
      integral,
    }
  ],
  isShowConstruct,
  isShowReputation,
  isWarehouse,
  levelIconPath,
  limitNum,
  lv,
  namePlace,
  namePlaceIcon,
  npcId,
  offerPrestige,
  offerQuestList: [
    {
      id,
      weight,
      bossId, // -> UnitFactory.id
      gradeMax,
      gradeMin,
      isRepetition,
    }
  ],
  openPageList: [
    {
      bubId,
      buildId,
      icon,
      isTalk,
      listIndex,
      name,
      showUI,
    }
  ],
  orderBgPath,
  orderDes,
  orderNumMax,
  orderNumMin,
  orderPrison,
  orderPrisonList: [
    {
      id,
    }
  ],
  orderPrisonRefreshDiamondList: [
    {
      id,
      num,
    }
  ],
  orderPrisonRefreshDiamondTimes,
  orderPrisonRefreshItemList: [
    {
      id,
      num,
    }
  ],
  orderTimes,
  orderTitle,
  pagePath,
  passengerTagList: [
    {
      id,
      weight,
    }
  ],
  passengerTypeList: [
    {
      id,
      weight,
    }
  ],
  placeType,
  placeWeight,
  playerLevel,
  quickIconPath,
  rankId,
  refreshOrderPrisonTime,
  returnCoefficient,
  rubbishRankList: [
    {
      id,
    }
  ],
  selectPath,
  sellList: [any],
  shareLevelNumMax,
  stationId, // -> HomeStationFactory.id
  storeName,
  storePath,
  storeTag,
  tabPath,
  tagOffPath,
  tagOnPath,
  timePath,
  tradeRankList: [any],
  triggerPlot,
  triggerQuest,
  uiPath,
  unlockPlace,
  visitorMax,
  visitorMin,
  visitorTagList: [
    {
      id,
      weight,
    }
  ],
  visitorTypeList: [
    {
      id,
      weight,
    }
  ],
  warehousePrestige,
}
```

## Relations

### Suspected
- BuildingFactory.npcId -> NPCFactory.id (hit_ratio=1.000000, gap=1.000000, total=48; total<60)
- BuildingFactory.eventList[].questId -> QuestFactory.id (hit_ratio=1.000000, gap=1.000000, total=53; total<60)
