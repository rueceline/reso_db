# RandomBattleFactory

## Schema

```js
RandomBattleFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  initEquipList: [
    {
      id,
      lv,
    }
  ],
  initRoleList: [
    {
      id,
      awake,
      break,
      lv,
    }
  ],
  randomBattleLevelList: [
    {
      id,
      dropEquipId, // -> ListFactory.id
      dropEquipLv,
      lv,
    }
  ],
  rewardFinish: [
    {
      id,
      num,
    }
  ],
  ruleDes,
}
```
