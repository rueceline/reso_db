# HomeCoachSkinFactory

## Schema

```js
HomeCoachSkinFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  TBUnit,
  animeRoot,
  coachType,
  coordinate: [any],
  dirtySkins: [
    {
      dirtyPercent: [any],
      path,
    }
  ],
  glassNames: [any],
  homeWeaponPosList: [any],
  jetEffect,
  jetList: [
    {
      x: [any],
      xs: [any],
      xx,
      y: [any],
      ys: [any],
      yx,
      z: [any],
      zs: [any],
      zx,
    }
  ],
  leftPointX: [any],
  lightList: [
    {
      x: [any],
      xs,
      xx,
      y,
      ys,
      yx,
      z,
      zs,
      zx,
    }
  ],
  normalEntryList: [
    {
      id, // -> TrainWeaponSkillFactory.id
    }
  ],
  produceMaterialList: [
    {
      id,
      num,
    }
  ],
  rightPointX,
  runeList: [
    {
      x,
      xs,
      xx,
      y,
      ys,
      yx,
      z: [any],
      zs,
      zx,
    }
  ],
  showEffect,
  showLight,
  showWeapon,
  skinDetail,
  skinDisplay,
  skinItem,
  skinSize: [any],
  skinStore,
  skinTag,
  sonarList: [
    {
      x,
      xs,
      xx,
      y,
      ys,
      yx,
      z: [any],
      zs,
      zx,
    }
  ],
  specialEffect,
  study,
  techPoints,
  thumbnail,
  visualAngle,
  weaponList: [any],
  wheelAnimatorPath,
}
```
