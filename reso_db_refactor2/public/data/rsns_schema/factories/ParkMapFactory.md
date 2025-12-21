# ParkMapFactory

## Schema

```js
ParkMapFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  animInitialStand,
  animMove,
  animStand: [
    {
      name,
    }
  ],
  battleLoseEnergy,
  buyCarCostList: [any],
  carEvent,
  carLengthNum,
  carMoveNum,
  carRouteList: [
    {
      id,
    }
  ],
  challengeNum,
  combineSealList: [
    {
      id,
    }
  ],
  damageLimit,
  dreamCoin: [
    {
      id,
    }
  ],
  eventLimit: [any],
  extraEnergyCostList: [
    {
      id,
    }
  ],
  fastpassBattleItem,
  fastpassBattleItemCostList: [
    {
      id,
      num,
    }
  ],
  finialLossAward: [
    {
      id,
      num,
    }
  ],
  finialOtherAward: [
    {
      id,
      num,
    }
  ],
  finialParam: [
    {
      num,
      param,
    }
  ],
  finialWinAward: [
    {
      id,
      num,
    }
  ],
  fireworkCameraAngleX,
  fireworkCameraPosX,
  fireworkCameraPosY,
  fireworkCameraPosZ,
  fireworkPositionList: [
    {
      x,
      y,
      z,
    }
  ],
  gridList: [
    {
      id,
    }
  ],
  gukaList: [
    {
      id,
    }
  ],
  initialEnergyItemList: [
    {
      id,
    }
  ],
  initialEnergyList: [
    {
      bgPath,
      des,
      extraCost,
      name,
      num,
      path,
      pickBgPath,
    }
  ],
  isQuestClearProgressList: [
    {
      id,
    }
  ],
  loadingList: [
    {
      imagePath,
    }
  ],
  mapBinPath,
  moveEnergy,
  moveNum,
  parkBagList: [
    {
      id,
    }
  ],
  payRefreshItem: [
    {
      id,
      num,
    }
  ],
  payRefreshNum,
  reviveAction,
  reviveCost: [
    {
      id,
      num,
    }
  ],
  reviveLimit,
  sealNumMax,
  singleDialogList: [
    {
      id,
      name,
      tabPath,
    }
  ],
  singleSealList: [
    {
      id,
    }
  ],
  startList: [
    {
      id,
    }
  ],
  taskInitialList: [
    {
      id,
    }
  ],
  ticketBuffList: [
    {
      id,
      weight,
      ticketShowPath,
    }
  ],
  ticketBuyItem: [
    {
      id,
      num,
    }
  ],
  ticketCostExtra,
  ticketCostList: [
    {
      id,
      num,
    }
  ],
  ticketGift: [
    {
      num,
    }
  ],
  ticketGiftItem: [
    {
      id,
      num,
    }
  ],
  ticketLimit,
  ticketList: [
    {
      id,
      num,
    }
  ],
  ticketReresh: [any],
  toWitchHouseGridList: [any],
}
```
