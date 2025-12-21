# HomeBuffFactory

## Schema

```js
HomeBuffFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  battleBuff,
  buffType,
  continueTime,
  desc,
  endTime,
  formulaType,
  goodsList: [
    {
      id,
    }
  ],
  indexSpeedMax,
  indexSpeedMin,
  indexTrust,
  intensifyDesc,
  intensifyParam: [any],
  listReturn: [
    {
      id,
    }
  ],
  param: [any],
  paramList: [
    {
      probabilityParam: [any],
      programme,
    }
  ],
  probabilityParamClient,
  showIcon,
}
```
