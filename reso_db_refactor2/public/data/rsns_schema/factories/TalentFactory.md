# TalentFactory

## Schema

```js
TalentFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  attriDetialList: [any],
  attributeIntensify: [
    {
      id,
    }
  ],
  attributeList: [
    {
      attributeType,
      numType,
      num_SN,
    }
  ],
  awakeLv,
  desc,
  path,
  skillActiveUpgrade: [
    {
      id,
    }
  ],
  skillChangeList: [
    {
      newSkillId,
      oldSkillId,
    }
  ],
  skillIntensify,
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
- TalentFactory.skillChangeList[].newSkillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=54; total<60)
- TalentFactory.skillChangeList[].oldSkillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=54; total<60)
