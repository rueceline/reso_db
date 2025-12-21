# TrainSkinStudyFactory

## Schema

```js
TrainSkinStudyFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  cityPrepare: [
    {
      id,
      lv,
    }
  ],
  energyPrepare: [
    {
      id,
      lv,
    }
  ],
  enumList: [
    {
      studyPic,
      trainType,
    }
  ],
  itemCost: [
    {
      id,
      num,
    }
  ],
  itemPrepare: [
    {
      id,
    }
  ],
  levelPrepare,
  mapList: [any],
  order,
  powerPrepare,
  reward: [
    {
      id,
      num,
    }
  ],
  seeLong,
  showPic,
  skinList: [any],
  studyPic,
  timeCost,
  treeStudy,
  tx,
  ty,
  tyo,
  tz,
}
```
