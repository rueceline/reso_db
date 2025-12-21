# HomeGoodsFactory

## Schema

```js
HomeGoodsFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  tipsPath,
  Getway: [
    {
      DisplayName,
      FromLevel,
      UIName,
      Way3,
    }
  ],
  costList: [
    {
      id,
      num,
    }
  ],
  fastQuotationVariation,
  goodsType,
  imagePath,
  isDisplayInFinishedlWare,
  isDisplayInMaterialWare,
  isPollution,
  isSpeciality,
  price,
  producerList: [
    {
      id,
    }
  ],
  quotationVariation: [any],
  rewardsList: [
    {
      id,
      num,
    }
  ],
  sort,
  space: [any],
}
```
