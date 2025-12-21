# TrainBattleSkillFactory

## Schema

```js
TrainBattleSkillFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  AnimList: [
    {
      StartTime,
      StateName,
    }
  ],
  AudioList: [
    {
      id,
      StartTime: [any],
    }
  ],
  BulletList: [
    {
      id,
      OffsetX: [any],
      OffsetY,
      OffsetZ,
      StartTime,
    }
  ],
  CD: [any],
  EffectList: [any],
  InterruptTime: [any],
  LifeTime: [any],
  RunningEvents: [
    {
      EventType,
      Param1,
      Param2,
      Param3,
      StartTime: [any],
    }
  ],
  SubSkills: [
    {
      id,
    }
  ],
}
```
