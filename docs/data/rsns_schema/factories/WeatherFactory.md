# WeatherFactory

## Schema

```js
WeatherFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  WeatherType,
  backgroundResUrl,
  buffId,
  combinePath,
  duration,
  effectId,
  endEffectId,
  environDetail,
  environIconPath,
  environName,
  floatValueList: [
    {
      value,
      key,
    }
  ],
  fogLevel: [
    {
      rateOverTime,
    }
  ],
  homeid,
  iconResUrl,
  interval,
  intervalFrame,
  isSecond,
  isSkill,
  isTipTrigger,
  offsetXSN,
  offsetYSN,
  offsetZSN,
  postEffectName,
  radiusSN,
  rainLevel: [
    {
      rateOverTimeBack,
      rateOverTimeFront,
      rateOverTimeSplash,
      windForce,
    }
  ],
  recycleDelayFrame,
  resUrl,
  snowLevel: [
    {
      EmissionPosX,
      alpha,
      fogRate,
      fogSpeedMax,
      fogSpeedMin,
      invalidParticle,
      mainVelocityMax: [any],
      mainVelocityMin: [any],
      noiseStrength,
      rate,
      sideVelocityMax,
      sideVelocityMin,
    }
  ],
  startEffectId,
  tempenvironDetail,
  tempenvironName,
  weatherDetailList: [
    {
      resUrl,
      text,
    }
  ],
  weatherName,
}
```

## Relations

### Suspected
- WeatherFactory.effectId -> EffectFactory.id (hit_ratio=1.000000, gap=1.000000, total=32; total<60)
- WeatherFactory.buffId -> BuffFactory.id (hit_ratio=1.000000, gap=1.000000, total=48; total<60)
