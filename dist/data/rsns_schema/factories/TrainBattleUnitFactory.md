# TrainBattleUnitFactory

## Schema

```js
TrainBattleUnitFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  AmmoMax,
  BornSkill,
  Camp,
  DamageParam1,
  DamageParam2,
  DamageParam3,
  DeadSkill,
  DeathEvents: [any],
  DrillOffsetX,
  DrillOffsetY,
  DrillOffsetZ,
  FireEffect,
  FireEndAudio,
  FireLoopAudio,
  FireStartAudio,
  GunOffsetX: [any],
  GunOffsetY,
  GunOffsetZ,
  HitTargetEffect,
  Hp,
  NotEnoughAmmoAudio,
  OffsetX: [any],
  OffsetY,
  OffsetZ,
  ReloadingSkill,
  RotSpeed,
  SearchRange,
  Shooter: [
    {
      OffsetX: [any],
      OffsetY: [any],
      OffsetZ: [any],
      ShooterPath,
    }
  ],
  ShooterType,
  Skills: [
    {
      SkillID,
      Weight,
    }
  ],
  Speed: [any],
  UseBullets: [
    {
      weight,
      goods,
      rate,
    }
  ],
  XAxisNode,
  XRotMax,
  XRotMin,
  YAxisNode,
  YRotAngle,
  aimYOffset,
  atkYOffset,
  beHitEffect,
  buff,
  colliders: [
    {
      centerX,
      centerY: [any],
      centerZ: [any],
      colliderType,
      sizeX: [any],
      sizeY: [any],
      sizeZ: [any],
    }
  ],
  curveMax,
  curveUnit,
  damageParam,
  deathFx,
  deathRot,
  directDeath,
  followX,
  followY,
  followZ,
  hitSound,
  hitted: [
    {
      anime,
    }
  ],
  jumpCount,
  leaveSkill,
  maxSpeed,
  modelScale: [any],
  modelScaleMax,
  modelScaleMin,
  monsName,
  resPath,
  smoothTime,
  specialColliders: [any],
}
```
