# GuildanceOrderFactory

## Schema

```js
GuildanceOrderFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  actionId,
  buff,
  cardIndex,
  cardList: [
    {
      card,
    }
  ],
  cost_SN,
  customSortingOrder,
  delayFrame,
  duration,
  endX,
  endY,
  fingerIndex,
  guildanceID,
  handIndex,
  height_half: [any],
  isActive,
  isActiveDeckBtn,
  isActiveDiscardBtn,
  isActiveEnvironmentBtn,
  isActivePauseBtn,
  isActiveSelf,
  isActiveSubUIBtn,
  isActiveWeatherBtn,
  isBan,
  isCircle,
  isDoTween,
  isHideAll,
  isLoop,
  isUseLeader,
  isWait,
  isWaitEnd,
  list: [
    {
      path,
    }
  ],
  nodeName,
  offsetX,
  offsetY,
  orderList: [
    {
      orderID,
    }
  ],
  panelName,
  paragraphID,
  parentName,
  posX: [any],
  posY: [any],
  position_x,
  position_y,
  scaleX,
  scaleY,
  setAnimationName,
  side,
  soundId, // -> SoundFactory.id
  speed,
  targetId,
  targetTagList: [
    {
      tagId,
    }
  ],
  team,
  text,
  tipsIndex,
  unitId,
  width_half: [any],
}
```

## Relations

### Suspected
- GuildanceOrderFactory.targetTagList[].tagId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=41; total<60)
