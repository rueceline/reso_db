# SourceMaterialFactory

## Schema

```js
SourceMaterialFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  iconPath,
  tipsPath,
  CorrespondingRole,
  EquipItemType,
  Getway: [
    {
      DisplayName,
      FromLevel,
      UIName,
      Way3,
    }
  ],
  addLove,
  breakItemList: [
    {
      id,
      num,
    }
  ],
  breakPath,
  cost,
  dayLove,
  endTime,
  equipExp,
  exp,
  isBreakChange,
  isDisplayInFinishedlWare,
  isDisplayInMaterialWare,
  isNotDisplayInBag,
  petFoodNum,
  petFoodPrice,
  reduceTiredNum,
  rewardList: [
    {
      id,
      num,
    }
  ],
  saletype,
  sort,
  usedPetVarity: [
    {
      id,
    }
  ],
  viewId,
}
```
