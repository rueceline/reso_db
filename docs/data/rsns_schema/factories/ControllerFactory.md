# ControllerFactory

## Schema

```js
ControllerFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  actionList: [
    {
      actionID,
    }
  ],
  commandList: [
    {
      actionID,
    }
  ],
  effectOffsetX,
  effectOffsetY,
  enemySkillList: [
    {
      skillListId,
    }
  ],
  energyBarColor,
  energyRestorePerFrameSN,
  energySkillList: [
    {
      actionId, // -> UnitActionFactory.id
      isClearEnergy,
      rangeSN,
    }
  ],
  isInvisibleBeforeShowUp,
  isSkillDelay,
  isUseEnergy,
  maxDelay,
  minDelay,
  normalAttackCritID,
  shapeShiftList: [
    {
      controllerID,
      hpPercentSN,
    }
  ],
  showupSkillList: [
    {
      actionId, // -> UnitActionFactory.id
    }
  ],
  skillList: [
    {
      actionId, // -> UnitActionFactory.id
      activeFrame,
      activeTime: [any],
      rangeSN,
    }
  ],
  skillLoopDelayFrame,
  targetInvisibleEffectId, // -> EffectFactory.id
}
```
