# UnitViewFactory

## Schema

```js
UnitViewFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  quality,
  iconPath,
  tipsPath,
  Getway: [
    {
      DisplayName,
      FromLevel,
      UIName,
      Way3,
      funcId,
    }
  ],
  HomeresDir,
  ProfilePhotoList: [
    {
      id,
      weight,
    }
  ],
  SkinDesc,
  SkinName,
  SpineBGScale: [any],
  SpineBGX: [any],
  SpineBGY: [any],
  SpineBackground,
  SpineIdleListId,
  State2Desc,
  State2Face,
  State2Gacha,
  State2Name,
  State2Res,
  State2RoleListRes,
  State2profilePhotoID,
  a,
  b,
  battleTagOffsetX: [any],
  battleTagOffsetY: [any],
  blockCN,
  blockEN,
  blockJP,
  blockKR,
  blockTW,
  bookFull,
  bookHalf,
  bookX: [any],
  bookY: [any],
  bottomFixEffectUrl,
  character,
  clickEffectLayer,
  clickEffectUrl,
  clickHideFixEffect,
  effectScale: [any],
  exchangeBulletList: [
    {
      bulletId, // -> BulletFactory.id
      changeBulletId, // -> BulletFactory.id
    }
  ],
  exchangeEffectList: [
    {
      changeEffectId, // -> EffectFactory.id
      effectId, // -> EffectFactory.id
    }
  ],
  exchangeRolePathList: [any],
  exchangeSoundList: [
    {
      SoundId,
      changeSoundId,
    }
  ],
  extraClickAnimationList: [
    {
      weight,
      name,
    }
  ],
  extraSpineList: [any],
  face,
  frontFixEffectUrl,
  g,
  gacha,
  gachaPerformUrl,
  gachaSpine2Url,
  gachaVoice,
  gachaX,
  gachaY,
  homeSkill,
  hpBarOffsetX,
  hpBarOffsetY: [any],
  isSpine2,
  mainUIVoice,
  offsetScale: [any],
  offsetX: [any],
  offsetX2,
  offsetY: [any],
  offsetY2,
  ownExclusiveVoice,
  plotResList: [
    {
      plotResUrl,
    }
  ],
  profilePhotoID,
  r,
  resDir,
  resUrl,
  rewardList: [
    {
      id,
      num,
    }
  ],
  roleListResUrl,
  shadowID,
  shadowOffsetY,
  shadowOffsetZ,
  shadowScale: [any],
  singleUrl,
  skinBattlePass,
  spine2BgUrl,
  spine2EffectUrl,
  spine2Scale: [any],
  spine2Url,
  spine2X: [any],
  spine2Y,
  spineScale: [any],
  spineUrl,
  spineX,
  spineY,
  squadsHalf1,
  squadsHalf2,
  squadsX,
  squadsY: [any],
  state2Overturn,
  useSpecialBeHitColor,
  userSpecialShadow,
}
```
