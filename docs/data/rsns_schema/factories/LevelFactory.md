# LevelFactory

## Schema

```js
LevelFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  CorrespondingList,
  FightAreaCenterList: [any],
  abyssId, // -> AbyssFactory.id
  activityId, // -> ActivityFactory.id
  adaptLvSN,
  addStability,
  autoDifficultyMax,
  bgIdList: [
    {
      id,
    }
  ],
  bgResUrl,
  bgmId, // -> SoundFactory.id
  bossId, // -> UnitFactory.id
  bossName,
  buildingId, // -> BuildingFactory.id
  canChangeCaptain,
  caseTimeLimit,
  changeCityStateList: [
    {
      id,
      state,
    }
  ],
  chapterId, // -> ChapterFactory.id
  characterExp,
  cityId, // -> HomeStationFactory.id
  constructLimit,
  correspondingActivity,
  defaultAutoCode,
  description,
  difficulty,
  dropListNew: [any],
  dropTableList: [
    {
      listId, // -> ListFactory.id
    }
  ],
  endParagraphId,
  enemyBookId,
  enemyBookList: [
    {
      id,
      score,
    }
  ],
  enemyLvOffset,
  enemyWaveList: [
    {
      enemyWaveId, // -> EnemyWaveFactory.id
    }
  ],
  energyEnd,
  energyStart,
  equalList: [
    {
      id,
      num,
    }
  ],
  expelNum,
  extraEnergy,
  extraLevelOffset,
  firstPassAward: [
    {
      itemId,
      num,
    }
  ],
  firstPassAwardS: [
    {
      id,
      num,
    }
  ],
  guildanceListZero: [
    {
      guildanceID,
    }
  ],
  homeChrId,
  iconName,
  insZoneBGMId, // -> SoundFactory.id
  isAlwaysWin,
  isAutoDifficulty,
  isBanAutoBattle,
  isCanHelp,
  isCatchPrison,
  isCustomDifficulty,
  isDisplayLeaderBoard,
  isEnemyLvEquilsPlayer,
  isExtraFightCenter,
  isForbidStopTimeLua,
  isMainChapter,
  isPlotLimited,
  isShowEnemySkill,
  isSkipWin,
  isUploadRankCount,
  isUseLevelRole,
  isUseScript,
  isWitchesBoss,
  itemCost: [
    {
      id,
      num,
    }
  ],
  itemDemand: [any],
  leaderBoardSortType,
  levelBgType,
  levelBuffList: [
    {
      buffId, // -> BuffFactory.id
    }
  ],
  levelChapter,
  levelCoreId,
  levelDemand: [
    {
      id,
      num,
    }
  ],
  levelFOV,
  levelIcon,
  levelName,
  levelRoleList: [
    {
      id,
    }
  ],
  levelStar,
  limitBattleType,
  limitNum,
  loadingPng,
  loadingTips,
  mailList: [any],
  mainBgPath,
  maxGold,
  maxRecordNum,
  maxScore,
  maxScoreList: [
    {
      gradeLine,
    }
  ],
  minRoleNum,
  musicList: [any],
  mvpType,
  nextLevel,
  paragraphId, // -> ParagraphFactory.id
  perfectAward: [any],
  pictureList: [
    {
      id,
      score,
    }
  ],
  playerExp,
  playerLevel,
  playerLevelMax,
  playgroundId,
  questList: [
    {
      id,
    }
  ],
  randWaveLimit,
  randWaveList: [
    {
      waveListId, // -> ListFactory.id
    }
  ],
  randWaveMinLimit,
  rankType,
  rating,
  recomGrade,
  reputation,
  rewardCoefficientMax,
  rewardCoefficientMin,
  roleNumOffSet,
  saleLevelType,
  shareList: [
    {
      itemId,
      numMax,
      numMin,
      percent: [any],
    }
  ],
  skipBattleRestricted,
  sort,
  specifiedLevelList: [
    {
      specifiedLevelId, // -> LevelFactory.id
      specifiedLevelScore,
    }
  ],
  specifiedLevelLogical,
  stageList: [
    {
      id,
      lossHP: [any],
    }
  ],
  time,
  timeLimit,
  timeReward: [
    {
      id,
      time,
    }
  ],
  uiSpineRatio,
  uiSpineX,
  uiSpineY,
  unlockQuestList: [
    {
      id,
    }
  ],
  videoList: [
    {
      id,
      score,
    }
  ],
  weatherId, // -> WeatherFactory.id
  weatherList: [
    {
      weatherId, // -> WeatherFactory.id
    }
  ],
  weatherRateSN,
}
```

## Relations

### Suspected
- LevelFactory.levelCoreId -> EngineCoreFactory.id (hit_ratio=1.000000, gap=1.000000, total=50; total<60)
