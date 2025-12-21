# HomeWeaponFactory

## Schema

```js
HomeWeaponFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  tipsPath,
  Getway: [
    {
      DisplayName,
      FromLevel,
      UIName,
      Way3,
      funcId,
    }
  ],
  TbUnit,
  TrainWeaponMakeUp: [
    {
      id,
      num,
    }
  ],
  TrainWeaponTips: [any],
  WeaponLow,
  WeaponTired,
  XEffects,
  YEffects: [any],
  ZEffects: [any],
  cannonModel,
  configNumMax,
  configNumMin,
  configNumPer,
  configWinPercent,
  coreList: [
    {
      id,
      level,
    }
  ],
  createDes,
  effectStyleType,
  effectType,
  effectTypeEffect,
  fixCoin,
  goldCost,
  growUpEntryList: [
    {
      id, // -> TrainWeaponSkillFactory.id
    }
  ],
  hitEventType: [
    {
      id,
    }
  ],
  hp,
  hpLoss,
  imagePath,
  isCost,
  isFirst,
  materialList: [
    {
      level,
      list,
    }
  ],
  normalEntryList: [
    {
      id, // -> TrainWeaponSkillFactory.id
    }
  ],
  percentWin,
  power,
  randomSkillList: [any],
  randomSkillNum,
  specialEffects,
  techPoints,
  timeLineEffect,
  typeSWeapon,
  typeWeapon,
  weaponType,
}
```
