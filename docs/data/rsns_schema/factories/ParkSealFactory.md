# ParkSealFactory

## Schema

```js
ParkSealFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  combineSeal: [
    {
      id,
    }
  ],
  combineSkillId,
  itemId,
  skillId,
  typeInfo,
}
```

## Relations

### Suspected
- ParkSealFactory.combineSkillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=35; total<60)
