# TrainRoadMsgFactory

## Schema

```js
TrainRoadMsgFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  cubeMapPath,
  effectList: [
    {
      alphaStr,
      colorStr,
      parentName,
    }
  ],
  enableRainbow,
  equatorColorStr,
  fogColor,
  fogDensity,
  fogEnable,
  fogMode,
  groundColorStr,
  inactiveList: [
    {
      effectUrl,
    }
  ],
  intensityMultiplie,
  processPath,
  rainbowAngle,
  rainbowDistance,
  sceneObjectPath,
  skyBoxPath,
  skyColorStr,
  viewDistance,
  waterColorFarStr,
  weatherList: [
    {
      weatherId,
    }
  ],
  weatherRateSN,
}
```
