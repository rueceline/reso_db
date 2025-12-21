# TextFactory

## Schema

```js
TextFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  animName,
  goodsString,
  isLoop,
  isReplace,
  noDataString,
  noDataTextId,
  pfp,
  playerNameString,
  preAnimName,
  replaceType,
  soundList: [
    {
      id,
      replaceType,
    }
  ],
  stationString,
  text,
}
```

## Relations

### Suspected
- TextFactory.noDataTextId -> TextFactory.id (hit_ratio=1.000000, gap=1.000000, total=49; total<60)
