# BulletFactory

## Schema

```js
BulletFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  adjustScreenResolution,
  appearEffectList: [
    {
      effectId,
    }
  ],
  bRepeated,
  bulletViewId, // -> BulletViewFactory.id
  controllerIndex,
  customRadiusTag,
  damageRadius_SN,
  delayFrame,
  disappearEffectList: [
    {
      effectId,
    }
  ],
  disappearFrame,
  dontBindOwner,
  duration,
  durationFrame,
  durationMin,
  effectID,
  envBuffId,
  finalScale,
  frameEvent,
  frameRotation_SN,
  frame_SN,
  groundEffectList: [
    {
      effectId, // -> EffectFactory.id
    }
  ],
  groundSoundId, // -> SoundFactory.id
  hitEffect,
  hitFrameList: [
    {
      hitFrame,
    }
  ],
  hitSoundId, // -> SoundFactory.id
  hitTimes,
  hitTimesCustomTag,
  incrementRotation_SN,
  intervalFrame,
  isActive,
  isAddSpeedZ,
  isCustomRadius,
  isDoBuffOnly,
  isFixedPosition,
  isForever,
  isGroundEffectUseHitTimes,
  isGroundSoundUseHitTimes,
  isHitTargetOnly,
  maxAngle,
  minAngle,
  rangeShakeFrame,
  rangeSpeedY_SN,
  reentrantCount,
  scaleTag,
  showSoundId,
  specifiedPosX_SN,
  specifiedPosY_SN,
  speedVector_SN,
  speedX_SN,
  speedY_SN,
  startScale,
  suspendView,
  totalFrame,
  useRandomSN,
  useRangeRandomSN,
  useSpecifiedPos,
  xOffSetStart_SN,
  xOffSet_SN,
  xSpeedOffSet_SN,
  xSpeedOffset_SN,
  xSpeedSetStart_SN,
  xlSN,
  xrSN,
  yOffSetStart_SN,
  yOffSet_SN,
  ySpeedOffSet_SN,
  ySpeedStart_SN,
  zOffSetStart_SN,
  zOffSet_SN,
}
```

## Relations

### Suspected
- BulletFactory.disappearEffectList[].effectId -> EffectFactory.id (hit_ratio=1.000000, gap=1.000000, total=39; total<60)
- BulletFactory.envBuffId -> BuffFactory.id (hit_ratio=1.000000, gap=1.000000, total=53; total<60)
