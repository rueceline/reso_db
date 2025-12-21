# MonopolyGridFactory

## Schema

```js
MonopolyGridFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  basePath,
  canReopen,
  continueStep,
  desc,
  goods: [any],
  imagePath,
  nodeType,
  openPanelPath,
  resPath,
  rewards: [
    {
      id,
      maxCount,
      minCount,
    }
  ],
}
```
