# ConfigFactory

## Schema

```js
ConfigFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  AnecdoteList: [
    {
      id,
      anecdoteName,
      brief,
      characterId,
      faceUrl,
      plotReviewId,
      questId,
      spineX: [any],
      spineY: [any],
      startTime,
    }
  ],
  Armor,
  BattlePassId,
  BattlePassIdList: [
    {
      id,
    }
  ],
  BlockTime,
  Blue: [any],
  BuffDistance,
  CVList: [
    {
      replacePath,
    }
  ],
  CabinConnectWidthCell,
  CameraMoveSpeed,
  CameraSize,
  CameraX,
  CameraY,
  CameraZ,
  CardAILevelId,
  CarriagehouseList: [
    {
      id,
      no,
      num,
    }
  ],
  CellX,
  CellY,
  CellZ,
  ChangeNum,
  CharacterOverUserLevelMax,
  CoachX,
  CoachY,
  CoachZ,
  Coefficient,
  CompressNum,
  CompressTime,
  CustomTemplateNum,
  DailyFavorability,
  DropSortList: [
    {
      id,
    }
  ],
  EquipParameterList: [
    {
      num,
    }
  ],
  EquipPresetsNum,
  EquipTypeList: [
    {
      id,
      num,
    }
  ],
  FavorabilityInt: [
    {
      Max,
      Minimum,
    }
  ],
  FavorabilityLimit,
  FestivalRewardList: [
    {
      EndDate,
      Festival,
      FestivalReward,
      StartDate,
    }
  ],
  FieldOfView,
  Golden: [any],
  Gravity,
  HBPStoreList: [
    {
      id,
    }
  ],
  HomeCameraSize,
  HomeCameraSwitchTime,
  HomeCameraX,
  HomeCameraY,
  HomeCameraZ,
  HomeDesginCameraSize,
  HomeDesginCameraY,
  HomeDesignCameraX,
  HomeDesignCameraZ,
  HomeDesignFloorCameraSize,
  HomeDesignFloorCameraX,
  HomeDesignFloorCameraY,
  HomeDesignFloorCameraZ,
  Initialquantity,
  IsEnemySkillOpen,
  LevelLimit,
  LevelNum,
  LoadingTextList: [
    {
      textId,
    }
  ],
  MachiningExpList: [
    {
      AdditionalProbability,
      LvUpExp,
      MachiningLv,
      TotalExp,
    }
  ],
  MagazineEnd: [
    {
      bubbleIcon,
      bubbleId,
      endEnId,
      endId,
      icon,
    }
  ],
  MaxFieldOfView,
  MaxShowNum,
  MinFieldOfView,
  MinShowNum,
  NoticeAddress,
  OffdayNum,
  OilLevelList: [
    {
      id,
      OilLevel,
      OilNum,
      speedup,
      speeduptime,
    }
  ],
  Orange,
  Ornaments,
  PCdriveHorizonList: [
    {
      horizon,
      optionName,
    }
  ],
  PCresolutionList: [
    {
      long,
      resolution,
      width,
    }
  ],
  PendantList: [
    {
      id,
    }
  ],
  Playerranklist: [
    {
      id,
      level,
      show,
    }
  ],
  PlotReviewList: [
    {
      ChapterList,
      questId,
    }
  ],
  PlotTextChange,
  Purple: [any],
  ReduceCleanliness,
  Reduceclean,
  ResponseTime,
  SkinGetWay: [
    {
      id,
    }
  ],
  SoomthTimeAll2Half,
  SoomthTimeAll2Spike,
  SoomthTimeHalf2All,
  SoomthTimeHalf2Spike,
  SoomthTimeSpike2All,
  SoomthTimeSpike2Half,
  Squad: [
    {
      defaultSquadName,
    }
  ],
  StageQuestConfig: [
    {
      id,
      textId,
    }
  ],
  TouchTimes,
  TradeLevelUp,
  TrainFactoryScenes,
  Unitdistance,
  UseNum,
  ViewAngle,
  Weapon,
  White: [any],
  aautoStrikeUnLock: [
    {
      id,
      num,
    }
  ],
  accelerationRatio,
  accessoryList: [
    {
      id,
    }
  ],
  achieveList: [
    {
      id,
      name,
      pngGet,
      pngLittle,
      pngNotSelect,
      pngSelect,
      showMax,
    }
  ],
  achievePointList: [
    {
      id,
      name,
      pngNotSelect,
      pngSelect,
    }
  ],
  actionList: [
    {
      action,
      time: [any],
    }
  ],
  activeList: [any],
  activeNoticeList: [
    {
      isImportance,
      isUpdate,
      lmtID,
    }
  ],
  activeSigninList: [any],
  activityBuyList: [any],
  activityBuyVal,
  activityItem,
  activityMainList: [
    {
      id,
      countDownMax,
      endTime,
      isCompleteBottom,
      isCountDown,
      isShow,
      name,
      png,
      showUI,
      sort,
      startTime,
      tag,
    }
  ],
  activityOperateList: [
    {
      id,
      countDownMax,
      endTime,
      isCompleteBottom,
      isCountDown,
      isShow,
      name,
      png,
      showUI,
      sort,
      startTime,
      tag,
    }
  ],
  activityPlotList: [
    {
      id,
      countDownMax,
      endTime,
      isCompleteBottom,
      isCountDown,
      isShow,
      name,
      png,
      showUI,
      sort,
      startTime,
      tag,
    }
  ],
  activitySellList: [any],
  activitySellVal,
  activityTimeList: [
    {
      id,
      countDownMax,
      endTime,
      isCompleteBottom,
      isCountDown,
      isShow,
      name,
      png,
      showUI,
      sort,
      startTime,
      tag,
    }
  ],
  activityUiCommon: [
    {
      id,
      activityItemCorner,
      activitySkipUi,
      passengerIcon,
      recycleId,
    }
  ],
  adList: [
    {
      adPath,
      lv,
      param,
      questId,
      questType,
      scale,
      uiPath,
    }
  ],
  adaptResonanceList: [
    {
      level,
      resonance,
    }
  ],
  addDrinkNum: [
    {
      id,
    }
  ],
  addGold: [
    {
      id,
    }
  ],
  addPeople: [
    {
      id,
    }
  ],
  addProfit: [
    {
      id,
    }
  ],
  addScore: [
    {
      id,
    }
  ],
  addWeight: [
    {
      id,
    }
  ],
  addnumItem,
  advertiseOpen,
  advertiseQuestOpen,
  allGoldByLevelActivityId: [
    {
      id,
    }
  ],
  alphaTime,
  animatorTime,
  announcementNoticeList: [any],
  antedate,
  apRewardList: [
    {
      id,
      ap,
      num,
    }
  ],
  aquariumFeed: [
    {
      id,
    }
  ],
  areaList: [
    {
      id,
    }
  ],
  arm,
  arrestPrisonerNum: [
    {
      id,
    }
  ],
  arriveRange,
  arrowUnitEffectId,
  attCtrlList: [
    {
      type,
      isUseMax,
      isUseMin,
      name,
      numMax,
      numMin,
    }
  ],
  attackSignDiagonalId,
  attackSignDirectionId,
  attractionTipOffsetX,
  attractionTipOffsetY,
  attractionTipSpacing,
  autoBuyRoadLv,
  autoBuyRoadPath,
  autoBuyRoadUnLock: [
    {
      id,
      num,
    }
  ],
  autoDrawCardInterval,
  autoEnterStationLv,
  autoEnterStationPath,
  autoEnterStationUnLock: [
    {
      id,
      num,
    }
  ],
  autoFightLv,
  autoFightPath,
  autoFightUnLock: [
    {
      id,
      num,
    }
  ],
  autoModeLevel,
  autoRushLv,
  autoRushPath,
  autoRushUnLock: [
    {
      id,
      num,
    }
  ],
  autoStrikeLv,
  autoStrikePath,
  autorepair,
  awake: [
    {
      id,
    }
  ],
  awakeCoefficientN,
  awakeCoefficientR,
  awakeCoefficientSR,
  awakeCoefficientSSR,
  awakeTrustExpList: [
    {
      exp,
    }
  ],
  awardCoefficient,
  ballPath,
  ballSpinePath,
  balloonItem,
  balloonItemList: [
    {
      id,
      isReward,
    }
  ],
  banCarriageList: [
    {
      id,
    }
  ],
  bannerList: [
    {
      id,
    }
  ],
  bargainCost,
  bargainMax,
  bargainSuccessRateList: [
    {
      rate,
    }
  ],
  baseSize,
  battleInfoAllyAbsorbId,
  battleInfoAllyBAList: [
    {
      battleInfoId,
      rangeSN,
    }
  ],
  battleInfoAllyHAId,
  battleInfoAllyImmuneId,
  battleInfoAllyNAId,
  battleInfoAllyRAId,
  battleInfoAllySAId,
  battleInfoEnemyAbsorbId,
  battleInfoEnemyBAList: [
    {
      battleInfoId,
      rangeSN,
    }
  ],
  battleInfoEnemyHAId,
  battleInfoEnemyImmuneId,
  battleInfoEnemyNAId,
  battleInfoEnemyRAId,
  battleInfoEnemySAId,
  battleLevelLimit,
  battlePassCoefficient,
  battleTagCA,
  battleTagCD,
  battleTagClearCD,
  beatAnyEnemy: [
    {
      id,
    }
  ],
  beatAppointBoss: [
    {
      id,
    }
  ],
  bestTrainCamera,
  bgList: [
    {
      bgPath,
      changeTime,
    }
  ],
  bgmList: [
    {
      audioMixerPath,
      maxVolume,
      param,
    }
  ],
  bigWorldTipsList: [
    {
      tips,
    }
  ],
  bindRewardList: [
    {
      id,
      num,
    }
  ],
  blacklistMax,
  blockBallPersent,
  blockEffectId,
  bloodEffectList: [
    {
      id,
      weight,
    }
  ],
  bluePoint,
  bmRockItemId,
  bodyWeaponNum,
  bookCharacterSideEnumList: [
    {
      id,
    }
  ],
  bookEquipmentEnumList: [
    {
      id,
    }
  ],
  bossNameUI,
  bossProgMutiple,
  bossWarningId,
  botanyPlant: [
    {
      id,
    }
  ],
  box,
  btnCancelId,
  btnConfirmId,
  buffCountDuration,
  buffCountList: [
    {
      buffId,
      tagId,
    }
  ],
  buffCountYInterval,
  buildList: [
    {
      id,
    }
  ],
  buildSaleList: [
    {
      discountRange,
    }
  ],
  bunkBed: [
    {
      price,
    }
  ],
  businessman,
  buyElectricList: [
    {
      id,
      addSpeed,
      electric,
    }
  ],
  buyGoldInit,
  buyItem: [
    {
      id,
    }
  ],
  buyItemList: [
    {
      id,
      func,
    }
  ],
  buyPollutionRatio,
  camLeft,
  camMoveLimitCellFurPlace,
  camRight,
  cam_ViewDistance,
  cam_ViewMasterDistance,
  cam_pitch,
  cam_yaw,
  cameraDefaultPath,
  cameraEffectPathList: [
    {
      path,
      time,
    }
  ],
  cameraShakeExTime,
  cameraShakeExValX,
  cameraShakeExValY,
  cameraShakeTime,
  cameraShakeValX,
  cameraShakeValY,
  cancelCD,
  cancelNumW,
  capsuleList: [
    {
      id,
    }
  ],
  cardActiveEffectId,
  cardAddCostEffectId,
  cardBackBlackPath,
  cardBackBluePath,
  cardBackGreenPath,
  cardBackPurplePath,
  cardBackRedPath,
  cardBackYellowPath,
  cardBuffSustainEffectId,
  cardChangeEffectId,
  cardChargeEffectId,
  cardChoosenSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  cardChosenEffectId,
  cardColor: [any],
  cardCostBuffID,
  cardCostDebuffID,
  cardCostNormalID,
  cardDestroyEffectId,
  cardDragEffectId,
  cardDropButtonSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  cardGetEndSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  cardGetStartSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  cardOwnerDeadAppearEffectId,
  cardOwnerDeadDisappearEffectId,
  cardOwnerDeadEffectId,
  cardPackList: [
    {
      id,
      startTime,
    }
  ],
  cardRefreshSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  cardSubCostEffectId,
  cardTypeBlackPath,
  cardTypeBluePath,
  cardTypeGreenPath,
  cardTypePurplePath,
  cardTypeRedPath,
  cardTypeYellowPath,
  cardUseEffectId,
  cardUseEndSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  cardUseStartSoundList: [
    {
      delayFrame,
      soundId,
    }
  ],
  carriageBuild: [
    {
      id,
    }
  ],
  centerMissSize,
  challengeLevelList: [
    {
      levelId,
      unitId,
    }
  ],
  changeSceneEffectTime,
  channelFameOpen,
  channelOpen,
  characterDefaultHeight,
  characterList: [
    {
      id,
    }
  ],
  characterScale,
  characterSpeed,
  checkSize,
  choiceBuffval,
  choukaN,
  choukaR,
  choukaSR,
  choukaSSR,
  chromatismInit,
  chromatismIntensity,
  chromatismTime,
  chromatismTime1,
  chromatismTime2,
  clean,
  cleancoefficientone,
  cleancoefficienttwoList: [
    {
      id,
      num,
    }
  ],
  cleannum,
  cleanone,
  cleantwo,
  clickDungeonWeek,
  clickEffectId,
  clickLimit,
  clickPolluteWeek,
  clientGetExpInterval,
  closingTimeEnd,
  closingTimeStart,
  coachCostthreeList: [
    {
      id,
      num,
    }
  ],
  coachCosttwoList: [
    {
      id,
      num,
    }
  ],
  coachDefaultBgmId,
  coachTypeList: [
    {
      id,
    }
  ],
  cocAddQuestItemList: [
    {
      id,
      num,
    }
  ],
  cocItemAddQuestNum,
  cocQuestMax,
  cocQuestTypeList: [
    {
      cocQuestType,
      typeName,
    }
  ],
  coefficientone,
  coefficientthree,
  coefficienttwo,
  collectParkSeal: [
    {
      id,
    }
  ],
  collegeChapter: [any],
  collisionAngleList: [
    {
      id,
    }
  ],
  combinedWeatherIconPath,
  comfort,
  commonBlood,
  commonRareList: [
    {
      id,
    }
  ],
  commonRate,
  conductorM,
  conductorW,
  constantList: [
    {
      constantSN,
    }
  ],
  coreList: [
    {
      id,
    }
  ],
  coreLvUp: [
    {
      id,
    }
  ],
  coreRotate,
  coreSelect,
  coretypeList: [
    {
      id,
    }
  ],
  corpseTideBlood,
  costItemList: [any],
  costNum: [
    {
      id,
      num,
    }
  ],
  costRestorePerFrame_SN,
  createTypeList: [
    {
      id,
    }
  ],
  createUnitRangeX,
  createUnitRangeY,
  creatureBag,
  curRoleUIPath,
  cure: [any],
  cutInEffectId,
  cutInInterval,
  dailyFrequency,
  dailyQuestList: [
    {
      id,
    }
  ],
  dailyRefreshTime,
  dailyRequestMax,
  dailySigninList: [any],
  damageCountDurarion,
  damageDownArrow,
  damageDownBg,
  damageParam1,
  damageParam2,
  damageParam3,
  damageUpBg,
  dangerList: [
    {
      cityDanger,
      dangerText,
      mainDanger,
      mainSelected,
      sColor,
    }
  ],
  dashboardList: [
    {
      changeSpeed,
      dashboardPath,
      maxSpeed,
    }
  ],
  dayLog: [
    {
      id,
    }
  ],
  dayOpenLightTime,
  dayRedPoint,
  dayScale,
  decorate: [
    {
      id,
    }
  ],
  defaultBossHPTemp,
  defaultConcealList: [
    {
      id,
    }
  ],
  defaultDressType,
  defaultFloor,
  defaultGender,
  defaultName,
  defaultSkins: [
    {
      id,
      wear,
    }
  ],
  defaultStation,
  defaultUseCardActionId,
  defaultVal,
  defaultViewAngle,
  defaultViewDis,
  defaultViewFov,
  defaultViewPos: [
    {
      x,
      y,
      z,
    }
  ],
  defaultWallpaper,
  delayTime,
  delegationFinish: [
    {
      id,
    }
  ],
  demandBasics,
  demandOut,
  dialog: [
    {
      id,
    }
  ],
  diamondStoreList: [
    {
      id,
    }
  ],
  diceItemList: [
    {
      id,
    }
  ],
  diceLimit,
  diceNum,
  diceTimeNum: [
    {
      endTime,
      num,
      startTime,
    }
  ],
  diceTimeWeekendNum: [
    {
      endTime,
      num,
      startTime,
    }
  ],
  diceWeekendNum,
  difficultyTransMutiple,
  dirSpeed,
  disArrive,
  disEnergyPer,
  disEnergyStart,
  disExpPer,
  disRatio,
  disReverse,
  discard: [any],
  discardAllEffectId,
  discardBtnAppearEffectId,
  discardBtnCooldownFrame,
  discardBtnDisappearEffectId,
  discardBtnDrawCardNum,
  discardBtnEnableEffectId,
  distanceone,
  distancethree,
  distancetwo,
  dizziness: [any],
  doReduceRate,
  doubleQueenBed: [
    {
      price,
    }
  ],
  drawCardNumAfterBattle,
  dressTypeOrder: [
    {
      id,
    }
  ],
  drinkLimitNum,
  drinkRefreshType,
  driveHorizonList: [
    {
      horizon,
      optionName,
    }
  ],
  dropQuotationInitMax,
  dropQuotationInitMin,
  eatBento: [
    {
      id,
    }
  ],
  eatEffect,
  eatPrefab,
  effectArrowTopId,
  effectPath,
  elecLevelUp: [
    {
      id,
    }
  ],
  electricBuy,
  electricLevelList: [
    {
      lv,
    }
  ],
  electricList: [
    {
      id,
      electric,
      slotNum,
      speed,
    }
  ],
  electricUp,
  emptyTipQuest,
  endAlpha,
  endTime,
  enemyCampEnumList: [
    {
      id,
    }
  ],
  enemyEnumSideList: [
    {
      id,
    }
  ],
  enemyLvMax,
  enemyStrengthEnumList: [
    {
      id,
    }
  ],
  energyAdd,
  energyAddCD,
  energyAddMax,
  energyAddNum,
  energyCost: [
    {
      id,
    }
  ],
  energyEnd,
  energyExtraMax,
  energyFullBarEffectLoopId,
  energyFullEffectLoopId,
  energyFullEffectShowId,
  energyFullUnitEffect2Id,
  energyFullUnitEffectId,
  energyItemId,
  energyItemList: [
    {
      id,
    }
  ],
  energyMax,
  energyMoneyCost: [
    {
      id,
      num,
    }
  ],
  energyOver,
  energyPer,
  energyStart,
  energyStatementList: [
    {
      bg,
      display,
      ratioMax: [any],
      ratioMin: [any],
      scroll,
    }
  ],
  enterCity: [
    {
      id,
    }
  ],
  enterHomeUIList: [
    {
      imagePath,
    }
  ],
  enterMainUIList: [
    {
      imagePath,
    }
  ],
  entertain: [
    {
      id,
    }
  ],
  entrustCharacter,
  entrustList: [
    {
      id,
    }
  ],
  entrustQueueList: [any],
  enumEquipTypeList: [
    {
      equipType,
    }
  ],
  enumJobList: [
    {
      tagId,
    }
  ],
  enumSideList: [
    {
      tagId,
    }
  ],
  environmentList: [
    {
      id,
    }
  ],
  equipMaxLv,
  equipTagList: [any],
  equipTipLv,
  equipTipMax,
  equipTipOpen,
  equipmentBag,
  eventDoubleEndTime,
  eventDoubleNum,
  eventDoubleStartTime,
  eventList: [any],
  everyAndroidDefaultSetList: [
    {
      defaultBloom,
      defaultDriveHorizon,
      defaultQuality,
      defaultShadow,
      defaultTextureQuality,
      greyDriveHorizonMin,
      greyQualityMin,
      greyTextureQualityMin,
      isGrey,
      memory,
    }
  ],
  everyIosDefaultSetList: [
    {
      defaultBloom,
      defaultDriveHorizon,
      defaultQuality,
      defaultShadow,
      defaultTextureQuality,
      greyDriveHorizonMin,
      greyQualityMin,
      greyTextureQualityMin,
      isGrey,
      memory,
    }
  ],
  everyPCDefaultSetList: [
    {
      defaultBloom,
      defaultDriveHorizon,
      defaultQuality,
      defaultShadow,
      defaultTextureQuality,
      greyDriveHorizonMin,
      greyQualityMin,
      greyTextureQualityMin,
      isGrey,
      memory,
    }
  ],
  exchangeBuildId,
  expList: [any],
  expPer,
  expSourceMaterialList: [
    {
      id,
    }
  ],
  expelNum,
  extraQuotation,
  extraWarehouse,
  extractTabX,
  factoryDataList: [
    {
      factoryName,
      propertyName,
    }
  ],
  farClipPlane,
  fastQuotationEnd,
  fastQuotationStart,
  favorItemList: [
    {
      id,
    }
  ],
  feedAddition,
  feedCount,
  feederLoveUp,
  femaleSwitchVoice,
  filmList: [
    {
      id,
    }
  ],
  finishOrder: [
    {
      id,
    }
  ],
  finishPark: [
    {
      id,
    }
  ],
  finishParkByTicket: [
    {
      id,
    }
  ],
  finishParkCarEvent: [
    {
      id,
    }
  ],
  finishRogue: [
    {
      id,
    }
  ],
  finishRogueSuc: [
    {
      id,
    }
  ],
  firstDrinkBuff,
  firstNameList: [
    {
      firstName,
    }
  ],
  firstPointLoadMonster,
  fishScores,
  fishTankRespondRadius,
  flashWhiteCD,
  flashWhiteDuration,
  flashWhiteValue,
  floorTileOffset,
  floorTypeList: [
    {
      id,
    }
  ],
  focusCameraOffsetZ,
  fondleNum,
  foodBag,
  foodItemList: [
    {
      id,
    }
  ],
  foodScores,
  formationTipOpen,
  freeOrderTimes,
  frictionSN,
  friendsListMax,
  frjLevel: [
    {
      id,
    }
  ],
  funcList: [
    {
      funcId,
      guideId,
      iconPath,
      isShow,
      name,
      tips,
    }
  ],
  funcbtnlist: [
    {
      funcId,
      icon,
      name,
      param,
      prefab,
    }
  ],
  furPlaceCamMoveTime,
  furnitureAttrList: [
    {
      attrName,
      field,
      iconPath,
    }
  ],
  furnitureBag,
  furnitureCoin,
  gacha: [
    {
      id,
    }
  ],
  gachaRecord,
  gacheUI,
  gacheUIChange,
  gainFans: [
    {
      id,
    }
  ],
  gaizhang,
  gameDate,
  gameMinLV,
  getAnyCharacter: [
    {
      id,
    }
  ],
  getCost: [any],
  goldItemId,
  goldenPoint,
  goodRate,
  goodsOver,
  goodsReduceSpeed,
  goodsSlowDown,
  gradeCoefficientN,
  gradeCoefficientR,
  gradeCoefficientSR,
  gradeCoefficientSSR,
  gradeUp,
  gradelist: [any],
  gravitySN,
  gridCenterPosX,
  gridCenterPosY,
  gridCenterPosZ,
  gridHeight,
  gridPath,
  gridPixelsPreUnit,
  gridSpriteSizeX,
  gridSpriteSizeZ,
  gridWidth: [
    {
      spacing: [any],
      width,
    }
  ],
  groupList: [
    {
      childName,
      childUrl,
      nameBtn,
      uiName,
    }
  ],
  growthAttributeMultiId,
  guardId,
  guidanceCirclePath,
  guidanceSquarePath,
  guideList: [
    {
      guideId, // -> GuideFactory.id
    }
  ],
  gyroBeginRotateLimitY,
  gyroBeginRotateLimitZ,
  gyroRotateBoundLimitY,
  gyroRotateBoundLimitZ,
  gyroSpeedRatio,
  handCardNumMax,
  handCardNumMaxFinal,
  handCardStartNum,
  hangTime,
  hardSeat: [
    {
      price,
    }
  ],
  haveArea: [
    {
      id,
    }
  ],
  haveFurniture: [
    {
      id,
    }
  ],
  headWeaponNum,
  healDownArrow,
  healDownBg,
  healUpBg,
  heightCamera: [any],
  heightScale,
  helpBattleCanHelp,
  helpBattleCd,
  helpBattleFriend,
  helpBattleMax,
  helpBattleRewardDay,
  helpBattleRewardList: [
    {
      id,
      num,
    }
  ],
  helpBattleRewardMax,
  helpBattleSetup,
  helpBook: [
    {
      pic,
    }
  ],
  helpRoleBoxPath: [
    {
      path,
    }
  ],
  highCoefficient,
  highNumMax,
  highNumMin,
  hitLimitBallPersent,
  holidayList: [
    {
      day,
    }
  ],
  homeCharacterDefaultXAngle,
  homeEnergyAdd,
  homeEnergyAddCD,
  homeEnergyItemId,
  homeEnergyItemList: [
    {
      id,
    }
  ],
  homeEnergyStatementList: [
    {
      arrow,
      bg,
      face,
      faceSpine,
      lightIcon,
      ratioMax: [any],
      ratioMin: [any],
      stateText,
    }
  ],
  homeStoreList: [any],
  hourCost: [
    {
      id,
      num,
    }
  ],
  hpBarPrefab,
  huoche,
  hyOrderNum: [
    {
      id,
    }
  ],
  idleTime,
  initBargainSuccessNum,
  initCoachList: [
    {
      id,
      default,
      weapon,
    }
  ],
  initFurnitureList: [any],
  initGold,
  initGrade,
  initProfilePhotoList: [any],
  initQuestList: [
    {
      id,
    }
  ],
  initRiseSuccessNum,
  initialOrderList: [
    {
      id,
    }
  ],
  invest: [
    {
      id,
    }
  ],
  investMoneyList: [
    {
      id,
      num,
    }
  ],
  inviteLimit,
  inviteRewardList: [
    {
      id,
      num,
    }
  ],
  isClickDungeon,
  isClickPollute,
  isDotweenPause,
  isDoubleTouchMap,
  isLandOpen,
  isNumberOpen,
  isOpen,
  isOpenChromatism,
  isOpenGyro,
  isOpenLens,
  isOpenRush,
  isOpenViewField,
  isPark: [
    {
      id,
    }
  ],
  isParkOpen,
  isPrisonOpen,
  isRankOpen,
  isShowWiki,
  isSkinSkill,
  isStageQuest,
  isTipRepeat,
  itemAddNum,
  itemBag,
  itemCost: [
    {
      id,
    }
  ],
  itemLimit,
  itemUseLimit,
  jewelryEx,
  jiesuanN,
  jiesuanR,
  jiesuanSR,
  jiesuanSSR,
  joinTicket: [
    {
      id,
      num,
    }
  ],
  judgeAttributeList: [
    {
      name,
    }
  ],
  jumpXOffset,
  knockUpTurnRound,
  lCost: [
    {
      id,
      num,
    }
  ],
  lTime,
  languageTextList: [
    {
      key,
      cancel,
      confirm,
      text,
      tips,
    }
  ],
  leaderCardBaseCDFrame,
  leaderCardDisappearEffectId,
  leaderCardEnableEffectId,
  leaderCardOffsetYMax,
  leaderCardReadyEffectId,
  leaderExtra,
  leafletAddMax,
  leafletAddPay: [
    {
      id,
      num,
    }
  ],
  leafletDozen,
  leafletEnd: [
    {
      bubbleIcon,
      bubbleId,
      endEnId,
      endId,
      icon,
    }
  ],
  leafletIncome: [
    {
      adPassageMax,
      adPassageMin,
      distance,
      earning: [any],
    }
  ],
  leafletMax,
  leafletNum,
  lensIntensity1,
  lensIntensity2,
  levelCoefficient,
  levelList: [
    {
      coachMax,
      developmentDegree,
    }
  ],
  levelMax,
  levelMaxGoldByLevelId: [
    {
      id,
    }
  ],
  levelRefreshTime,
  levelTrustExpList: [
    {
      exp,
    }
  ],
  limitActiveList: [
    {
      isImportance,
      isUpdate,
      lmtID,
    }
  ],
  limitTimes,
  lineList: [
    {
      id,
    }
  ],
  linePlyerLv,
  lineWaste,
  loginMusicTitle,
  lookSpeed,
  lootId,
  loseReowrd: [
    {
      id,
      weight,
      num,
    }
  ],
  loveBentoLevel,
  loveBentoMax,
  loveBentoPr,
  loveBentoPrMax,
  loveBentoPrMin,
  lowRate,
  magazineFameOpen,
  magazineId,
  magazineOpen,
  magazineShowNum,
  magazineTime,
  mainBG,
  mainChapter: [any],
  mainGradeCloseLimit,
  mainGradeOpenLimit,
  mainPanelCloseId,
  mainPanelOpenId,
  mainQuestCloseLimit,
  mainQuestOpenLimit,
  mainStoreList: [
    {
      id,
      name,
      pngNotSelect,
      pngSelect,
    }
  ],
  mainUIBannerArgs,
  mainUIBannerDrivingIsOpen,
  mainUIBannerPath,
  mainUIBannerStationIsOpen,
  mainUIBannerStoreId,
  mainUIBannerTime,
  mainUIBannerValuableId,
  maintaindistance,
  maintainpriceList: [
    {
      id,
      num,
    }
  ],
  makeTrainWeapon: [
    {
      id,
    }
  ],
  maleSwitchVoice,
  manufacture: [
    {
      id,
    }
  ],
  manufactureLevel: [
    {
      id,
    }
  ],
  mapScaleMax,
  mapScaleMin,
  materialBag,
  materialLevelGroupList: [
    {
      id,
    }
  ],
  materialLevelTimes,
  materialOrderNum: [
    {
      id,
    }
  ],
  materialRefreshType,
  maxAttractionTipNum,
  maxCameraRot,
  maxCost,
  maxNum,
  maxRandomWaveCount,
  maxReceiveNum,
  maxTimes,
  medicalScores,
  meetCoefficient,
  memberEatAni,
  memberTrustAddtion,
  messageBoardMax,
  messageWordMax,
  mileageMax,
  minCameraRot,
  moneyId,
  moneyList: [
    {
      id,
      num,
    }
  ],
  monopolyControl,
  monopolyList: [
    {
      id,
    }
  ],
  monopolyRank,
  monsterList: [
    {
      id,
    }
  ],
  moonStoreList: [
    {
      id,
    }
  ],
  nameEN,
  needProfit2,
  needProfit3,
  netHeight,
  nextTime,
  nightOpenLightTime,
  noRarityItem: [
    {
      Factory,
    }
  ],
  normalCarriageList: [
    {
      id,
    }
  ],
  normalOrder,
  normalRotateSpeed,
  notes,
  noticeId,
  nowEnergyMax,
  offerQuestMax,
  officialAccountRewardList: [
    {
      Email,
      Name,
    }
  ],
  offset,
  offsetScale,
  offsetY,
  offsetZCamera: [any],
  offsetZSpeed,
  onceProfit: [
    {
      id,
    }
  ],
  onhookAward: [
    {
      id,
      num,
    }
  ],
  openBuildingList: [
    {
      id,
    }
  ],
  openCityList: [
    {
      id,
    }
  ],
  openLevelList: [
    {
      Level,
      Num,
    }
  ],
  openlevel,
  operationRankLike: [
    {
      id,
    }
  ],
  orangePoint,
  orderCost: [
    {
      id,
      num,
    }
  ],
  orderList: [
    {
      level,
      order,
    }
  ],
  orderTimeList: [
    {
      id,
      time,
    }
  ],
  overflowtime,
  overtime,
  oviceOrderList: [
    {
      id,
      weight,
    }
  ],
  packageLv,
  packageQuestid,
  packageRegisterTime,
  packageRewardList: [
    {
      id,
      num,
    }
  ],
  parablaTime,
  parkGukaClearLevel: [
    {
      id,
    }
  ],
  parkGukaLevel: [
    {
      id,
    }
  ],
  parkGukaOwn: [
    {
      id,
    }
  ],
  passAnyBuoyLevel: [
    {
      id,
    }
  ],
  passAnyDangerLevel: [
    {
      id,
    }
  ],
  passAnyHighLevel: [any],
  passAnyLevel: [
    {
      id,
    }
  ],
  passAnyLevelByGrade: [any],
  passAnyMainLevel: [any],
  passAnyResLevel: [any],
  passAnySafeLevel: [
    {
      id,
    }
  ],
  passAnyTowerLevel: [
    {
      id,
    }
  ],
  passAnyTwigLevel: [
    {
      id,
    }
  ],
  passBattleLevelAll: [
    {
      id,
    }
  ],
  passByChapterId: [any],
  passByLevelIdGradeDifficult: [
    {
      id,
    }
  ],
  passBylevelId: [
    {
      id,
    }
  ],
  passBylevelIdAndGrade: [any],
  passEnemyBallMoveHeight,
  passFriendBallMoveHeight,
  passHitBallHeight,
  passKabaneriLevel: [
    {
      id,
    }
  ],
  passMainLevelByGrade: [any],
  passSafeLevelAll: [
    {
      id,
    }
  ],
  passSafeLevelLimitCity: [
    {
      id,
    }
  ],
  passSafeSideLevelLimitPool: [
    {
      id,
    }
  ],
  passageOpen,
  passagewayList: [
    {
      z,
    }
  ],
  passengeWaste,
  passengerLevel: [
    {
      id,
    }
  ],
  passengerMinimum,
  passengerSlowDown,
  pathLimit,
  pendantElectricList: [
    {
      id,
    }
  ],
  perCharSpeed,
  perLoadMonsterPointCount,
  perfectRate,
  petExScore,
  petFeed: [
    {
      id,
    }
  ],
  petPersonalityList: [
    {
      id,
    }
  ],
  petReduceRate,
  petScores,
  petScoresConfig: [
    {
      Favorability,
      level,
      scores,
    }
  ],
  petStateConfig: [
    {
      petStateBuff,
      petStateMax,
      petStateMin,
      stateName,
    }
  ],
  petVarityList: [
    {
      id,
    }
  ],
  pickGenderBG,
  pickGenderIntro,
  pickGenderSpine,
  pickGenderSpineBG,
  plantScores,
  playScores,
  playerBuffBlueID,
  playerBuffEffectBlueID,
  playerBuffEffectGreenID,
  playerBuffEffectPurpleID,
  playerBuffEffectRedID,
  playerBuffEffectYellowID,
  playerBuffGreenID,
  playerBuffPurpleID,
  playerBuffRedID,
  playerBuffYellowID,
  playerCardAICoreId,
  playerData: [
    {
      backLeftSide,
      backRightSide,
      downSide,
      leftSide,
      rightSide,
      upSide,
    }
  ],
  playerEatAni: [
    {
      animation,
    }
  ],
  playerHeadList: [
    {
      playerHeadPath,
    }
  ],
  playerNum,
  playerSpineList: [
    {
      id,
    }
  ],
  polluteAreaList: [
    {
      id,
      weight,
    }
  ],
  polluteBalloonList: [
    {
      id,
    }
  ],
  polluteIconPath: [
    {
      path,
    }
  ],
  polluteMax,
  polluteMin,
  pollutePlayerNum,
  pollutePlyerLv,
  polluteQuestId,
  polluteRegularList: [
    {
      id,
      endTime,
      startTime,
    }
  ],
  powerStoneCost,
  preloadAssets: [
    {
      isPrefab,
      preloadPath,
    }
  ],
  presetquantity,
  priceDownWin: [
    {
      id,
    }
  ],
  priceUpWin: [
    {
      id,
    }
  ],
  prisonCanteenLevel: [
    {
      id,
    }
  ],
  prisonCellNum: [
    {
      id,
    }
  ],
  prisonDWLevel: [
    {
      id,
    }
  ],
  prisonExerciseLevel: [
    {
      id,
    }
  ],
  prisonFRLevel: [
    {
      id,
    }
  ],
  prisonMachineList: [
    {
      id,
    }
  ],
  prisonMedicalLevel: [
    {
      id,
    }
  ],
  prisonPersonalityNameList: [
    {
      id,
    }
  ],
  prisonPowerLevel: [
    {
      id,
    }
  ],
  prisonProduceMaterialNum: [
    {
      id,
    }
  ],
  prisonProduceNum: [
    {
      id,
    }
  ],
  prisonPunishLevel: [
    {
      id,
    }
  ],
  prisonRZLevel: [
    {
      id,
    }
  ],
  prisonReleaseLevel: [
    {
      id,
    }
  ],
  prisonRoomNum: [
    {
      id,
    }
  ],
  prisonSecurityLevel: [
    {
      id,
    }
  ],
  prisonShopLevel: [
    {
      id,
    }
  ],
  prisonSpaceNum: [
    {
      id,
    }
  ],
  prisonSpecialityList: [
    {
      id,
    }
  ],
  prisonTransitFleetNum: [
    {
      id,
    }
  ],
  prisonTransitLevel: [
    {
      id,
    }
  ],
  prisonVisitLevel: [
    {
      id,
    }
  ],
  prisonWarehouseCPNum: [
    {
      id,
    }
  ],
  prisonWarehouseYLNum: [
    {
      id,
    }
  ],
  prisonWorkshopNum: [
    {
      id,
    }
  ],
  prisonZWLevel: [
    {
      id,
    }
  ],
  privtCamera,
  productLevelList: [
    {
      productLevel,
      teamPro: [any],
    }
  ],
  productionFurnitureList: [
    {
      id,
      GetWay,
      UIName,
      UIPicture,
      bgPath,
      cName,
      engName,
    }
  ],
  productionNum,
  profilePhotoM,
  profilePhotoW,
  profitConvertRep,
  protectCountList: [
    {
      id,
      num,
    }
  ],
  publicize: [
    {
      id,
    }
  ],
  pullOutASpeed,
  pullOutSpeedMax,
  pullOutTime,
  purplePoint,
  putPrisonerInNum: [
    {
      id,
    }
  ],
  qqList: [
    {
      Adress,
      isShow,
      name,
    }
  ],
  questDownload,
  questList: [
    {
      id,
    }
  ],
  questNum,
  questQuotationList: [
    {
      questId,
      quotationId,
      quotationType,
      quotationVal,
      stationId,
    }
  ],
  questREC,
  quotationThresholdList: [
    {
      id,
    }
  ],
  randomBattleCoinId,
  randomBattleCost: [
    {
      id,
      num,
    }
  ],
  randomBattleCostCount,
  randomBattleLastDay,
  randomBattleList: [
    {
      id,
      weight,
    }
  ],
  randomBattleLose,
  randomBattleLv,
  randomBattlePreList: [any],
  randomBattleStartDay,
  randomBattleTicketCost,
  randomBattleTicketDay,
  randomBattleTicketId,
  randomBattleTicketMax,
  randomTrainDisBirth,
  randomTrainDisDestroy,
  randomTrainPre,
  randomTrainQuestid,
  rankList: [
    {
      bg,
      ratio,
    }
  ],
  rareGoodsInitQMax,
  rareGoodsInitQMin,
  rareGoodsQuotationMax,
  rareGoodsQuotationMin,
  rareGoodsRatio,
  rateBento: [
    {
      id,
      num: [any],
    }
  ],
  ratioExp,
  receiveOrder: [
    {
      id,
    }
  ],
  receiveTimeMin,
  receptionistId,
  recommendCoefficient,
  recommendListNum,
  recommendNum,
  recycleMaterial: [
    {
      id,
    }
  ],
  recycleMaterialMoney: [
    {
      id,
    }
  ],
  refreshBargain: [
    {
      id,
      num,
    }
  ],
  refreshCD,
  refreshGoods: [
    {
      id,
    }
  ],
  refreshItem: [
    {
      id,
      num,
    }
  ],
  refreshItemOther: [
    {
      id,
      num,
    }
  ],
  refreshLimit,
  refreshRankTime,
  refreshTime,
  renameCost: [
    {
      id,
      num,
    }
  ],
  repCountList: [
    {
      orderNum,
      repId,
      repNum,
    }
  ],
  repLevelUp,
  repairpriceList: [
    {
      id,
      num,
    }
  ],
  requestListMax,
  requestMax,
  requestWordMax,
  resetQuotationMax,
  resetQuotationMin,
  resolutionList: [
    {
      height,
      optionName,
    }
  ],
  resonance: [
    {
      id,
    }
  ],
  resonanceCoefficientN,
  resonanceCoefficientR,
  resonanceCoefficientSR,
  resonanceCoefficientSSR,
  resonanceSourceMaterialList: [any],
  resonanceTrustExpList: [
    {
      exp,
    }
  ],
  resonanceUnlockLevel,
  resourceChapterList: [any],
  returnCoefficient,
  reversalProbabilityList: [
    {
      probability: [any],
      quotation: [any],
    }
  ],
  rewardMaxNum,
  rewardNum,
  rewardsList: [
    {
      id,
      weight,
      num,
    }
  ],
  riseMax,
  riseQuotationInitMax,
  riseQuotationInitMin,
  riseSuccessRateList: [
    {
      rate,
    }
  ],
  roadDistanceRange,
  roleGrade: [
    {
      id,
    }
  ],
  roleIdGrade: [
    {
      id,
    }
  ],
  roleLevelMax,
  roleList: [
    {
      roleId,
    }
  ],
  roleShakeEffectId,
  roleVolumeList: [
    {
      audioMixerPath,
      maxVolume,
      param,
    }
  ],
  rotSpeed,
  roundItemList: [
    {
      id,
    }
  ],
  rubNum1,
  rubNum2,
  rubNumRandom,
  rubProtect,
  runDistance,
  rushDelay,
  safeDayRedPoint,
  safeLevelLimit,
  saleConvertConstruct,
  scaleSpeed,
  scoreGradeList: [
    {
      comfort,
      delicious,
      fish,
      medic,
      pet,
      plant,
      play,
      upwin: [any],
    }
  ],
  scoreRankComparison: [
    {
      rank,
      score: [any],
    }
  ],
  scoreResPath: [
    {
      resPath,
    }
  ],
  sdiff01,
  sdiff02,
  searchCD,
  secondNameList: [
    {
      secondName,
    }
  ],
  secondOpenLevel,
  selectNum,
  selectRoleAllyId,
  sellItem: [
    {
      id,
    }
  ],
  sellItemList: [
    {
      id,
      func,
    }
  ],
  sellItemProfit: [
    {
      id,
    }
  ],
  sellItemServer: [
    {
      id,
    }
  ],
  sellPollutionRatio,
  servePosData: [any],
  serverStoreList: [
    {
      id,
    }
  ],
  setTypeNum,
  settlementDays,
  shareEnergyEnd,
  shareLv,
  shareTime,
  shopCostItem: [any],
  showOpen,
  showRankNum,
  showTrainPlayerMax,
  showTrainPlayerMin,
  sideRandom,
  skillUp: [any],
  skinItemList: [
    {
      id,
    }
  ],
  skinList: [
    {
      tag,
      trainTail,
      trainchar,
      trainhead,
      trainitem,
      traintran,
      trainweapon,
    }
  ],
  skinProportion,
  skinState2Condition,
  skinState2Num,
  skipGuide,
  skrikeRotateSpeed,
  sleepingBerth: [
    {
      price,
    }
  ],
  slidingHitBallHeight,
  slidingRotateSpeed,
  slive01,
  slive02,
  slowDownList: [
    {
      id,
      Level,
      Num,
    }
  ],
  slowdown,
  solicitCustomer: [
    {
      id,
    }
  ],
  solicitOpen,
  solicitQuestOpen,
  soundBrake,
  soundDrive,
  soundList: [
    {
      audioMixerPath,
      param,
    }
  ],
  soundStop,
  specialCamRot,
  specialCamX,
  specialCamY,
  specialCamZ,
  specialFieldOfView,
  specialIcon01,
  specialIcon02,
  specialIcon03,
  specialIcon04,
  specialIcon05,
  specialIcon06,
  speedAdd,
  speedRatio,
  speedReduce,
  speedReverse,
  speedUpList: [
    {
      id,
      Level,
      Num,
    }
  ],
  stackingquantity,
  stageBattleLabel: [
    {
      desText,
      nameText,
      nodeName,
      prefabPath,
    }
  ],
  standing,
  standingNum,
  starParameter: [
    {
      id,
    }
  ],
  starPassenger: [
    {
      seat,
    }
  ],
  starSeat: [
    {
      seat,
    }
  ],
  startAlpha,
  startCost,
  startTime,
  stationList: [
    {
      id,
    }
  ],
  stationPlaceCamRot,
  stationPlaceCamX,
  stationPlaceCamY,
  stationPlaceCamZ,
  stationPlaceFieldOfView,
  stealCD,
  stealNum,
  stealRate,
  stickerCost: [
    {
      id,
      num,
    }
  ],
  stime01,
  storeList: [any],
  storeMainList: [
    {
      id,
    }
  ],
  storyQuestChapterList: [
    {
      id,
    }
  ],
  strengthList: [
    {
      gold,
      item,
      level,
    }
  ],
  strengthenEquipment: [
    {
      id,
    }
  ],
  strikeAtkParam,
  strikeBallHeight,
  strikeGiftId,
  strikeQuestId,
  strikeTipCd,
  strikeViewAngle,
  strikeViewDis,
  strikeViewFov,
  strikeViewPosY,
  studyList: [
    {
      id,
    }
  ],
  studyUI,
  subPanelCloseId,
  subPanelOpenId,
  successNum,
  suddenQMax,
  suddenQuotationList: [
    {
      num,
      sTime,
    }
  ],
  suddenQuotationMax,
  suddenQuotationMin,
  swipeId,
  sysUnit,
  systemNoticeList: [
    {
      isImportance,
      isUpdate,
      lmtID,
    }
  ],
  tabCategoryList: [
    {
      icon,
      isShow,
      label,
      name,
      rank,
      ratio,
    }
  ],
  tagUseOnceId,
  talkIntervalMin,
  talkIntervalRandom,
  targetInvisibleDelayFrame,
  taxConvertRep,
  teamBuff: [
    {
      buff: [any],
      num,
    }
  ],
  teamCardPath,
  teamList: [any],
  teamNum,
  teamOrderList: [
    {
      id,
      weight,
    }
  ],
  teamOrderNum,
  teamProLower,
  teamProUpper,
  teamRepLimit,
  teamScorePath,
  teamViewAngle,
  teamViewDis,
  teamViewFov,
  teamViewPos: [
    {
      x,
      y,
      z,
    }
  ],
  techtreeList: [any],
  testLevelId,
  textReplaceList: [
    {
      value,
      key,
    }
  ],
  textureQualityList: [
    {
      num,
      optionName,
    }
  ],
  themeList: [
    {
      id,
    }
  ],
  thirdOpenLevel,
  tickerDistance,
  tileAngleX,
  timeCostBaseList: [
    {
      id,
      num,
    }
  ],
  timeCostList: [
    {
      id,
      num,
    }
  ],
  timeInterval: [
    {
      max,
      min,
    }
  ],
  timeLimit,
  timeList: [
    {
      time,
    }
  ],
  timePermit,
  timeRatio,
  timeoutCD,
  timeoutNumW,
  timesAdd: [
    {
      id,
      timesNum,
    }
  ],
  tipOpenId,
  tipsList: [
    {
      tips,
    }
  ],
  tiredAdd: [
    {
      id,
    }
  ],
  trade: [
    {
      id,
    }
  ],
  tradeBargainFailureList: [
    {
      id,
    }
  ],
  tradeBarginSuccessList: [
    {
      id,
    }
  ],
  tradeCoin,
  tradeConvertDev,
  tradeLevel: [
    {
      id,
    }
  ],
  tradeNoteList1: [
    {
      level,
      path,
    }
  ],
  tradeNoteList2: [
    {
      level,
      path,
    }
  ],
  tradeNoteList3: [
    {
      level,
      path,
    }
  ],
  tradeNoteList4: [
    {
      level,
      path,
    }
  ],
  tradeRaiseSuccessList: [
    {
      id,
    }
  ],
  tradeSettlementBuyList: [
    {
      id,
    }
  ],
  tradeSettlementSell,
  tradeSettlementSell100W,
  tradeSettlementSell30W,
  trailerCost: [
    {
      dis,
      mileage,
      price,
    }
  ],
  trailerEndTime,
  trailerFreeCost: [
    {
      dis,
      price,
    }
  ],
  trailerItem,
  trailerList: [
    {
      weight,
      speedAdd,
      speedDec,
      speedMax,
      speedMin,
      speedRush,
      trailerExtra,
      trainId, // -> ListFactory.id
    }
  ],
  trailerMax,
  trailerMaxLv,
  trailerMonthCardCost: [any],
  trailerMonthCardMax,
  trailerMonthCardSpeed,
  trailerReturnBuffCost: [
    {
      dis,
      mileage,
      price,
    }
  ],
  trailerStartTime,
  trailerUnlock,
  trailerUpgradeCost: [
    {
      id,
    }
  ],
  trainCameraList: [
    {
      mainPosY: [any],
      mainPosZ: [any],
      name,
      posX: [any],
      posY: [any],
      posZ: [any],
      rotX: [any],
      rotY,
    }
  ],
  trainGap,
  trainHelpCost,
  trainHelpDec,
  trainHelpLook,
  trainHelpSpeed,
  trainHelpSpeedAdd,
  trainHelpSpeedDec,
  trainLength: [
    {
      id,
    }
  ],
  trainList: [
    {
      weight,
      speedAdd,
      speedDec,
      speedMax,
      speedMin,
      trainId,
    }
  ],
  trainMaintain: [
    {
      id,
    }
  ],
  trainRemould: [
    {
      id,
    }
  ],
  trainRepair: [
    {
      id,
    }
  ],
  trainRushBuyList: [
    {
      id,
      num,
    }
  ],
  trainRushInit,
  trainRushLimit,
  trainRushSpeedAdd,
  trainRushTime,
  trainScale,
  trainShakeStrength,
  trainShakeTime,
  trainShakeTimeMax,
  trainShakeTimeMin,
  trainSoundId,
  trainSoundList: [
    {
      id,
    }
  ],
  trainSpeedInit,
  trainSpeedMinimum,
  trainTolerance,
  trainWash: [
    {
      id,
    }
  ],
  trainWeaponTypeList: [
    {
      id,
    }
  ],
  trainlength,
  trainlong,
  transportLvList: [
    {
      reward,
      tranExp,
      tranLv,
    }
  ],
  travel: [
    {
      id,
    }
  ],
  triggerTimeMax,
  triggerTimeMin,
  trustExpInterval,
  trustExpList: [
    {
      exp,
    }
  ],
  tvEnd: [
    {
      bubbleIcon,
      bubbleId,
      endEnId,
      endId,
      icon,
    }
  ],
  tvId,
  tvShowNum,
  tvTime,
  typeConstantList: [
    {
      id,
      num: [any],
    }
  ],
  typeList: [any],
  uiBgmList: [
    {
      PrefabUrl,
      soundId,
    }
  ],
  uiLadflet,
  upArrow,
  upGradeTrainWeapon: [
    {
      id,
    }
  ],
  upOperation: [any],
  upgradeOrderTimes,
  upgradeOrderValue,
  useParkBroom: [
    {
      id,
    }
  ],
  useParkCoinInOneGame: [
    {
      id,
    }
  ],
  useParkItem: [
    {
      id,
    }
  ],
  useShield: [any],
  valuableRefreshTime,
  version,
  victoryDelay,
  viewField1,
  viewField2,
  viewFieldTime1,
  viewFieldTime2,
  voiceArrive: [
    {
      id,
      type,
    }
  ],
  voiceArrivePassenger: [
    {
      id,
      type,
    }
  ],
  voiceDeparture: [
    {
      id,
      type,
    }
  ],
  voiceDeparturePassenger: [
    {
      id,
      type,
    }
  ],
  voiceGetIn: [any],
  voiceGetInPassenger: [any],
  voiceWillArrive: [
    {
      id,
      type,
    }
  ],
  voiceWillArrivePassenger: [
    {
      id,
      type,
    }
  ],
  volleyballGame: [
    {
      id,
    }
  ],
  wActivityItem,
  wApRewardList: [any],
  waitTime,
  wallTileOffset,
  wallTypeList: [
    {
      id,
    }
  ],
  warningId,
  wcoinConverRatio,
  weaponBag,
  weaponCreate,
  weekDayCoefficient,
  weekDayList: [
    {
      day,
    }
  ],
  weeklyQuestList: [any],
  whistleSoundId,
  whitePoint,
  wikiUzlUI,
  winCondition,
  winReowrd: [
    {
      id,
      weight,
      num,
    }
  ],
  workdayNum,
  yChangeZ,
  yChangeZFurniture,
  yao,
}
```

## Relations

### Suspected
- ConfigFactory.trainList[].trainId -> ListFactory.id (hit_ratio=1.000000, gap=1.000000, total=35; total<60)
- ConfigFactory.buffCountList[].buffId -> BuffFactory.id (hit_ratio=1.000000, gap=1.000000, total=45; total<60)
- ConfigFactory.buffCountList[].tagId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=45; total<60)
