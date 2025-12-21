# ParkGridFactory

## Schema

```js
ParkGridFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  FerrisWheel,
  canMoveExtraGridList: [
    {
      id,
    }
  ],
  canMoveGridList: [
    {
      id,
    }
  ],
  clickX: [any],
  clickY,
  clickZ: [any],
  floor,
  gridEventList: [
    {
      id,
      weight,
    }
  ],
  gridSealList: [
    {
      id,
    }
  ],
  levelParam,
  order,
  particlePath,
  pic,
  prefabName,
  x,
  y,
}
```
