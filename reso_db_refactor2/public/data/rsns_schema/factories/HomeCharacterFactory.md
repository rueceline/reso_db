# HomeCharacterFactory

## Schema

```js
HomeCharacterFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  iconPath,
  Favorability: [
    {
      id,
      weight,
      num,
    }
  ],
  PetExpSourceMaterialList: [
    {
      id,
    }
  ],
  PetFoodInt,
  PetMood,
  aiTree,
  bgPath,
  bubbleX,
  bubbleY: [any],
  bubbleZ,
  catchTree,
  catchWalk,
  characteristicList: [
    {
      id,
    }
  ],
  chatGroupList: [
    {
      id,
      weight,
    }
  ],
  comfort,
  defaultSkins: [
    {
      id,
    }
  ],
  dislikeCharacter: [any],
  dislikeFurniture: [
    {
      id,
    }
  ],
  dorm_stand,
  dorm_walk,
  eat,
  favoriteCharacterList: [
    {
      id,
      weight,
    }
  ],
  favoriteCoachList: [any],
  favoriteFurnitureList: [any],
  fishScores,
  foodScores,
  infoTree,
  interactiveIconPath,
  maxTime,
  medicalScores,
  minTime,
  moveSpeed,
  moveSpeedY,
  nightTimeBegin,
  nightTimeEnd,
  noonTimeBegin,
  noonTimeEnd,
  nudeSkins: [
    {
      id,
    }
  ],
  petHomeRatio,
  petID,
  petInfoRatio,
  petInteractionList: [
    {
      interaction,
    }
  ],
  petScores,
  plantScores,
  playScores,
  produceNum,
  resDir,
  resStatePath: [
    {
      path,
      state,
    }
  ],
  rest,
  sex,
  sexualOrientation,
  shadowResDir,
  shadowScaleX,
  shadowScaleY,
  speakDefaultList: [
    {
      id,
    }
  ],
  spineAnimationInfos: [any],
  stand,
  touchHandlerBgPath,
  touchHandlerResPath,
  trainmanTree,
  upgradeList: [
    {
      id,
    }
  ],
}
```
