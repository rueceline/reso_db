# UnitFactory

## Schema

```js
UnitFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  CvName,
  EnglishName,
  FoodList: [
    {
      id,
      letter,
    }
  ],
  ProfilePhotoList: [
    {
      id,
      weight,
    }
  ],
  ResumeList: [
    {
      des,
    }
  ],
  StoryList: [any],
  WasteCoefficient,
  ability,
  abilityList: [
    {
      id,
    }
  ],
  actionAttackedBackID,
  actionAttackedID,
  actionDeadID,
  actionKnockUpID,
  actionMoveID,
  actionStandID,
  actionStunID,
  actionVictoryID,
  age,
  allSkillList: [any],
  armorDes,
  atkSpeed_SN,
  atk_SN,
  awakeList: [
    {
      awakeId, // -> AwakeFactory.id
    }
  ],
  basic,
  battleDes,
  birthday,
  birthdayCake,
  birthdayDay,
  birthdayMessage,
  birthdayMonth,
  birthplace,
  bossHpTemp,
  breakthroughList: [
    {
      breakthroughId, // -> BreakthroughFactory.id
    }
  ],
  bulletControllerList: [
    {
      controllerId, // -> BulletControllerFactory.id
    }
  ],
  canOverMaxSpeed,
  careerList: [
    {
      des,
    }
  ],
  classifyList: [
    {
      des,
    }
  ],
  classifyTagList: [any],
  controllerId, // -> ControllerFactory.id
  costRestorePerFrame_SN,
  costRestore_SN,
  deadAddBuffToOwner,
  decomposeRewardList: [
    {
      id,
      num,
    }
  ],
  def_SN,
  enemyBookId, // -> UnitFactory.id
  enemyCamp,
  enemyDrop: [
    {
      id,
    }
  ],
  enemySkillList: [
    {
      id,
    }
  ],
  enemyType,
  equipmentSlotList: [
    {
      tagID,
    }
  ],
  fightEndBuffId,
  fileList: [
    {
      file,
    }
  ],
  finalSkill,
  flyOnStraight,
  gender,
  getCharacter,
  gotoBed,
  growthId, // -> GrowthFactory.id
  growthTagList: [
    {
      growthTagId, // -> GrowthFactory.id
    }
  ],
  height,
  hitAreaHalfHeight_SN,
  hitAreaHalfWidth_SN,
  hitAreaX_SN,
  hitAreaY_SN,
  hitPointX_SN,
  hitPointY_SN,
  homeCharacter,
  homeSkillList: [
    {
      id,
      nextIndex,
      resonanceLv,
    }
  ],
  hp_SN,
  identity,
  isBoss,
  isCantBeHit,
  isDeadNotDisappear,
  isDoctor,
  isFly,
  isImmuneAlly,
  isImmuneEnemy,
  isNeutral,
  isSpine2,
  isUseCustomCostRestore,
  line,
  lineDes,
  luck_SN,
  medicalPoint,
  noUpgradeSkillList: [any],
  normalDes,
  originFlyYSN,
  ownerDeadAddBuffID,
  passiveSkillList: [
    {
      skillId, // -> SkillFactory.id
    }
  ],
  prisonerDrop: [
    {
      id,
      weight,
    }
  ],
  randomOffsetFlyYSN,
  resistanceList: [
    {
      id,
    }
  ],
  rewardList: [
    {
      id,
      num,
    }
  ],
  riskDes,
  safeInformation,
  sideId, // -> TagFactory.id
  skillList: [
    {
      num,
    }
  ],
  skillLvUpList: [any],
  skillMin,
  skinList: [
    {
      unitViewId, // -> UnitViewFactory.id
    }
  ],
  spName,
  specialGiftDes,
  stationStoreCharacter,
  subLine,
  tagList: [
    {
      tagId, // -> TagFactory.id
    }
  ],
  talentList: [
    {
      talentId, // -> TalentFactory.id
    }
  ],
  teamUzl,
  teamUzlShow,
  totalCardNum,
  totalCost,
  unitInformation,
  viewId, // -> UnitViewFactory.id
  weaknessList: [
    {
      id,
    }
  ],
}
```
