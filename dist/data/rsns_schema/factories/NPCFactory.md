# NPCFactory

## Schema

```js
NPCFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  ItemText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  OneText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  StoreText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  UseItem: [
    {
      id,
      weight,
      reputation,
    }
  ],
  acceptQuestText: [
    {
      id,
      weight,
    }
  ],
  addQuestSuccessText: [
    {
      id,
      weight,
    }
  ],
  animalStoreText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  buyDownText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  buyFlatText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  buySettlementText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  buySuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  buyUpText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  cancelBuyText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  cancelQuestText: [
    {
      id,
      weight,
    }
  ],
  cancelSellText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  cancelSignText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  chooseOrderText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  discardText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  drinkText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  enterExchangeText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  enterOfferText: [any],
  enterRecycleText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  enterSaleText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  enterText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  exchangeSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  fishSellText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  fishStoreText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  goodsSoundList: [
    {
      goodsId, // -> HomeGoodsFactory.id
      soundId, // -> SoundFactory.id
    }
  ],
  haggleFailText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  haggleSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  investFiveText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  investFourText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  investOneText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  investSixText: [any],
  investText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  investThreeText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  investTwoText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  joinOrderText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  levelListText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  notEnoughText: [any],
  notEnterOfferText: [any],
  offsetX,
  offsetY,
  openWarehouseText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  orderSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  petSellText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  petStoreText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  petStuffSellText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  petStuffStoreText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  plantSellText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  plantStoreText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  prisonExchangeText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  prisonMaterialText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  prisonOpenShopText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  prisonOpenWarehouseText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  prisonProductlText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  qResUrl,
  questListNullText: [
    {
      id,
      weight,
    }
  ],
  questListText: [
    {
      id,
      weight,
    }
  ],
  raiseFailText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  raiseSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  recycleSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  refreshOrderText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  resUrl,
  rewardGetText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  saleOutText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  saleSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  sellDownText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  sellFlatText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  sellSettlementText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  sellSuccessText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  sellUpText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  signText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  spineOffsetX: [any],
  spineOffsetY,
  spineScale: [any],
  spineUrl,
  stationSoundList: [
    {
      soundId, // -> SoundFactory.id
      stationId, // -> HomeStationFactory.id
    }
  ],
  tabBattleText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  tabBuyText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  tabOrderText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  tabSellText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  talkText: [
    {
      id,
      weight,
      reputation,
    }
  ],
  upperText: [
    {
      id,
      weight,
      reputation,
    }
  ],
}
```
