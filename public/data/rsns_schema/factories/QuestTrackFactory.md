# QuestTrackFactory

## Schema

```js
QuestTrackFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  apiList: [
    {
      api,
      note,
    }
  ],
  btnList: [
    {
      btnPath,
      note,
    }
  ],
  keyList: [
    {
      key,
      factoryVal,
      intVal,
      stringVal,
    }
  ],
  stateList: [
    {
      bubbleType,
      mId, // -> CityMapFactory.id
      nodePath,
      note,
      offsetX,
      offsetY,
      prefab,
      stateNo,
      tipsType,
    }
  ],
}
```
