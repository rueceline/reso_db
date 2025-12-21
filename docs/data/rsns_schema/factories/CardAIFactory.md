# CardAIFactory

## Schema

```js
CardAIFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  cardAISensorList: [any],
  commonActionList: [any],
  commonCardAvailableConditionList: [
    {
      cardAvailableConditionId,
    }
  ],
  commonWeightAdjustmentList: [any],
  firstThinkDelay,
  thinkInterval,
}
```
