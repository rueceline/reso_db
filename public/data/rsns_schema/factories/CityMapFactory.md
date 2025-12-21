# CityMapFactory

## Schema

```js
CityMapFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  iconPath,
  activityId,
  animLoop,
  animOut,
  bgColor,
  bgList: [
    {
      bgPath,
      changeTime,
      effectListId, // -> CityMapFactory.id
      sceneId, // -> ListFactory.id
    }
  ],
  bgPath,
  btnType,
  bubbleList: [
    {
      id,
      x,
      y,
    }
  ],
  buildingId, // -> BuildingFactory.id
  dialogId, // -> ParagraphFactory.id
  displayConditionsList: [
    {
      condition,
      mId, // -> QuestFactory.id
      val,
    }
  ],
  dungeonId,
  effectList: [
    {
      weight,
      effectPath,
    }
  ],
  effectPath,
  endTime,
  exitId,
  frontIconPath,
  func,
  isInstance,
  isLock,
  isShowConstruct,
  isShowRep,
  isSpecial,
  levelId, // -> LevelFactory.id
  mId,
  nameIconPath,
  npcId, // -> NPCFactory.id
  offsetX,
  offsetY,
  startTime,
  stationPlace,
  textId,
  uiPath,
  unlockConditionsList: [
    {
      condition,
      textId,
      val,
    }
  ],
}
```

## Relations

### Confirmed
- CityMapFactory.displayConditionsList[].mId -> QuestFactory.id (hit_ratio=0.996885, gap=0.993769, total=321)

### Suspected
- CityMapFactory.textId -> TextFactory.id (hit_ratio=1.000000, gap=1.000000, total=36; total<60)
