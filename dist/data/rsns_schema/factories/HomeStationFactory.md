# HomeStationFactory

## Schema

```js
HomeStationFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  iconPath,
  acquisitionList: [
    {
      id,
    }
  ],
  action2M,
  action2W,
  actionM,
  actionW,
  addDevelop,
  added,
  attachedToCity,
  banStopTips,
  barStoreList: [
    {
      id,
    }
  ],
  bargainSpinePath,
  battleIconPath,
  battleLevelList: [
    {
      id,
      difficulty,
    }
  ],
  battleLevelName,
  battleTypeId,
  buildingIconPath,
  buyPrice: [
    {
      id,
      num,
    }
  ],
  buyReward: [
    {
      id,
      num,
    }
  ],
  cityHallName,
  cityInvestList: [any],
  cityLeafletLest: [
    {
      id,
    }
  ],
  cityLeafletList: [
    {
      id,
    }
  ],
  cityMapIconPath,
  cityPrestige,
  cityStateList: [
    {
      cityMapId, // -> CityMapFactory.id
      dungeonId,
      name,
      sceneId, // -> ListFactory.id
      state,
    }
  ],
  cocExchangeBuildId,
  cocRecycleStoreList: [
    {
      id,
    }
  ],
  cocStoreList: [
    {
      id,
    }
  ],
  constructIconPath,
  constructStageList: [
    {
      id,
      basisNum,
      constructNum,
      desc,
      name,
      nameBtn,
      nameEN,
      overNum,
      png,
      stagePng,
      state,
      upperNum,
    }
  ],
  constructionActivityId,
  correspondingConstruction,
  createOrderList: [
    {
      id,
      constructLimit,
    }
  ],
  dangerLevel,
  defaultDevelop,
  desNew,
  developUpperLimit,
  divide: [any],
  drinkCost: [
    {
      id,
      name,
      powerReduce,
    }
  ],
  drinkVideo,
  enterStationPlotList: [any],
  exchangeAffirmPath,
  exchangeBottomPath,
  exchangeCompletePath,
  exchangeIconPath,
  exchangeName,
  exchangePagePath,
  exchangeStoreList: [
    {
      id,
    }
  ],
  extraWarehouseList: [
    {
      addNum,
      buyNum,
      name,
      reputation,
      useNum,
    }
  ],
  force,
  initCOCQuestList: [
    {
      id,
    }
  ],
  intervalTime,
  investList: [
    {
      id,
      developNum,
      limitNum,
      name,
      repGrade,
    }
  ],
  investRankBuffList: [
    {
      id,
      investRankNum,
    }
  ],
  investRankList: [
    {
      id,
    }
  ],
  investTime,
  inviteTimes,
  isAddRep,
  isBanStop,
  isCOC,
  isCOCStation,
  isHomeBattleCentre,
  isLeaflet,
  isOpen,
  isPark,
  isShowInMap,
  isShowRep,
  isWarehouse,
  itemId,
  keepSingleMealList: [
    {
      id,
    }
  ],
  keepTeamMealList: [
    {
      id,
    }
  ],
  kmCostList: [
    {
      id,
      num,
    }
  ],
  leafletMap,
  leafletUnlock,
  limitNum,
  lockStationQuestList: [
    {
      id,
    }
  ],
  mapIconPath,
  materialRecycleList: [
    {
      id,
    }
  ],
  maxDivide: [any],
  nameEN,
  nameId,
  nodePath,
  onhookCoefficient,
  openPageList: [
    {
      icon,
      isTalk,
      name,
    }
  ],
  order,
  parkId,
  parkTicket,
  parkTicketMax,
  petRecycleStoreList: [
    {
      id,
    }
  ],
  petStoreList: [
    {
      id,
    }
  ],
  playerLevel,
  pos,
  prisonId,
  pullOutTimeLineList: [
    {
      id,
    }
  ],
  questId,
  quickIconPath,
  recommendLevel,
  recommendNum,
  recoverItem,
  refreshBuildList: [
    {
      id,
    }
  ],
  refreshTime,
  repRewardList: [
    {
      id,
      bargainNum,
      bargainSuccessRate: [any],
      buyNum: [any],
      cocAutoRefreshNum,
      cocQuestList,
      desc,
      honorPng,
      offerAutoRefreshNum,
      peopleName,
      repNum,
      revenue,
      riseNum,
      wareNum,
    }
  ],
  saleBottomPath,
  saleHighPricePath,
  saleName,
  sellList: [
    {
      id,
    }
  ],
  showGoodsQuest,
  sort,
  specifiedLevelId,
  tax: [any],
  textArriveFirst,
  timeLineList: [
    {
      id,
    }
  ],
  totalBuffList: [any],
  tradeRankList: [
    {
      id,
    }
  ],
  trainHelpChat,
  trainList: [
    {
      type,
      endType,
      posStart,
      speedAdd,
      speedDec,
      speedMax,
      speedMin,
      trainDistance,
      trainId,
    }
  ],
  trainSoundList: [
    {
      name,
      voiceDeparture,
      voiceDeparturePassenger,
      voiceWillArrive,
      voiceWillArrivePassenger,
    }
  ],
  travelDay,
  travelDayPond,
  turnExchangeBuildId,
  turntableId,
  visitorNumPond,
  warehousePrestige,
  x,
  y,
}
```
