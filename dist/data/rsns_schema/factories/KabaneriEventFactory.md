# KabaneriEventFactory

## Schema

```js
KabaneriEventFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  buffList: [
    {
      weight,
      buff,
    }
  ],
  camp,
  condition,
  createList: [
    {
      atk,
      atkCD,
      distance,
      exitTime,
      hp,
      num,
      score,
      subMonsterNum,
      unit,
    }
  ],
  createUnitRangeY,
  duration,
  isWarn,
  junctionNum,
  num,
  unit,
  warnDesc,
  warnTime: [any],
}
```
