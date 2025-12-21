# PondFactory

## Schema

```js
PondFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  Type,
  adDesc,
  adIcon,
  adIncome: [
    {
      adPassageMax,
      adPassageMin,
      distance,
      earning: [any],
    }
  ],
  adItem: [
    {
      id,
      num,
    }
  ],
  adName,
  adType,
  advPublicizeList: [
    {
      id,
    }
  ],
  build: [
    {
      id,
      num,
    }
  ],
  dec: [any],
  divide: [any],
  isHighLight,
  item: [
    {
      id,
      num,
    }
  ],
  leafletPublicizeList: [
    {
      id,
    }
  ],
  levelRewardNum,
  lv,
  passengerTagList: [
    {
      id,
      weight,
    }
  ],
  passengerTypeList: [
    {
      id,
      weight,
    }
  ],
  publicizeResources: [
    {
      BtnImg,
      DecBg,
      DecColour,
      PeoplePng,
      TitleBg,
      bg,
    }
  ],
  publicizeType,
  tax: [any],
  ticket,
  type,
  unlockPlace,
  visitorNum,
}
```
