# RogueOrderFactory

## Schema

```js
RogueOrderFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  PlaneId,
  battleBuffType,
  changeList: [
    {
      id,
      x,
      y,
      z,
    }
  ],
  descent,
  discardList: [
    {
      id,
      num,
    }
  ],
  eventId,
  initialGetList: [
    {
      id,
      num,
    }
  ],
  insufficientTips,
  isEnough,
  isReuse,
  levelId,
  loseType,
  orderType,
  param: [any],
  param2: [any],
  probability: [any],
  qualityType,
  recoverType,
  refreshNum,
  requiredList: [
    {
      id,
      num,
    }
  ],
  rewardList: [
    {
      id,
      numMax,
      numMin,
    }
  ],
  skillId, // -> SkillFactory.id
  typeId: [
    {
      id,
    }
  ],
}
```
