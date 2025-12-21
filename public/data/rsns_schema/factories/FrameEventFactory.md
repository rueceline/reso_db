# FrameEventFactory

## Schema

```js
FrameEventFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  attributeType,
  buffFO,
  buffId, // -> BuffFactory.id
  buffJudgeType,
  buffLevel,
  buffTypeFO,
  bulletId, // -> BulletFactory.id
  condition,
  duration,
  fadeInFrame,
  fadeOutFrame,
  filterPosition,
  filterStance,
  halfWidth_SN,
  hitSoundID,
  isAimSelf,
  isIgnoreInvisibleEnemy,
  isUseTargetFilter,
  layerType,
  moviePath,
  numberType,
  number_SN,
  offSetX_SN,
  offSetZ_SN,
  pauseFrame,
  pauseStartFrame,
  tagType,
  targetCount,
  targetFilterType,
  targetTagList: [
    {
      tagId,
    }
  ],
  targetType,
  yOffset,
}
```
