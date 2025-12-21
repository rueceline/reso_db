# BackgroundFactory

## Schema

```js
BackgroundFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  blendList: [any],
  forbidWeatherList: [
    {
      weatherId, // -> WeatherFactory.id
    }
  ],
  isLoop,
  loopGameObjectName,
  loopGameObjectWidth: [any],
  moveSpeed,
  resStr,
  shakeList: [
    {
      firstDelay,
      intervalRandom,
      intervalStart,
      shakeEffectId,
    }
  ],
}
```
