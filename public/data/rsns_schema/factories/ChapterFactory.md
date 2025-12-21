# ChapterFactory

## Schema

```js
ChapterFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  abbreviate,
  advList: [
    {
      id,
      weight,
    }
  ],
  backgroundPath,
  bottom,
  chapterIndex,
  chapterMapBackground,
  left,
  levelChainList: [any],
  mainBgPath,
  mainPath,
  mainVideoList: [
    {
      mainVideoPath,
    }
  ],
  nameCN,
  nameEN,
  pathList: [any],
  placeCN,
  placeEN,
  resUrl,
  rewardlList: [any],
  right,
  saveProgress,
  spineMarkId,
  spinePointId,
  stageInfoList: [
    {
      chapterIndexDes,
      index,
      indexDes,
      isSpecialLevel,
      levelId, // -> LevelFactory.id
    }
  ],
  subLevelList: [any],
  time,
  top,
}
```
