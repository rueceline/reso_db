# EquipmentFactory

## Schema

```js
EquipmentFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  iconPath,
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
  SetId,
  attack_SN,
  campTagId, // -> TagFactory.id
  defence_SN,
  disappearSkillList: [
    {
      skillId, // -> SkillFactory.id
    }
  ],
  equipTagId, // -> TagFactory.id
  growthId, // -> GrowthFactory.id
  healthPoint_SN,
  randomSkillList: [
    {
      skillId, // -> ListFactory.id
      weight,
    }
  ],
  skillList: [
    {
      skillId, // -> SkillFactory.id
    }
  ],
}
```
