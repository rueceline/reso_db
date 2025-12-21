# AbyssFactory

## Schema

```js
AbyssFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  abyssDes,
  abyssIndex,
  abyssName,
  abyssPeriodId, // -> AbyssPeriodFactory.id
  firstPassAward: [any],
  firstPassAwardS: [any],
  levelList: [
    {
      id,
      spinePosX,
      spinePosY,
      spineScale: [any],
    }
  ],
  timeStar,
}
```
