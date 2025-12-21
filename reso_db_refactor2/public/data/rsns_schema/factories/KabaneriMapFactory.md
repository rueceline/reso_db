# KabaneriMapFactory

## Schema

```js
KabaneriMapFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  baseMonsterAtk,
  baseMonsterHp,
  baseMonsterHpP1,
  baseMonsterHpP2,
  baseMonsterHpRandom,
  baseMonsterNum,
  baseMonsterNumP1,
  baseMonsterNumP2,
  baseMonsterSocre,
  bossAtkParam,
  bossHpParam,
  completeAwardS: [
    {
      id,
      num,
    }
  ],
  fatigueStart,
  gameTime,
  grid2Pool: [
    {
      weight,
      grid,
    }
  ],
  grid3Pool: [
    {
      weight,
      grid,
    }
  ],
  gridPool: [
    {
      weight,
      grid,
    }
  ],
  itemCost: [
    {
      id,
      num,
    }
  ],
  levelIcon,
  levelId,
  levelName,
  luaEventList: [
    {
      eventType,
      eventVal,
      eventid,
      isLoop,
      loopFloat,
      loopOver,
      loopTime,
    }
  ],
  mapType,
  monsterGenertor: [
    {
      Weight,
      endTime,
      monsID,
      startTime,
    }
  ],
  rewardLimit: [
    {
      pointLimit,
      time,
    }
  ],
  scoreParam,
  tokenId,
  tokenRatio,
  weatherPool: [
    {
      id,
      weight,
    }
  ],
}
```
