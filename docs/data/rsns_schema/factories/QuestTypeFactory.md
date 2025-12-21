# QuestTypeFactory

## Schema

```js
QuestTypeFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  questList: [
    {
      id,
    }
  ],
  typeList: [
    {
      questListId, // -> QuestTypeFactory.id
      questType,
    }
  ],
}
```
