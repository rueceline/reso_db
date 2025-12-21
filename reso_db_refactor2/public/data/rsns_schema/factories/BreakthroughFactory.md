# BreakthroughFactory

## Schema

```js
BreakthroughFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  attriDetialList: [any],
  attributeList: [
    {
      attributeType,
      numType,
      num_SN,
    }
  ],
  desc,
  materialList: [
    {
      itemId, // -> SourceMaterialFactory.id
      num,
    }
  ],
  path,
  skillChangeList: [
    {
      newSkillId,
      oldSkillId,
    }
  ],
  skillList: [
    {
      skillId, // -> SkillFactory.id
    }
  ],
  skillParamOffsetList: [
    {
      skillId,
      tag,
      value_SN,
    }
  ],
  tempdesc,
}
```

## Relations

### Suspected
- BreakthroughFactory.skillParamOffsetList[].skillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=38; total<60)
