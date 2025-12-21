# TurntableBattleFactory

## Schema

```js
TurntableBattleFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  FirstParagraphid,
  abyssPeriodList: [
    {
      id,
    }
  ],
  clickParagraphid,
  countDay,
  enemySkillList1: [any],
  enemySkillList2: [any],
  enemySkillList3: [any],
  levelBossList: [
    {
      id,
      count,
      bossName,
      buffId,
      spineScale: [any],
      spineX,
      spineY,
      star,
    }
  ],
  levelList: [
    {
      id,
      weight,
    }
  ],
  lvList: [any],
  openLv,
  playerSkillList1: [any],
  playerSkillList2: [any],
  playerSkillList3: [any],
  scoresMax,
}
```

## Relations

### Suspected
- TurntableBattleFactory.levelBossList[].buffId -> ListFactory.id (hit_ratio=1.000000, gap=1.000000, total=37; total<60)
