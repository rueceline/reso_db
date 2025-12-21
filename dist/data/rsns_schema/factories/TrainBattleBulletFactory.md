# TrainBattleBulletFactory

## Schema

```js
TrainBattleBulletFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  BornPosType,
  BulletEffect,
  CheckAreaParam1,
  CheckAreaParam2,
  CheckAreaParam3,
  CheckTime: [any],
  CheckType,
  ChildBulletList: [
    {
      id,
      dirX,
      dirY,
      dirZ,
      offsetX,
      offsetY,
      offsetZ,
    }
  ],
  Damage,
  DamageRange,
  Gravity,
  HitEffect,
  HitRecycle,
  Knockback,
  LifeTime: [any],
  LockEnemyNum,
  MaxLength,
  MoveHitToSource,
  MoveSpeed: [any],
  Name,
  RotAddSpeed,
  RotationSpeed,
  SearchAngle,
  StartUpSpeed,
  TargetType: [
    {
      tType,
    }
  ],
  TrailParticleCount,
}
```
