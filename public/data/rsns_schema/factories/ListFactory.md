# ListFactory

## Schema

```js
ListFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  iconPath,
  tipsPath,
  AudioF: [
    {
      Audio1,
      Audio2,
      AudioName,
      StoryText,
      UnlockLevel,
    }
  ],
  AudioM: [
    {
      Audio1,
      Audio2,
      AudioName,
      StoryText,
      UnlockLevel,
    }
  ],
  BattleAudio: [
    {
      AudioName,
      AudioType,
      StoryText,
      id1,
      id2,
    }
  ],
  CvName1,
  CvName2,
  EngineRewardList: [
    {
      id,
      num,
    }
  ],
  EquipmentEntryList: [
    {
      id, // -> SkillFactory.id
      weight,
    }
  ],
  FestivalReward: [
    {
      id,
      num,
    }
  ],
  IncludeParagraph: [
    {
      id,
    }
  ],
  ItemConditionList: [any],
  LevelConditionList: [any],
  OilMaterialList: [
    {
      id,
      num,
    }
  ],
  OrderList: [
    {
      id,
      weight,
    }
  ],
  PlaceDesc,
  QuestConditionList: [
    {
      condition,
    }
  ],
  Rankname,
  Restype: [
    {
      Language,
      isExistent,
    }
  ],
  ResumeList: [any],
  StoryList: [
    {
      Title,
      UnlockLevel,
      des,
    }
  ],
  TrustAudio: [
    {
      Audio1,
      Audio2,
      AudioName,
      StoryText,
      UnlockLevel,
    }
  ],
  Unlockright: [
    {
      id,
    }
  ],
  accumulateList: [
    {
      id,
      achieveList,
      name,
      png,
      stageName,
      sumCount,
    }
  ],
  achieveRewardList: [
    {
      id,
      num,
    }
  ],
  achieveStartList: [
    {
      id,
    }
  ],
  achievementList: [
    {
      id,
      englishPic,
      icon,
    }
  ],
  actionSkillList: [
    {
      skillName,
      skillText,
    }
  ],
  adList: [any],
  animList: [
    {
      name,
    }
  ],
  areaLevelList: [any],
  areaStationList: [
    {
      id,
    }
  ],
  arm: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  awardList: [
    {
      id,
      num,
    }
  ],
  backAnimList: [
    {
      animName,
    }
  ],
  balloonList: [
    {
      ratio: [any],
    }
  ],
  boxGoodsList: [
    {
      id,
      weight,
      max,
      min,
    }
  ],
  boxList: [
    {
      id,
      distance,
    }
  ],
  breakItemList: [
    {
      id,
      num,
    }
  ],
  buildingId, // -> BuildingFactory.id
  chapterName,
  classifyIcon,
  classifyName,
  clean: [
    {
      common: [any],
      most: [any],
      out: [any],
      pay,
    }
  ],
  clickEventList: [
    {
      id,
      weight,
      pos_x: [any],
      pos_y: [any],
      pos_z: [any],
    }
  ],
  collectionCardList: [
    {
      id,
    }
  ],
  comfort: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  commodityList: [
    {
      id,
      weight,
    }
  ],
  condition,
  cover,
  coverPage,
  dataTab: [
    {
      id,
      level,
      name,
    }
  ],
  dayQuestList: [
    {
      id,
      weight,
      comNum,
      lv,
    }
  ],
  defaultCreatureList: [
    {
      id,
      num,
    }
  ],
  deterrence,
  dialogList: [
    {
      id,
      reputation,
    }
  ],
  drinkBuffList: [
    {
      id,
      weight,
    }
  ],
  drinkList: [
    {
      id,
      num,
    }
  ],
  dropList: [
    {
      id,
      weight,
    }
  ],
  electricMaterialList: [
    {
      id,
      num,
    }
  ],
  enemyBuffDesList: [
    {
      buffText,
      numericText,
      resistanceText,
    }
  ],
  enemyList: [
    {
      weight,
      awakeLv,
      controllerId,
      enemyId,
      lv,
      resonanceLv,
    }
  ],
  enemyRandWaveList: [
    {
      id,
      weight,
    }
  ],
  environmentList: [
    {
      id,
    }
  ],
  eventColoudness,
  eventDeterrence,
  eventLevelList: [
    {
      id,
      weight,
    }
  ],
  eventList: [
    {
      id,
      distance,
    }
  ],
  eventType,
  eventWeightList: [
    {
      id,
      weight,
    }
  ],
  expelNum,
  expelRewardList: [
    {
      id,
      expel,
    }
  ],
  fishScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  foodScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  frontAnimList: [
    {
      animName,
    }
  ],
  goodsList: [
    {
      id,
      num,
    }
  ],
  gradeExpList: [
    {
      num,
    }
  ],
  height,
  help: [
    {
      tadId, // -> TextFactory.id
      txtId, // -> TextFactory.id
    }
  ],
  helpTitle,
  helpbookList: [
    {
      imgPath,
    }
  ],
  hitList: [
    {
      tagHit,
    }
  ],
  icon,
  initOrderList: [any],
  interfaceUrl,
  investChoose: [
    {
      id,
      weight,
    }
  ],
  investorCostList: [
    {
      id,
      num,
    }
  ],
  investorRewList: [
    {
      id,
      num,
    }
  ],
  isIncome,
  islandComfort: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  islandFishScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  islandFoodScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  islandMedicalScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  islandPetScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  islandPlantScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  islandPlayScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  kabanerList: [
    {
      id,
    }
  ],
  levelList: [
    {
      id,
    }
  ],
  leveldropList: [
    {
      id,
      numMax,
      numMin,
      percent: [any],
    }
  ],
  listType,
  lock,
  lvCondition,
  lvList: [
    {
      lv,
    }
  ],
  mainStoreList: [
    {
      id,
    }
  ],
  materialList: [
    {
      id,
      num,
    }
  ],
  medicalScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  namePlace,
  namePlaceIcon,
  needleInMapList: [
    {
      id,
      iconPosx: [any],
      iconPosy: [any],
      mapIconPath,
    }
  ],
  normalTagList: [
    {
      id,
    }
  ],
  notebook: [
    {
      id,
    }
  ],
  occList: [
    {
      tagOcc,
    }
  ],
  offerExpList: [
    {
      num,
    }
  ],
  packList: [
    {
      name,
      packId,
      png,
    }
  ],
  passengerAction1: [
    {
      id,
      action,
    }
  ],
  passengerAction2: [
    {
      id,
      action,
    }
  ],
  passengerAction3: [
    {
      id,
      action,
    }
  ],
  passengerAction4: [
    {
      id,
      action,
    }
  ],
  passengerAction5: [
    {
      id,
      action,
    }
  ],
  passengerAction6: [
    {
      id,
      action,
    }
  ],
  passengerTagList: [
    {
      id,
      weight,
    }
  ],
  passengerTypeList: [
    {
      id,
      weight,
    }
  ],
  passivSkillList: [
    {
      skillName,
      skillText,
    }
  ],
  petScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  placeType,
  placeWeight,
  plantScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  playScores: [
    {
      common,
      most,
      out,
      pay,
    }
  ],
  polluteRegularList: [
    {
      id,
      index,
    }
  ],
  priceList: [
    {
      num,
    }
  ],
  prisonFurniturePosition: [
    {
      id,
      x,
      y,
    }
  ],
  prisonPrisonerPosition: [
    {
      x,
      y,
    }
  ],
  prisonerActionReady: [
    {
      actionName,
    }
  ],
  prisonerActionWorking: [
    {
      id,
      weight,
      actionName,
    }
  ],
  prisonerFrisk: [
    {
      actionName,
    }
  ],
  prisonerHappenProbabilityList: [
    {
      weight,
      happenNum,
    }
  ],
  prisonerMedical: [
    {
      actionName,
    }
  ],
  prisonerOrderList: [
    {
      id,
      weight,
    }
  ],
  prisonerPunish: [
    {
      actionName,
    }
  ],
  prisonerRoom: [any],
  questList: [
    {
      id,
    }
  ],
  questList1: [
    {
      id,
      weight,
    }
  ],
  questList2: [
    {
      id,
      weight,
    }
  ],
  questList3: [
    {
      id,
      weight,
    }
  ],
  questList4: [
    {
      id,
      weight,
    }
  ],
  questList5: [
    {
      id,
      weight,
    }
  ],
  rareGoodsList: [
    {
      id,
    }
  ],
  rareGoodsNum,
  repRewardList: [
    {
      id,
      num,
    }
  ],
  reward: [
    {
      id,
      num,
    }
  ],
  rewardList: [
    {
      id,
      num,
    }
  ],
  sequenceName,
  seriesCompleteNum,
  seriesName,
  seriesType,
  shopList: [
    {
      id,
      weight,
    }
  ],
  sideQuestList: [
    {
      id,
      weight,
      lv,
    }
  ],
  skillBuffList: [
    {
      id,
    }
  ],
  skillList: [
    {
      skillId,
      weight,
    }
  ],
  skipQuestList: [
    {
      id,
    }
  ],
  skipStationEnd,
  skipStationStart,
  spineList: [
    {
      weight,
      note,
      spinePath,
    }
  ],
  stageQuestList: [
    {
      id,
    }
  ],
  stageRewardList: [
    {
      id,
      construct,
      num,
    }
  ],
  starWeightList: [
    {
      id,
      weight,
    }
  ],
  stationSceneList: [
    {
      bgmId,
      dev,
      postProcessingPath,
      sceneGroup,
      sceneWidth,
      stationScene,
    }
  ],
  tecList: [
    {
      tagTec,
    }
  ],
  textTipsList: [
    {
      id,
    }
  ],
  timeEnd,
  timeStart,
  trainLook: [
    {
      id,
    }
  ],
  trainName,
  trainWeaponList: [
    {
      id,
    }
  ],
  txt,
  unlockPlace,
  width,
}
```

## Relations

### Suspected
- ListFactory.skillList[].skillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=45; total<60)
