# UnitActionFactory

## Schema

```js
UnitActionFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  actionLevel,
  attributeType,
  backShakeFrame,
  buffFO,
  buffJudgeType,
  buffLevel,
  buffTypeFO,
  cdFrame,
  condition,
  damageHitBuffList: [any],
  distance_SN,
  filterPosition,
  filterStance,
  halfWidth_SN,
  healHitBuffList: [any],
  isAimSelf,
  isCharge,
  isCustomRadius,
  isIgnoreInvisibleEnemy,
  isSkill,
  isUseBigNumber,
  isUseTargetFilter,
  numberType,
  number_SN,
  radiusTag,
  radius_SN,
  stateIdList: [
    {
      bPlayTimes,
      stateId, // -> UnitStateFactory.id
      timesRate_SN,
      timesSource,
    }
  ],
  tagType,
  targetCount,
  targetTagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  targetType,
}
```
