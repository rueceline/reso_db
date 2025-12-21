# CubeRogueFactory

## Schema

```js
CubeRogueFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  actionNum,
  battleBuffType,
  bookTypeList: [
    {
      id,
      cover,
      name,
      showUI,
    }
  ],
  bossMoveColor,
  bossMuseNum,
  bossPlaneNum,
  buffSettlementNum,
  cameraView,
  cameraX,
  cameraY,
  cameraZ,
  cardPackId,
  certainlyGenerateList: [any],
  characterLv,
  coinId,
  commonExperienceCoefficient,
  commonExperienceItem,
  commonLevelStageList: [
    {
      stageList,
      startTime,
    }
  ],
  cubeCenterModle,
  cubeCornerModle,
  cubeEntiretyModle,
  cubeList: [
    {
      id,
      x,
      y,
      z,
    }
  ],
  cubeModle,
  cubeSideModle,
  cubeSize,
  currentColor,
  descentBuffList: [
    {
      id,
    }
  ],
  descentMaxLevelList: [
    {
      maxLv,
      maxNum,
    }
  ],
  eliteMuseNum,
  elitePlaneNum,
  enterAnimation,
  enterGetList: [
    {
      id,
      num,
    }
  ],
  equipSettlementNum,
  extraGetList: [
    {
      id,
      weight,
    }
  ],
  extraRoleList: [
    {
      id,
    }
  ],
  faceIndex,
  firstPlotId,
  helpList: [
    {
      path,
    }
  ],
  initialDistance,
  initialX,
  initialY,
  initialZ,
  instinctMaxNum,
  jumpSound,
  loadingList: [
    {
      imagePath,
    }
  ],
  moveCameraView,
  moveCameraY,
  moveColor,
  museSkill,
  nextId,
  numIcon,
  ordinaryMuseNum,
  ordinaryPlaneNum,
  outAnimation,
  outlineWidth,
  planeSkill,
  planesName,
  playerModel,
  questTypeList: [
    {
      questList,
      typeName,
    }
  ],
  resetSpeed,
  restId,
  rogueDifficultList: [
    {
      id,
      actionNum,
      enemyList,
      enemyLv,
      icon,
      initialCubeId,
      insideIcon,
      isDifficult,
      name,
      relevant,
      settlementCoefficient: [any],
      weeklyExperience,
      weeklyExperienceAdd,
    }
  ],
  rogueTeamList: [
    {
      id,
    }
  ],
  rotSpeed,
  rotTime,
  rotateX,
  skillCoefficient,
  skillItem,
  skillList: [
    {
      id,
      requiredNum,
    }
  ],
  slideSoundList: [
    {
      id,
    }
  ],
  specialGenerateList: [
    {
      id,
      weight,
    }
  ],
  specialItemId,
  specialItemModel,
  specialNum,
  specialSkillBuff,
  spinSideColor,
  spinX,
  spinY,
  storeId,
  turnSound,
  typeLimitList: [
    {
      id,
      num,
    }
  ],
  weeklyExperienceItem,
  weeklyRewardsList: [
    {
      id,
      num,
      requiredNum,
    }
  ],
}
```
