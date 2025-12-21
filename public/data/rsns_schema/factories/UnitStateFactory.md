# UnitStateFactory

## Schema

```js
UnitStateFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  actionLevel,
  aniName,
  aniTime_SN,
  customFrameTag,
  effectList: [
    {
      effectId, // -> EffectFactory.id
      offsetX: [any],
      offsetY: [any],
      triggerFrame,
      triggerTime_SN,
    }
  ],
  frameChanged,
  frameEventList: [
    {
      frameEventId, // -> FrameEventFactory.id
      hHalf_SN,
      triggerFrame,
      triggerTime_SN,
      wHalf_SN,
      x_SN,
      y_SN,
    }
  ],
  isLoop,
  isSetSortingOrder,
  isYChange,
  keyFrameList: [
    {
      keyFrame,
      x_SN,
      y_SN,
    }
  ],
  offsetYList: [any],
  previousActionList: [
    {
      actionID,
    }
  ],
  scaleRateSN,
  sortingOrder,
  soundList: [
    {
      soundId, // -> SoundFactory.id
      triggerFrame,
      triggerTime_SN,
    }
  ],
  speedY_SN,
  speed_SN,
  totalFrame,
  viewId, // -> UnitViewFactory.id
}
```
