# QuestFactory

## Schema

```js
QuestFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  IsPlotTask,
  achieveList,
  achievePng,
  achievePoint,
  activityId, // -> ActivityFactory.id
  addProgress,
  bannerList: [
    {
      id,
    }
  ],
  buffActivate,
  changeCityStateList: [
    {
      id,
      state,
    }
  ],
  checkComplete,
  childQuestList: [
    {
      id,
    }
  ],
  cityList: [
    {
      id,
    }
  ],
  client,
  cocQuestType,
  completeTab,
  conditionList: [
    {
      key,
      val,
    }
  ],
  constructLimit,
  correspondActivity,
  describe,
  describeNew,
  development,
  dontShowMain,
  endStationList: [
    {
      id,
      weight,
    }
  ],
  endTime,
  environmentList: [
    {
      idLine,
      idMsg,
    }
  ],
  episode,
  eventList: [
    {
      idLine,
      idList,
    }
  ],
  friendREPList: [
    {
      id,
      num,
    }
  ],
  friendRewardsList: [
    {
      id,
      num,
    }
  ],
  giftList: [
    {
      id,
    }
  ],
  giveUp,
  goodsList: [
    {
      id,
      num,
    }
  ],
  investment,
  isAllTask,
  isAnecdote,
  isAutoComplete,
  isAutoTrace,
  isEvent,
  isFURNQuest,
  isInitQuest,
  isOverwriteEvent,
  isRefreshProgress,
  isShare,
  isShowAchieveProgress,
  isShowProgress,
  isShowReceive,
  isShowUnlock,
  isSwitchUI,
  isTBC,
  isTeleport,
  isTime,
  islockAddProgress,
  mailList: [
    {
      id,
    }
  ],
  nextQuest: [
    {
      id,
    }
  ],
  num,
  parentQuest,
  passengerList: [
    {
      id,
      num,
      tag,
    }
  ],
  playerLevel,
  playgroundId, // -> PlaygroundFactory.id
  playgroundLv,
  preLevel: [
    {
      id,
    }
  ],
  preLv,
  preQuest: [
    {
      id,
    }
  ],
  preQuestId, // -> QuestFactory.id
  questId, // -> QuestFactory.id
  questTab,
  questTabDes,
  questType,
  recommendLevel,
  refreshType,
  reputationList: [
    {
      id,
      num,
    }
  ],
  requireItemList: [
    {
      id,
      num,
    }
  ],
  returnNum,
  rewardsList: [
    {
      id,
      num,
    }
  ],
  sharerREPList: [
    {
      id,
      num,
    }
  ],
  sharerRewardsList: [
    {
      id,
      num,
    }
  ],
  showType,
  sort,
  startLevel,
  startPrisonLevel,
  startStation,
  startTime,
  station,
  story,
  switchParameter,
  switchUI,
  target,
  targetCity,
  targetMain,
  teleportEndStation,
  teleportStartStation,
  teleportText,
  timeLimit,
  traceList: [
    {
      apiListId, // -> QuestTrackFactory.id
      btnListId, // -> QuestTrackFactory.id
      traceId, // -> QuestTrackFactory.id
      uiPath,
    }
  ],
  typeIcon,
  unlockCity,
}
```
