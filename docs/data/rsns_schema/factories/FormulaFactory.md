# FormulaFactory

## Schema

```js
FormulaFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  added: [
    {
      id,
      chance: [any],
      numMax,
      numMin,
    }
  ],
  composeCondition: [
    {
      id,
      num,
    }
  ],
  doneCost: [any],
  draw: [
    {
      id,
      numMax,
      numMin,
    }
  ],
  drawForm: [
    {
      id,
      num,
    }
  ],
  drawingItem,
  drawingLevel,
  drawingQuality,
  drawingTime,
  drawingname,
  energyCondition: [any],
  isAdded,
  machiningEXP,
  numLimit,
  playerExp,
  quantity,
  unlock,
  unlockenergyCondition: [
    {
      id,
      num,
    }
  ],
}
```
