# HomeFurnitureSkinFactory

## Schema

```js
HomeFurnitureSkinFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  iconPath,
  tipsPath,
  FurnitureSkinDetail,
  PictureUrl,
  RareType,
  SecondiconPath,
  SecondtipsPath,
  animationList: [
    {
      animationName,
      buttonName,
      icon,
    }
  ],
  banswitchAnimation,
  baseResList: [
    {
      offsetX,
      offsetY,
      offsetZ,
      resPath,
    }
  ],
  creaturePosList: [
    {
      x: [any],
      y: [any],
      z,
    }
  ],
  furBaseHeight: [any],
  furHeight: [any],
  furnitureHoleList: [
    {
      startX,
      startY,
      xLength,
      yLength,
    }
  ],
  nextQueueLinePos: [
    {
      actionName,
      horizontalFlip,
      offsetX,
      offsetY,
      workOffsetX,
      workOffsetY,
      workOffsetZ,
    }
  ],
  opPosList: [
    {
      actionName,
      horizontalFlip,
      offsetX,
      offsetY,
      workOffsetX: [any],
      workOffsetY: [any],
      workOffsetZ: [any],
    }
  ],
  pileUpOffsetZ: [any],
  queueLinePos: [
    {
      actionName,
      horizontalFlip,
      offsetX,
      offsetY,
      workOffsetX,
      workOffsetY,
      workOffsetZ,
    }
  ],
  resList: [
    {
      offsetX: [any],
      offsetY: [any],
      offsetZ: [any],
      resPath,
    }
  ],
  specialFurIcon,
  tagList: [
    {
      id,
      weight,
    }
  ],
  trainManOpPosList: [
    {
      endOffsetX,
      endOffsetY,
      horizontalFlip,
      offsetX,
      offsetY,
      startOffsetX,
      startOffsetY,
      workOffsetX,
      workOffsetY: [any],
      workTree,
    }
  ],
  userMin,
}
```
