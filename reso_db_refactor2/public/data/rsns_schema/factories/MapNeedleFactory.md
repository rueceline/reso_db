# MapNeedleFactory

## Schema

```js
MapNeedleFactory = {
  id,
  idCN,
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
  LevelConditions: [
    {
      id,
    }
  ],
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
  UnitConditions: [
    {
      id,
    }
  ],
  childNeedle,
  defaultVisible,
  icon_x: [any],
  icon_y: [any],
  isShowUI,
  justOnce,
  lvCondition,
  neddleName,
  neddlePos,
  neddleUrl,
  needleAward: [
    {
      id,
      num,
    }
  ],
  triggerArgs,
  triggerOrder,
}
```
