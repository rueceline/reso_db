# RogueEquipmentFactory

## Schema

```js
RogueEquipmentFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  iconPath,
  attributeList: [
    {
      id,
    }
  ],
  conditionList: [
    {
      conditionId,
      effectId,
      opportunity,
    }
  ],
  efficacyNum,
  efficacyType,
  isNegative,
  isSaveEffect,
  rogueId,
}
```

## Relations

### Suspected
- RogueEquipmentFactory.conditionList[].effectId -> RogueOrderFactory.id (hit_ratio=1.000000, gap=1.000000, total=45; total<60)
