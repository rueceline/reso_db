# SkillFactory

## Schema

```js
SkillFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  iconPath,
  CommonNum: [any],
  ExSkillList: [
    {
      ExSkillName,
      isNeturality,
    }
  ],
  attriDetialList: [any],
  attributeIntensify: [
    {
      id,
    }
  ],
  attributeList: [
    {
      attributeType,
      attributeType2,
      attributeType3,
      numberType,
      numberType2,
      numberType3,
      value2_SN,
      value3_SN,
      value_SN,
    }
  ],
  buffId, // -> BuffFactory.id
  campList: [
    {
      name,
    }
  ],
  cardID,
  desParamList: [
    {
      isPercent,
      param,
    }
  ],
  description,
  detailDescription,
  digitSN,
  effectTarget,
  floatNum,
  isBaseAttr,
  isPercent,
  leaderCardConditionDesc,
  leaderCardConditionList: [
    {
      leaderCardConditionFO,
    }
  ],
  leaderCardEnableBuffId,
  levelUpDescription,
  maxAttrSN,
  minAttrSN,
  partList: [
    {
      name,
    }
  ],
  playerLevel,
  rarityColor,
  skillParamList: [
    {
      skillRateA_SN,
      skillRateB_SN,
      skillRateC_SN,
      skillRateD_SN,
      skillRateE_SN,
      skillRateF_SN,
      skillRateG_SN,
      skillRateH_SN,
      skillRateI_SN,
      skillRateJ_SN,
      skillRateL_SN,
      skillRateT_SN,
    }
  ],
  skillWeight,
  specialTagList: [
    {
      specialTag,
    }
  ],
  tagFilterList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  tagFilterType,
  tagId, // -> TagFactory.id
  tagName,
  tagRemoveList: [
    {
      tagId,
    }
  ],
  tempdescription,
  tempdetailDescription,
  templeaderCardConditionDesc,
  temptypeStr,
  typeColor,
  typeStr,
}
```
