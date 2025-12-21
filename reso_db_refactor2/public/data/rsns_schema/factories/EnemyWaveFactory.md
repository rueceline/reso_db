# EnemyWaveFactory

## Schema

```js
EnemyWaveFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  awake,
  delayFrame,
  dropTableList: [
    {
      listId, // -> ListFactory.id
    }
  ],
  effectBeforeBattleId, // -> EffectFactory.id
  enemyList: [
    {
      id,
      atkRateSN,
      controllerId, // -> ControllerFactory.id
      defRateSN,
      enemyListId,
      hpRateSN,
      x_SN,
      z_SN,
    }
  ],
  finishGuildanceList: [
    {
      guildanceID,
    }
  ],
  goingGuildanceList: [
    {
      guildanceID,
    }
  ],
  lv,
  resonance,
  startGuildanceList: [
    {
      guildanceID,
    }
  ],
  waveAfter,
}
```
