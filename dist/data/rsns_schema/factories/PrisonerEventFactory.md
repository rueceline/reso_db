# PrisonerEventFactory

## Schema

```js
PrisonerEventFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  haloFetterList: [
    {
      actionName,
      display,
      eventType,
      fetterId,
      fetterNum,
      healthNum,
      isOthers,
      isOwn,
      isPunish,
      prisonerId,
      stopProduce,
    }
  ],
  personalityFetterList: [
    {
      combinationAcotionName,
      combinationAcotionSpinePath,
      eventType,
      fetterId,
      fetterNum,
      firstActionName,
      firstDisplay,
      firstHealthNum,
      firstIsEffect,
      firstIsPunish,
      firstPrisonerId,
      secondActionName,
      secondDisplay,
      secondHealthNum,
      secondIsEffect,
      secondIsPunish,
      secondPrisonerId,
      stopProduce,
    }
  ],
}
```

## Relations

### Suspected
- PrisonerEventFactory.personalityFetterList[].fetterId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=36; total<60)
- PrisonerEventFactory.personalityFetterList[].firstPrisonerId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=36; total<60)
- PrisonerEventFactory.personalityFetterList[].secondPrisonerId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=36; total<60)
