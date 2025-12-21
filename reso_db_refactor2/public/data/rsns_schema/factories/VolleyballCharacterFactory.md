# VolleyballCharacterFactory

## Schema

```js
VolleyballCharacterFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  anime: [
    {
      afterAnim,
      anime,
      beforeAnime,
      effect,
      sound,
      soundLoop,
      soundStartTime,
    }
  ],
  canSlidingDis,
  defaultJumpHeight,
  fallAcc,
  fallSpeed,
  happyAnim: [
    {
      weight,
      animName,
    }
  ],
  jumpTime,
  maxSlidingDis,
  moveSpeed,
  profilePhoto,
  resPath,
  roleID,
  roleName,
  sadAnim: [
    {
      weight,
      animName,
    }
  ],
  serveAnimData: [
    {
      weight,
      animName,
      ballMoveEndHeight: [any],
      ballMoveEndPosOffsetY,
      ballMoveMaxHeight,
      ballMoveTime,
      ballStartXOffset,
      serveName,
    }
  ],
  slidingSpeed,
  uiPath,
}
```
