# MonopolyEventFactory

## Schema

```js
MonopolyEventFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  BuffDialogList: [
    {
      id,
    }
  ],
  EnergyNum,
  EventMapIcon,
  NPCdialogList: [
    {
      id,
    }
  ],
  actionReduceList,
  addLv,
  addLvItem: [
    {
      id,
      num,
    }
  ],
  angerEffects: [
    {
      object,
      time,
    }
  ],
  basePath,
  battleType,
  belongArchi: [
    {
      archi,
      archiPath,
    }
  ],
  boxAnger,
  boxLevel,
  boxLvLitmit,
  boxName,
  boxSpine,
  boxStand,
  buffGetPrefab,
  buffImg,
  buffList: [
    {
      id,
    }
  ],
  buffNum,
  buffSpineAct,
  buffSpineUrl,
  buildingInfoList: [
    {
      Img,
      boutMoney,
      compensation,
      prefab,
      roadToll,
    }
  ],
  buildingPrice,
  characterQPath,
  compensationBase,
  dialogList: [
    {
      dialogCV,
      dialogContent,
      dialogName,
      eventBG,
      eventSpine,
      iconPath,
      next,
      selection1,
      selection1Next,
      selection2,
      selection2Next,
      selection3,
      selection3Next,
      selection4,
      selection4Next,
      tachiePath,
    }
  ],
  effectsEndTime,
  eventNPC,
  failid,
  ferrisWheelEntrance,
  gameVal,
  goodsList: [
    {
      id,
      weight,
      currencyId, // -> ItemFactory.id
      currencyNum,
      index,
      numMax,
      numMin,
    }
  ],
  goodsNum,
  gukaList: [
    {
      id,
    }
  ],
  gukaRandomNum,
  isCar,
  isOptional,
  isRefresh,
  isVideo,
  levelID,
  levelIDList: [
    {
      id,
    }
  ],
  levelList: [any],
  levelPosX,
  levelPosY,
  levelScale,
  levelTime,
  loseList: [
    {
      id,
      num,
    }
  ],
  lvRewards: [
    {
      lv,
      reward,
    }
  ],
  maxLimit,
  minLimit,
  miniGameType,
  minimumList: [
    {
      id,
      num,
    }
  ],
  moveGridList: [any],
  moveType,
  overDialogList: [
    {
      id,
    }
  ],
  panelName,
  randomDialog: [
    {
      id,
    }
  ],
  randomNPCDialog: [
    {
      id,
      weight,
      num,
    }
  ],
  randomRewardList: [
    {
      id,
      weight,
      num,
      rewardType,
    }
  ],
  randomSampDialog: [
    {
      id,
    }
  ],
  resPath,
  rewardDialogList: [
    {
      id,
    }
  ],
  rewardList: [
    {
      id,
      num,
      rewardType,
    }
  ],
  selectVal,
  showLevel,
  sortDialog: [
    {
      id,
      dialogid,
      failTip,
      limiteType,
      num,
    }
  ],
  sucid,
  threeDPrefab,
  toWaitTrigger,
  toWalkTrigger,
  videoPath,
  winList: [
    {
      id,
      num,
    }
  ],
}
```
