# AreaFactory

## Schema

```js
AreaFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  ClickDungeonEventList: [
    {
      id,
      max,
      min,
    }
  ],
  ClickDungeonEventPosList: [
    {
      icon_x: [any],
      icon_y: [any],
      pos_x: [any],
      pos_y: [any],
      pos_z: [any],
    }
  ],
  ClickEventList: [
    {
      id,
      max,
      min,
      minPolluteLimit,
    }
  ],
  ClickEventPosList: [
    {
      icon_x: [any],
      icon_y: [any],
      pos_x: [any],
      pos_y: [any],
      pos_z: [any],
    }
  ],
  ClickLevelList: [
    {
      id,
      countInit,
      countPollute,
      levelLvMax,
      levelLvMin,
      max: [any],
      min: [any],
      ratioInit: [any],
      ratioPollute: [any],
    }
  ],
  LineList: [
    {
      id,
    }
  ],
  MapEffectRSS,
  MapEffectRSSList: [
    {
      distance,
      name,
      pos_x,
      pos_y,
      pos_z,
    }
  ],
  RnWtList: [
    {
      RnWtId,
    }
  ],
  mutexType,
  polluteBgList: [any],
  polluteLevelList: [
    {
      id,
      max,
      min,
    }
  ],
  polluteList: [
    {
      weight,
      num,
    }
  ],
  polluteLvList: [
    {
      polluteLvMin,
      polluteLvOffsetMax,
      polluteLvOffsetMin,
      polluteLvSN,
    }
  ],
  polluteWeatherRate,
  polluteWtList: [any],
  polluteWuqi,
  polluteWuqiList: [
    {
      distance,
      name,
      pos_x: [any],
      pos_y: [any],
      pos_z: [any],
    }
  ],
  polluteX,
  polluteY,
}
```

## Relations

### Suspected
- AreaFactory.RnWtList[].RnWtId -> WeatherFactory.id (hit_ratio=1.000000, gap=1.000000, total=45; total<60)
