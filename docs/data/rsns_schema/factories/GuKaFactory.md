# GuKaFactory

## Schema

```js
GuKaFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  des,
  iconPath,
  tipsPath,
  HoleList: [
    {
      startX,
      startY,
      xLength,
      yLength,
    }
  ],
  convertItem: [
    {
      id,
      num,
    }
  ],
  gukaImg,
  imgXOffset,
  imgYOffset,
  longDes,
  maxLv,
  skillList: [
    {
      skillId,
    }
  ],
  symbol,
  upgradeCostList: [
    {
      id,
    }
  ],
  x,
  y,
}
```

## Relations

### Suspected
- GuKaFactory.skillList[].skillId -> SkillFactory.id (hit_ratio=1.000000, gap=1.000000, total=40; total<60)
