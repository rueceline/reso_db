# BuffFactory

## Schema

```js
BuffFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  ActionId, // -> UnitActionFactory.id
  aNormalize,
  additionalBuffList: [
    {
      additionalBuffId,
    }
  ],
  adjustCostList: [
    {
      cardId,
      cost_SN,
    }
  ],
  adjustTeamAttribute: [
    {
      attributeType,
      numberType,
      rateTag,
      value_SN,
    }
  ],
  afterScaleFrame,
  aimBuffId, // -> BuffFactory.id
  appearEffect,
  appearEffectList: [
    {
      effectId, // -> EffectFactory.id
    }
  ],
  attributeChangeList: [
    {
      attributeType,
      level,
      numberType,
      rateTag,
      skillSelect,
      value_SN,
    }
  ],
  attributeList: [
    {
      attributeType,
      numberType,
      tag,
      value_SN,
    }
  ],
  attributeType,
  b,
  bDamageWithLevel,
  bForever,
  bGraveyard,
  bHand,
  bLibrary,
  bMore,
  bShowLevel,
  backtrackBuff,
  banCrit,
  baseEffect,
  baseRateTag,
  baseValue_SN,
  battleTagIdList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  buff,
  buffEffectByLevel: [
    {
      effectIdFirst,
      effectIdSecond,
      effectIdThird,
      level,
    }
  ],
  buffFO,
  buffId, // -> BuffFactory.id
  buffList: [
    {
      buffId, // -> BuffFactory.id
    }
  ],
  buffShieldList: [
    {
      buffId,
    }
  ],
  buffSortType,
  buffTreeId,
  buffType: [any],
  buffTypeFO,
  camp,
  canOverHand,
  cantBeDispelled,
  cardEffect,
  cardId,
  cardNum,
  cardNumRateTag,
  cardNumRate_SN,
  cardNumTag,
  cardNum_SN,
  cardSource,
  cardSourceList: [
    {
      cardSource,
    }
  ],
  cardType,
  changeActionList: [
    {
      sourceActionID,
      targetActionID,
    }
  ],
  changeBuffId, // -> BuffFactory.id
  changeEffectId,
  commandIndex,
  compareType,
  compareValue_SN,
  condition,
  controllerId,
  cooldownFrame,
  costRate_SN,
  costSource,
  cost_SN,
  count,
  count_SN,
  customDataList: [
    {
      customTag,
    }
  ],
  customDataTag,
  customDataTagBase,
  customTag,
  customTagSource,
  damageSource,
  damageType,
  deadCount,
  deckIndex,
  destination,
  destinationCardID,
  destroyViewDelay,
  disappearEffectList: [
    {
      effectId, // -> EffectFactory.id
    }
  ],
  discardBuff,
  dispelEffectList: [
    {
      buffId, // -> BuffFactory.id
      targetType,
    }
  ],
  dispelEffectPointType,
  dispelOffsetX,
  dispelOffsetY,
  dispelPolymorphEffectId,
  dispelTime,
  dotEffectList: [
    {
      buffId, // -> BuffFactory.id
      targetType,
    }
  ],
  drawCardId, // -> SkillFactory.id
  duration: [any],
  durationFrame,
  durationTag,
  effectId, // -> EffectFactory.id
  effectList: [
    {
      effectId,
      leaderEffectId,
      level,
    }
  ],
  effectPointType,
  enableOutline,
  energySN,
  env,
  envId, // -> WeatherFactory.id
  envList: [
    {
      envId,
    }
  ],
  extraMutiple,
  fadeInFrame,
  fadeOutFrame,
  filterBuffFO,
  filterBuffJudgeType,
  filterBuffLevel,
  filterBuffTypeFO,
  filterPosition,
  filterStance,
  firstFrame,
  formulaStr,
  frame,
  frameAdd,
  frameEventList: [
    {
      frameEventId, // -> FrameEventFactory.id
      hHalf_SN,
      isUseTargetPosition,
      wHalf_SN,
      x_SN,
      y_SN,
    }
  ],
  from,
  g,
  halfWidth_SN,
  handBuffId,
  handCount,
  handIndex,
  hideViewDelay,
  hitEffect,
  iconUrl,
  ignoreBuffList: [any],
  ignoreRecover,
  immuneEffect,
  initScale,
  intarval,
  interval,
  intervalFrame,
  isAbovePowerBar,
  isAdd,
  isAddTime,
  isAdditive,
  isAimSelf,
  isAimSelfMakeDammage,
  isAtBattleCenter,
  isBasedOnBattleAreaCenter,
  isBasedOnSelf,
  isBindAction,
  isCancelAutoDraw,
  isCardNumFillHand,
  isChangeCardType,
  isChangeLeaderCard,
  isChangeLeaderCardCondition,
  isChangeOrigin,
  isDamage,
  isDead,
  isDeadDontDestroy,
  isDiscardOther,
  isDispelAll,
  isDispelCantDispel,
  isDispelFightEnd,
  isDrawCard,
  isEnemyOnly,
  isExcludeSelf,
  isFindOriginalCard,
  isFirst,
  isFirstUse,
  isFixedPosition,
  isForce,
  isForceChange,
  isForceSearch,
  isFromSelf,
  isHeal,
  isHitSpakle,
  isIgnoreDeadCard,
  isIgnoreDefence,
  isIgnoreLockCost,
  isImmune,
  isImmuneOnlyOne,
  isIncludeCantDispel,
  isIncludeDeck,
  isIncludeDiscardBtn,
  isIncludeFall,
  isIncludeGrave,
  isIncludeHand,
  isIncludeSkill,
  isIncludeSummon,
  isJudge,
  isLeaderCard,
  isLeaderSource,
  isMustCrit,
  isNoAdditionalAttack,
  isNormalAttack,
  isNotChangePos,
  isNotRecord,
  isNotRecordDamageAsCard,
  isNotShowDamage,
  isNotUseCardActionData,
  isOnlyOne,
  isOverHandNum,
  isPrecent,
  isRandom,
  isRandomDeck,
  isRandomGrave,
  isRandomMakeUp,
  isRecord,
  isRefreshSnapshot,
  isRepeatable,
  isReturnInHand,
  isReviveCondition,
  isSameAttribute,
  isSameColor,
  isSelf,
  isSetCost,
  isShowImmune,
  isShowImmuneDamage,
  isSkill,
  isSkillAttack,
  isSkillLua,
  isStop,
  isStraightDamage,
  isSummonSelf,
  isSyncLogic,
  isTarget,
  isTargetsCardOnly,
  isTempCost,
  isTempory,
  isToAlly,
  isToEnemy,
  isToGraveyard,
  isToTeam3,
  isTriggerDispelEffect,
  isUnitDir,
  isUseSnapshotDirection,
  isZNotChange,
  jobId,
  judgeBuff,
  judgeBuffId,
  judgeCondition,
  judgeLevel,
  judgeRateTag,
  judgeRate_SN,
  judgeTagId,
  judgeTagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  judgeTagNum,
  judgeType,
  leaderId,
  level,
  levelMax,
  levelMaxTag,
  levelTag,
  lineColorA,
  lineColorB,
  lineColorG,
  lineColorR,
  list: [any],
  lockCost_SN,
  loopFrame,
  loopVideoPath,
  luckType,
  maxLevelBuffId, // -> BuffFactory.id
  notUseCardActionData,
  num,
  numSkillTag1,
  numSkillTag2,
  numSkillTag3,
  numSkill_SN1,
  numSkill_SN2,
  numSkill_SN3,
  num_SN,
  numberType,
  number_SN,
  offsetX: [any],
  offsetXSN,
  offsetX_SN,
  offsetY: [any],
  offsetYSN,
  offsetZSN,
  offsetZ_SN,
  originalCardID,
  outlineWidth,
  overlayTimeType,
  overlayType,
  overlayValueType,
  ownerAttributeType,
  percent_SN,
  posXSN,
  progress,
  propertyList: [
    {
      customDataTag,
      numType,
      propertyType,
      skillRateFactorSN,
      skillRateTag,
      sourcesProperty,
    }
  ],
  r,
  radiusSN,
  radius_SN,
  randomEffectList: [
    {
      effectId,
      effectPointType,
      offsetX,
      offsetY,
    }
  ],
  randomOffsetX_SN,
  randomOffsetZ_SN,
  randomX_SN,
  randomY_SN,
  randomZ_SN,
  rateFactorSN,
  rateSN,
  repelledType,
  scalePreFrame,
  setCustomValue,
  shakeDuration,
  shakeXPerFrame: [any],
  showLevelInfoId,
  side,
  skillMultTag,
  skillParamList: [
    {
      skillId,
      tag,
      valueSN,
    }
  ],
  skillParamSN,
  skillParamTag,
  skillRateFactorSN,
  skillRateTag,
  skillSelect,
  skinList: [
    {
      ownerSkinId,
      selfSkinId,
    }
  ],
  skinUnitList: [any],
  sound,
  soundId,
  source,
  sourceBase,
  sourceList: [any],
  specificBuff,
  speedXSN,
  speedX_SN,
  speedYSN,
  speedY_SN,
  speedZ_SN,
  summonID,
  summonList: [
    {
      summonId,
    }
  ],
  tTarget,
  tag,
  tagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  tagType,
  takeDamagePercent_SN,
  targetAttributeType,
  targetBuff,
  targetBuffId, // -> BuffFactory.id
  targetBuffTypeId,
  targetCount,
  targetEffect,
  targetPrefix,
  targetTagIds: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  targetTagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  targetType,
  team,
  teamType,
  timeUpEffectList: [
    {
      buffId, // -> BuffFactory.id
      targetType,
    }
  ],
  toFixedX,
  toSnapshotPos,
  treeRoot: [any],
  type,
  typeList: [any],
  typeTagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  unit,
  useDamageSnapshot,
  useMakeDamage,
  useTargetProperty,
  valueSN,
  valueTag,
  value_SN,
  videoPath,
  waveOffsetX_SN,
  weather,
  weatherId,
  weatherLv,
  yTag,
}
```

## Relations

### Suspected
- BuffFactory.judgeBuffId -> BuffFactory.id (hit_ratio=0.954545, gap=0.909091, total=1078; ratio<0.985)
- BuffFactory.judgeTagId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=30; total<60)
- BuffFactory.unitId -> UnitFactory.id (hit_ratio=1.000000, gap=1.000000, total=31; total<60)
- BuffFactory.summonList[].summonId -> UnitFactory.id (hit_ratio=1.000000, gap=1.000000, total=33; total<60)
- BuffFactory.logicId -> LogicFactory.id (hit_ratio=1.000000, gap=1.000000, total=33; total<60)
- BuffFactory.additionalBuffList[].additionalBuffId -> BuffFactory.id (hit_ratio=1.000000, gap=1.000000, total=35; total<60)
- BuffFactory.effectList[].leaderEffectId -> EffectFactory.id (hit_ratio=1.000000, gap=1.000000, total=37; total<60)
- BuffFactory.leaderId -> LeaderCardConditionFactory.id (hit_ratio=1.000000, gap=1.000000, total=37; total<60)
- BuffFactory.controllerId -> ControllerFactory.id (hit_ratio=1.000000, gap=1.000000, total=38; total<60)
- BuffFactory.skillList[].skillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=38; total<60)
- BuffFactory.soundId -> SoundFactory.id (hit_ratio=1.000000, gap=1.000000, total=47; total<60)
- BuffFactory.skillParamList[].skillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=55; total<60)
- BuffFactory.effectList[].effectId -> EffectFactory.id (hit_ratio=1.000000, gap=1.000000, total=55; total<60)
- BuffFactory.randomEffectList[].effectId -> EffectFactory.id (hit_ratio=1.000000, gap=1.000000, total=59; total<60)
