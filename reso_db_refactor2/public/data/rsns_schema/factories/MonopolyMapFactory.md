# MonopolyMapFactory

## Schema

```js
MonopolyMapFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  diceList: [any],
  diceMax,
  girdList: [
    {
      id,
      index,
      next,
      x,
      y,
    }
  ],
  jigsawHeight,
  jigsawWidth,
  mapName,
  selectDiceMax,
}
```
