# EngineCoreFactory

## Schema

```js
EngineCoreFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  battleName,
  battleNum,
  breakDi1Path,
  breakDi2Path,
  breakEffects1,
  breakEffects2,
  breakEffects3,
  breakIconPath,
  breakPath,
  challengeTips,
  color,
  coreExpList: [
    {
      id,
      effects,
      isBreak,
      num,
    }
  ],
  coreIconPath,
  coreIconPathW,
  coreLevelList: [
    {
      id,
      grade,
      profileId,
    }
  ],
  electricLimit,
  gradePath,
  informationPath,
  mvpNum,
  nameEN,
  overviewBgPath,
  overviewSelectPath,
  record,
  rewardBgPath,
  rewardDes,
  rewardGetPath,
  rewardIconPath,
  rewardNotPath,
  settlementIconPath,
  settlementNum,
  upEffects,
}
```

## Relations

### Suspected
- EngineCoreFactory.coreLevelList[].profileId -> UnitFactory.id (hit_ratio=1.000000, gap=1.000000, total=32; total<60)
