# PrisonRoomFactory

## Schema

```js
PrisonRoomFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  bedNum,
  cureTimeList: [
    {
      cureTime,
      illID,
      otherID,
    }
  ],
  detailDesc,
  extraOutput,
  fleetLimited,
  formulaList: [
    {
      id,
    }
  ],
  lowestScore,
  lvUpCost: [
    {
      id,
      num,
    }
  ],
  lvUpGet: [
    {
      id,
      num,
    }
  ],
  occupyPower,
  parolePayParam,
  prisonPower,
  prisonerBackupNum,
  prisonerNum,
  roomDesc,
  roomHygiene,
  roomLevel,
  roomObedience,
  roomPic,
  roomSafety,
  roomStability,
  routeLimited,
  slotNum,
  timeBrig: [
    {
      eventId,
      time,
    }
  ],
  transitGoodsCostList: [
    {
      id,
      num,
    }
  ],
  transitPrisonerCostList: [
    {
      id,
      num,
    }
  ],
  transitTime,
  unlockFormulaList: [
    {
      id,
    }
  ],
  unlockMachineList: [
    {
      id,
    }
  ],
  upgradeTime,
}
```

## Relations

### Suspected
- PrisonRoomFactory.timeBrig[].eventId -> TagFactory.id (hit_ratio=1.000000, gap=1.000000, total=50; total<60)
