# AFKEventFactory

## Schema

```js
AFKEventFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  iconPath,
  EquipmentConditions: [any],
  ItemConditions: [any],
  LevelBefore: [
    {
      id,
    }
  ],
  LevelConditions: [any],
  MapIconPath,
  ModePath,
  ParagraphBefore: [
    {
      id,
    }
  ],
  QuestConditions: [
    {
      id,
    }
  ],
  UnitConditions: [any],
  animNamePlay,
  animNameStand,
  baseScore,
  bgmId, // -> SoundFactory.id
  boundsCenterX,
  boundsCenterY,
  boundsCenterZ,
  boundsSizeX,
  boundsSizeY,
  boundsSizeZ,
  boxPathList: [
    {
      path,
    }
  ],
  boxRewardId,
  boxRewardList: [
    {
      id,
      weight,
    }
  ],
  boxRewardMax,
  boxRewardMin,
  buyRatio,
  countMax,
  difficultyIndex,
  disAnim,
  disEvent,
  disMove,
  disShowUI,
  einklangRatio,
  eventDescribe,
  eventHeadPath,
  facePath,
  getBoxDis,
  hOffsetMax,
  hOffsetMin,
  headIcon,
  hp,
  icon_x,
  icon_y,
  isAuto,
  isBattleAgain,
  isBgm,
  isCamera,
  isClear,
  isClickUI,
  isDeceleration,
  isDrive,
  isFixedBox,
  isLoseReduce,
  isMain,
  isMove,
  isPlay,
  isReduceDurable,
  isReduceGold,
  isReduceGoods,
  isShowTips,
  isShowUI,
  isStoryStart,
  isStrike,
  isUnClick,
  justOnce,
  level,
  levelId, // -> LevelFactory.id
  levelList: [
    {
      id,
      count,
      modePath,
    }
  ],
  levelList2: [
    {
      id,
    }
  ],
  levelTextId, // -> TextFactory.id
  loginInvoke,
  loseTextId, // -> TextFactory.id
  lvCondition,
  modelOffset,
  modelScale: [any],
  needleDistance,
  needleName,
  nextEvent,
  opposite,
  paragraphId,
  polluteReduce: [any],
  reduceDurableMax,
  reduceDurableMin,
  reduceGoldMax,
  reduceGoldMin,
  reduceGoodsRatioMax,
  reduceGoodsRatioMin,
  reduceGoodsTypeMax,
  reduceGoodsTypeMin,
  tag,
  tagUse,
  textAddWinId, // -> TextFactory.id
  textLossId, // -> TextFactory.id
  textNoId, // -> TextFactory.id
  textPaperId, // -> TextFactory.id
  textPaperWinId, // -> TextFactory.id
  textWinId, // -> TextFactory.id
  totalBirth,
  triggerArgs,
  triggerOrder,
  vOffsetMax,
  vOffsetMin,
  weaponDistance,
  yAngle,
}
```
