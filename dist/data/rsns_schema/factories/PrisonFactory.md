# PrisonFactory

## Schema

```js
PrisonFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  accelerationCostList: [
    {
      cost,
      stage,
      time,
    }
  ],
  addProcurementList: [
    {
      id,
      addNum,
      costNum,
    }
  ],
  arrestBag,
  arrestItem,
  arrestItemPr,
  arrestItemPrList: [
    {
      pr,
      rarity,
    }
  ],
  buySpacePrice: [
    {
      id,
      num,
    }
  ],
  buySpaceReward: [
    {
      id,
      num,
    }
  ],
  buyWarePrice: [
    {
      id,
      num,
    }
  ],
  buyWareReward: [
    {
      id,
      num,
    }
  ],
  buyWarehouseExtra: [
    {
      id,
    }
  ],
  buyWorkshopPrice: [
    {
      id,
      num,
    }
  ],
  buyWorkshopReward: [
    {
      id,
      num,
    }
  ],
  cardFaster: [
    {
      card,
      cardTime,
    }
  ],
  cellSpaceOccupyPower,
  characterHappenList: [
    {
      eventId,
      happenProbability,
    }
  ],
  characterList: [
    {
      weight,
      eventId,
    }
  ],
  defaultHealth,
  diamondFaster: [
    {
      diamond,
      diamondNum,
      timeFaster,
    }
  ],
  employItem,
  escapeLeaveMessage: [any],
  escapePrCut,
  escapePrList: [
    {
      prDaily,
      prSuccessMax,
      prSuccessMin,
      rarity,
    }
  ],
  extraBuyWarePrice: [
    {
      id,
      num,
    }
  ],
  fleetCost: [
    {
      id,
      num,
    }
  ],
  friskFalling: [
    {
      numFalling,
      numWeight,
    }
  ],
  healthEventEffectList: [
    {
      healthNum,
      illID,
      illProbability: [any],
    }
  ],
  healthNaturalEffectList: [
    {
      healthNum,
      illID,
      illProbability,
    }
  ],
  hygieneAndHealthList: [
    {
      healthNumLimit,
      hygieneNum,
    }
  ],
  initWeekOrderList: [
    {
      id,
    }
  ],
  initialCellNum,
  initialHomeFurnitureList: [
    {
      machineId,
      schemeType,
    }
  ],
  initialPrice,
  initialPriceItem,
  initialPrisoner: [
    {
      place,
      prisoner,
      time,
    }
  ],
  initialRoomNum,
  initialSpaceNum,
  initialTradeLevel,
  initialWorkshopNum,
  interceptRoomList: [
    {
      id,
    }
  ],
  lawyerList: [
    {
      lawyerDec,
      lawyerId,
      lawyerName,
      lawyerPicturePath,
      layerWeight,
      moneyAdd,
      moneyCost,
      moneyCostPer,
      starLevel,
      starLevelPath,
    }
  ],
  lawyerTime: [
    {
      time,
      timeWeight,
    }
  ],
  leaveMessage: [
    {
      id,
    }
  ],
  lvDesList: [
    {
      isDefault,
      name,
      textid,
    }
  ],
  lvList: [
    {
      PrisonProcurementList,
      SpaceNum,
      arrestBagPrison,
      cellNum,
      commodityWare,
      exp,
      extraCommodityWare,
      extraMaterialWare,
      level,
      machineId, // -> HomeFurnitureFactory.id
      materialWare,
      prisonerNum,
      refreshNum,
      reward,
      roomNum,
      taskList,
      workshopNum,
    }
  ],
  machineList: [any],
  materialGetLimit,
  orderBuildingId,
  prestoreCost: [
    {
      id,
      num,
    }
  ],
  prison: [
    {
      id,
    }
  ],
  prisonBuyElectricList: [
    {
      consumeMaterial,
      extraPower,
    }
  ],
  prisonCostPrice: [
    {
      id,
      num,
    }
  ],
  prisonDes,
  prisonMachinePosition: [any],
  prisonMaterialWarehouseCondition: [
    {
      name,
      rate: [any],
    }
  ],
  prisonProductWarehouseCondition: [
    {
      name,
      rate: [any],
    }
  ],
  prisonRoomPosition: [
    {
      id,
    }
  ],
  prisonStoreList: [
    {
      id,
    }
  ],
  prisonerGetoutExpGetList: [
    {
      id,
      count,
    }
  ],
  prisonerTime: [
    {
      weight,
      num,
    }
  ],
  productionAccelerationItemList: [
    {
      id,
      type,
      time,
    }
  ],
  refreshItemList: [
    {
      id,
      num,
      refreshId,
    }
  ],
  replyHealth,
  roomHygieneEffect: [
    {
      effectOneAdd,
      effectOneTextId,
      effectOneThreshold,
      effectTwoAdd,
      effectTwoTextId,
      effectTwoThreshold,
    }
  ],
  roomObedienceEffect: [
    {
      effectOneAdd,
      effectOneTextId,
      effectOneThreshold,
      effectTwoAdd,
      effectTwoTextId,
      effectTwoThreshold,
    }
  ],
  roomPrisonerNum,
  roomSafetyEffect: [
    {
      effectOneAdd,
      effectOneTextId,
      effectOneThreshold,
      effectTwoAdd,
      effectTwoTextId,
      effectTwoThreshold,
    }
  ],
  roomStabilityEffect: [
    {
      effectOneAdd,
      effectOneTextId,
      effectOneThreshold,
      effectTwoAdd,
      effectTwoTextId,
      effectTwoThreshold,
    }
  ],
  routeCost: [
    {
      id,
      num,
    }
  ],
  scoreAdd,
  sewingMachineProductList: [
    {
      id,
    }
  ],
  shortageBondNum,
  supplyBondNum,
  taskAllList: [
    {
      id,
    }
  ],
  taskInitialList: [
    {
      id,
    }
  ],
  weekOrderLevel,
  weekOrderList,
  weekOrderNum,
  weekOrderRewardsList: [
    {
      id,
      num,
    }
  ],
  weekOrdercompleteNum,
  workshopSpaceOccupyPower,
}
```
