# HomeLineFactory

## Schema

```js
HomeLineFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  AreaTipList: [
    {
      id,
      disMax,
      disMin,
    }
  ],
  AttractionList: [
    {
      id,
      disMax,
      disMin,
    }
  ],
  LineEnemyLv,
  LineEnemyLvRan,
  LineEnemyRn,
  LineWeatherList: [
    {
      LineWTid,
    }
  ],
  LineWeatherRate,
  areaList: [
    {
      areaId,
      disInterval,
      disMax,
      disMin,
    }
  ],
  bgmId,
  bgmId2,
  boxList: [
    {
      id,
      weight,
      distance,
    }
  ],
  boxMax,
  boxMin,
  boxPolluteNum,
  cityList: [
    {
      buildingId,
      cityId,
    }
  ],
  distance: [any],
  enemyLevelMin,
  eventHpRatio,
  forceNeedleList: [
    {
      id,
    }
  ],
  lineBgList: [
    {
      LineBgid,
      distance0,
    }
  ],
  lineLevelList: [
    {
      id,
      weight,
      distance,
    }
  ],
  lineMsg: [
    {
      id,
      lineMax: [any],
      lineMin,
    }
  ],
  lineQuestList: [
    {
      id,
    }
  ],
  mapNeedleList: [
    {
      id,
    }
  ],
  playerLevel,
  questId,
  robCountList: [
    {
      weight,
    }
  ],
  robDisMax,
  robDisMin,
  robInterval,
  robList: [
    {
      id,
      weight,
    }
  ],
  sceneGroup,
  specifiedLevelId,
  station01,
  station02,
  triggerNumMax,
  triggerNumMin,
  wayPointList: [
    {
      x: [any],
      y: [any],
    }
  ],
}
```

## Relations

### Suspected
- HomeLineFactory.areaList[].areaId -> AreaFactory.id (hit_ratio=1.000000, gap=1.000000, total=38; total<60)
- HomeLineFactory.bgmId -> SoundFactory.id (hit_ratio=1.000000, gap=1.000000, total=46; total<60)
- HomeLineFactory.cityList[].buildingId -> BuildingFactory.id (hit_ratio=1.000000, gap=1.000000, total=46; total<60)
- HomeLineFactory.cityList[].cityId -> HomeStationFactory.id (hit_ratio=1.000000, gap=1.000000, total=48; total<60)
