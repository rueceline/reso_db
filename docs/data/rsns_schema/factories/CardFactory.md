# CardFactory

## Schema

```js
CardFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  iconPath,
  ExActList: [
    {
      condId, // -> CardAIActionFactory.id
      des,
    }
  ],
  ExCondList: [
    {
      condId, // -> CardAIConditionFactory.id
      des,
      interValNum,
      isNumCond,
      minNum,
      numDuration,
      typeEnum,
    }
  ],
  actionId, // -> UnitActionFactory.id
  appearEffectId, // -> EffectFactory.id
  atkAreaColor,
  atkAreaType,
  attributeType,
  backPath,
  banishBuffId,
  buffFO,
  buffJudgeType,
  buffLevel,
  buffTypeFO,
  cardAIActionList: [
    {
      weight,
      actionId,
      conditionId,
    }
  ],
  cardType,
  chargeSkillId,
  chargeTotal,
  color,
  condition,
  cost_SN,
  createEffectId, // -> EffectFactory.id
  createTweenDelay,
  currentCharge,
  deriveCardList: [
    {
      SkillId,
    }
  ],
  destroyEffectId,
  disappearEffectId, // -> EffectFactory.id
  discardBuffId,
  discardBySkillBuffId,
  distance_SN,
  filterPosition,
  filterStance,
  halfWidth_SN,
  inhandBuffId,
  inhandOverBuffId,
  isAimSelf,
  isCostX,
  isCutIn,
  isIgnoreInvisibleEnemy,
  isNoCD,
  isNotDiscard,
  isUseInHand,
  isUseSingleTarget,
  isUseTargetFilter,
  linkCardId: [
    {
      Id, // -> CardFactory.id
    }
  ],
  numberType,
  number_SN,
  radius_SN,
  roleImgPath,
  sameCardGroupId,
  startBuffId, // -> BuffFactory.id
  tagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  tagOutsideList: [
    {
      tagId,
    }
  ],
  tagType,
  targetColor,
  targetCount,
  targetTagList: [
    {
      tagId,
    }
  ],
  targetType,
}
```

## Relations

### Suspected
- CardFactory.cardAIActionList[].actionId -> CardAIActionFactory.id (hit_ratio=1.000000, gap=1.000000, total=57; total<60)
