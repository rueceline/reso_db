# TrainBattleWeaponFactory

## Schema

```js
TrainBattleWeaponFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  Ammo,
  AmmoMax,
  Damage,
  DefaultCameraOffset: [
    {
      X,
      Y,
      Z,
    }
  ],
  FireEffect,
  FireEndAudio,
  FireLoopAudio,
  FireStartAudio,
  NotEnoughAmmoAudio,
  ReloadingTime,
  ResPath,
  RotSpeed,
  ShootAmmoNum,
  ShootCDTime: [any],
  ShootStartTime,
  Shooter: [
    {
      OffsetX,
      OffsetY,
      OffsetZ: [any],
      ShooterPath,
    }
  ],
  ShooterType,
  State: [
    {
      Ammo,
      FireEffect,
      FireEndAudio,
      FireLoopAudio,
      FireStartAudio,
      HoldEffect,
      OffsetSpeed: [any],
      Time,
      X,
      Y,
      Z,
    }
  ],
  XAxisNode,
  XRotMax,
  XRotMin,
  YAxisNode,
}
```
