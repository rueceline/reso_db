# SigninFactory

## Schema

```js
SigninFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  ENText,
  SigninAwardList: [
    {
      itemid,
      sealPic,
    }
  ],
  SigninRewardList: [
    {
      id,
      pngMan,
      pngWoman,
    }
  ],
  bgPic,
  dailysignInTitle,
  endTime,
  isResident,
  month,
  questId,
  signInTitle,
  signList: [
    {
      id,
      num,
    }
  ],
  startTime,
  totalDays,
  totalSignList: [
    {
      id,
      date,
      num,
    }
  ],
  year,
}
```
