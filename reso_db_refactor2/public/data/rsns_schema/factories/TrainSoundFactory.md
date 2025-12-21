# TrainSoundFactory

## Schema

```js
TrainSoundFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  soundDes,
  soundIcon,
  soundIndex,
  soundName,
  tryListenId,
  unLockCost: [
    {
      id,
      num,
    }
  ],
  voiceArrive: [
    {
      id,
      type,
    }
  ],
  voiceArrivePassenger: [
    {
      id,
      type,
    }
  ],
  voiceDeparture: [
    {
      id,
      type,
    }
  ],
  voiceDeparturePassenger: [
    {
      id,
      type,
    }
  ],
  voiceGetIn: [any],
  voiceGetInPassenger: [any],
  voiceWillArrive: [
    {
      id,
      type,
    }
  ],
  voiceWillArrivePassenger: [
    {
      id,
      type,
    }
  ],
}
```
