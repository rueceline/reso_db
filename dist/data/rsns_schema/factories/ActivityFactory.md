# ActivityFactory

## Schema

```js
ActivityFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  ActivityLevelId,
  ImgX,
  ImgY,
  PersonalProgressList: [
    {
      id,
    }
  ],
  ServerProgressList: [
    {
      id,
      buff,
      buyIcon,
      buyNum,
      buyPng,
      limit,
      revenueIcon,
      revenueNum,
      revenuePng,
    }
  ],
  activityCardPack,
  activityGoods,
  activityGradeList: [
    {
      id,
      endTime,
      startTime,
    }
  ],
  activityLeafletList: [
    {
      desc,
      endTime,
      leafletNum,
      startTime,
    }
  ],
  activityPassengerList: [
    {
      activityPond,
      activityPondNum,
      cityId,
      desc,
      endTime,
      startTime,
    }
  ],
  activityRankList: [
    {
      id,
    }
  ],
  activityRewardRankList: [
    {
      id,
    }
  ],
  activityStoreList: [
    {
      id,
    }
  ],
  activityTriggerList: [any],
  afterPlotLevel,
  allConstructionList: [
    {
      id,
      construction,
      limit,
      questId,
      tipsId,
    }
  ],
  allLevyList: [
    {
      id,
      levyNum,
    }
  ],
  allScheduleRefreshTime,
  bannerCapsuleList: [
    {
      id,
    }
  ],
  bannerList: [
    {
      id,
    }
  ],
  battleList: [
    {
      commonBg,
      icon,
      lockDes,
      lockedBg,
      missionId,
    }
  ],
  bgColor,
  bgPath,
  blackLevelList: [
    {
      id,
      icon,
      name,
      png,
    }
  ],
  bossFinalList: [
    {
      id,
    }
  ],
  bossHpReduceRatio,
  bossNormalList: [
    {
      id,
    }
  ],
  bossSpineAnim,
  bossSpinePath,
  bossSpineScaleX: [any],
  bossSpineScaleY: [any],
  bossSpineX,
  bossSpineY,
  bossTimes,
  bossTimesBuy,
  bossTimesCost: [
    {
      id,
      num,
    }
  ],
  btnBottomTxtSize,
  btnBottomY,
  buffContinueTime,
  circleTextList: [
    {
      id,
      endTime,
      startTime,
    }
  ],
  city,
  claimedIcon,
  clearCurrencyList: [
    {
      id,
    }
  ],
  closeTime,
  constructionEndList: [
    {
      id,
      num,
    }
  ],
  constructionItemId,
  constructionLimit,
  constructionPreviewList: [
    {
      id,
      icon,
    }
  ],
  continueTime,
  correspondingBuild: [
    {
      id,
    }
  ],
  correspondingCity: [
    {
      id,
    }
  ],
  correspondingConfig,
  correspondingFurniture,
  correspondingScene,
  dayAligningType,
  daySignColor,
  daySignedColor,
  dayTxtSize,
  dayTxtY,
  endTime,
  endlessBattleCoinId,
  endlessBattleLv,
  endlessLevelList: [
    {
      id,
    }
  ],
  endlessMaxTeams,
  endlessRefresh,
  eventRandomWeek: [
    {
      id,
      weight,
      bgPng,
      circleText,
      eventText,
      npcId,
      titleText,
      tvBgPng,
    }
  ],
  eventType,
  gameList,
  gameOpen,
  gameQuestLimit,
  gameUnlockTips,
  getProduction: [
    {
      id,
    }
  ],
  getProductionCost: [
    {
      id,
      num,
    }
  ],
  getProductionPremise,
  giftList: [
    {
      id,
    }
  ],
  goodsList: [
    {
      buyQuotationMax: [any],
      buyQuotationMin,
      buyStationList,
      endTime,
      goodsId,
      reversalProbability,
      sellQuotationMax,
      sellQuotationMin: [any],
      sellStationList,
      startTime,
    }
  ],
  gradeIncomeList: [any],
  helpId,
  interviewNpcList: [
    {
      id,
      bgPng,
      endTime,
      startTime,
    }
  ],
  isBtnContentOpen,
  isBtnIcon,
  isChangeCOCQuest,
  isChangeLeaflet,
  isChangePond,
  isChangeQuotation,
  isClearAllQuest,
  isClearCurrency,
  isClearPersonalQuest,
  isCloseReward,
  isDynamicEndTime,
  isGoldLevel,
  isIconOpen,
  isJoin,
  isNew,
  isOnly,
  isRefreshStore,
  isTime,
  isTriggerTime,
  islandGrade,
  joinGetItem: [
    {
      id,
      num,
    }
  ],
  joinLimit,
  joinPlotId,
  joinQuestId,
  levelEndTime,
  levelPlotList: [
    {
      id,
    }
  ],
  levelQuest,
  levelQuestLimit,
  levelReward,
  levelTypeList: [
    {
      id,
      startTime,
    }
  ],
  needRegisterTime,
  notTimeBottom,
  notTimeBtn,
  npcId,
  num,
  openLv,
  openTipsType,
  openTradeLv,
  openUi,
  orderList: [
    {
      id,
      weight,
    }
  ],
  orderMaxNum,
  personalConstructionList: [
    {
      id,
      construction,
      questId,
      tipsId,
    }
  ],
  personalLevyList: [
    {
      id,
      levyNum,
    }
  ],
  personalRewardList: [
    {
      id,
      num,
    }
  ],
  powerLv,
  powerRoleList: [
    {
      id,
    }
  ],
  priceSeatList: [
    {
      id,
    }
  ],
  putTime,
  questId,
  rankingMail,
  rankingReward: [
    {
      id,
      rank,
    }
  ],
  recycleCityList: [
    {
      cityId,
      endTime,
      highCoefficient,
      materialList,
      startTime,
    }
  ],
  replicateNum,
  requiredMaterials: [
    {
      id,
    }
  ],
  returnBuffList: [
    {
      id,
    }
  ],
  returnNewsList: [
    {
      id,
      newsBG,
      newsIcon,
      newsTitle,
    }
  ],
  returnRewards: [
    {
      id,
      num,
    }
  ],
  returnSignIn,
  returnTask: [
    {
      id,
    }
  ],
  returnTaskRewards: [
    {
      num,
      rewards,
    }
  ],
  rewardBG,
  rewardEndTime,
  rewardNotBG,
  rewardPreviewList: [
    {
      id,
    }
  ],
  rewardSBG,
  rewardsList: [
    {
      amount,
      rewardsListId,
    }
  ],
  rogueId,
  sequenceList: [
    {
      skipId,
      startTime,
    }
  ],
  setTime,
  setType,
  showOpenTipsUI,
  showResidueUI,
  showUI,
  signBG,
  signBattleExtract,
  signBattleInitLevel,
  signBattleLimitLv,
  signBattleRewards: [
    {
      id,
      num,
    }
  ],
  signBattleTimeExtra,
  signBattleUI,
  signBgImg,
  signBottom,
  signBtn,
  signChallengeActivityId,
  signColor,
  signDesPathId,
  signIcon,
  signIconImg,
  signLevelList: [
    {
      id,
    }
  ],
  signMask,
  signRegisterEndTime,
  signRegisterStartTime,
  signTitleAboveC,
  signTitleAboveE,
  signTitleBottomC,
  signTitleBottomE,
  signTitleImg,
  signTitlePathId,
  signedBG,
  signedBottom,
  signedBtn,
  signedColor,
  signinId,
  skipQuestLimit,
  skipStationEnd,
  skipStationStart,
  spaceTime,
  startTime,
  stationList: [any],
  taskIndex,
  timeColor,
  timeImgX,
  timeImgY,
  timeLineBG,
  timeLineColor,
  titleColor,
  titleTextList: [
    {
      id,
      endTime,
      startTime,
    }
  ],
  tradeTypeList: [
    {
      icon,
      seriesName,
      targetNum,
      typeEnum,
      typeId,
    }
  ],
  unClaimedIcon,
  unSignInColor,
  unlockTips,
  videoAddress,
  videoHttp,
  voiceActivity,
  witchesGameMap,
  witchesQuestLimit,
}
```
