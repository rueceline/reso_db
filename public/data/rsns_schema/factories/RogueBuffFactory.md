# RogueBuffFactory

## Schema

```js
RogueBuffFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  iconPath,
  tipsPath,
  buffList: [
    {
      id,
    }
  ],
  correspondingTeam,
  descent,
  effect,
  endTime,
  intensifyDes,
  intensifyEffect,
  intensifyList: [
    {
      id,
      num,
    }
  ],
  isSpecial,
  preSkillList: [
    {
      id,
    }
  ],
  rogueId, // -> CubeRogueFactory.id
  skillEffect,
  startTime,
}
```
