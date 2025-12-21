# PlaygroundFactory

## Schema

```js
PlaygroundFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  CabinConnectWidthCell,
  PublicizeList: [
    {
      id,
    }
  ],
  added,
  bag,
  battleProportion,
  bubbleList: [
    {
      bubblePath,
      changeTime,
      offsetX,
      offsetY,
      offsetZ,
    }
  ],
  camLeftDragOffsetX,
  camMoveLimitCellFurPlace,
  camRightDragOffsetX,
  cameraDefaultOffsetX,
  cameraXAngle,
  cameraYPos,
  cameraZPos,
  cellX,
  cellY,
  cellZ,
  charNumMax,
  cleanList: [
    {
      ReduceCleanliness,
      overflowtime,
    }
  ],
  coachId,
  comfortDayAdd,
  comfortDayAddMax,
  comfortNum,
  debuffTime,
  debuffVal,
  designCamXAngle,
  designCamYPos,
  designCamZPos,
  divide,
  doReduceRate,
  eventList: [
    {
      activityId,
      bubbleString,
      endTime,
      eventId,
      eventType,
      homeQId,
      isAuto,
      isPrefabBubble,
      qXPos,
      qYPos,
      questId,
      startTime,
    }
  ],
  expList: [
    {
      exp,
      investId, // -> ListFactory.id
      levelList,
      levelReward,
      maxLevelNum,
      travelDay,
      unlockQuest,
      visitorId, // -> PondFactory.id
    }
  ],
  extendLimitTips,
  extendList: [
    {
      id,
    }
  ],
  fishDayAdd,
  fishDayAddMax,
  fishNum,
  fixedNum,
  floorTileOffset,
  foodDayAdd,
  foodDayAddMax,
  foodNum,
  furnitureTypeList: [
    {
      id,
    }
  ],
  guestNum,
  helpNum,
  incomeEndLine,
  investTime,
  isLvMin,
  isOpenIntrusion,
  islandTravelDayUp,
  islandTravelFirstDay,
  itemId,
  levelList: [
    {
      id,
      weight,
    }
  ],
  levelTimeList: [
    {
      id,
      weight,
    }
  ],
  loadingList: [
    {
      imagePath,
    }
  ],
  lvLimitText,
  lvLimitTips,
  maxDivide,
  maxLv,
  maxStability,
  medicalDayAdd,
  medicalDayAddMax,
  medicalNum,
  noMONTips,
  npcId,
  parkBasics,
  parkCityId,
  parkLeafletNum,
  parkOut,
  parkPond: [
    {
      investId, // -> ListFactory.id
      travelDay,
      visitorId, // -> PondFactory.id
    }
  ],
  parkTicket,
  parkTicketMax,
  parkType,
  parkWaste,
  passagewayList: [
    {
      z,
    }
  ],
  petDayAdd,
  petDayAddMax,
  petExScore,
  petNum,
  petReduceRate,
  plantDayAdd,
  plantDayAddMax,
  plantNum,
  playDayAdd,
  playDayAddMax,
  playNum,
  qualityShadowDistance,
  questList: [
    {
      id,
    }
  ],
  rubLvMin,
  rubNum1,
  rubNum2,
  rubNumRandom,
  rubProtect,
  sceneDefaultOffsetX,
  sceneName,
  showNum,
  stabilityList: [
    {
      num,
      val,
    }
  ],
  stealCD,
  stealNum,
  stealRate,
  stlmtTips,
  tax,
  unlockQuest,
  visitorNum,
  visitorNumMax,
  visitorUnlocksid,
  wallTileOffset,
}
```
