# BattlePassFactory

## Schema

```js
BattlePassFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  DailyQuest: [
    {
      BPDailyQuest,
      QuestSort,
    }
  ],
  GapPassRewardList: [any],
  LevelLimit,
  LowextraReward: [
    {
      id,
      num,
    }
  ],
  PassEndTime,
  PassRewardList: [
    {
      PassLevel,
      freeID,
      freeNum,
      upgradeID,
      upgradeNum,
    }
  ],
  PassStartTime,
  PlayerSkinF,
  PlayerSkinM,
  Points,
  RewardPreview: [any],
  SpineBGScale: [any],
  SpineBGX: [any],
  SpineBGY: [any],
  SpineBackground,
  SpineScale: [any],
  SpineX,
  SpineY: [any],
  background,
  bpPrice: [
    {
      id,
      bpName,
      price,
    }
  ],
  extraReward: [
    {
      id,
      num,
    }
  ],
  price2,
  purchaseBPLevel: [
    {
      id,
      num,
    }
  ],
  recommendStoreImg,
  recommendStoreTabImg,
  rewardShow: [
    {
      id,
      num,
    }
  ],
  skinIcon,
  skinNameIcon,
  skinNameIconX,
  skinNameIconY,
  skinThisSeason,
  topicIcon,
  topicIconX: [any],
  topicIconY: [any],
  topicName,
  topicNameEN,
  weekQuest: [
    {
      BPWeeklyQuest,
      QuestSort,
    }
  ],
  weekQuestList: [any],
}
```
