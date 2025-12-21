# GuideFactory

## Schema

```js
GuideFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  apiName,
  assignGuideId,
  completeQuest,
  curStationRepLvLimit,
  isEndLoading,
  isInterruptedSkip,
  isRunInterrupt,
  levelFinishedFO,
  levelId,
  orderList: [
    {
      orderId, // -> GuideOrderFactory.id
    }
  ],
  playerLevel,
  reachStation,
  scene,
  triggerMeetEvent,
  triggerPanelName,
  triggerProtocol,
  triggerQuest,
}
```
