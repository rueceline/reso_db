# LevelGroupFactory

## Schema

```js
LevelGroupFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  iconPath,
  bossHp,
  bossRewardList: [
    {
      id,
      bossBattleTimes,
      ratio: [any],
    }
  ],
  bossSpineScaleX: [any],
  bossSpineScaleY: [any],
  bossSpineX,
  bossSpineY,
  bossViewId,
  closedTextId,
  cost,
  levelList: [
    {
      id,
    }
  ],
  nameE,
  openDay: [
    {
      week,
    }
  ],
  rankId,
  rankName,
  rankRewardList: [
    {
      id,
      rank,
    }
  ],
  rewardViewList: [
    {
      id,
    }
  ],
  spineScale,
  spineX,
  spineY,
  unLockLevel,
}
```

## Relations

### Suspected
- LevelGroupFactory.bossViewId -> UnitViewFactory.id (hit_ratio=1.000000, gap=1.000000, total=36; total<60)
