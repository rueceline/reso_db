# UIReplaceFactory

## Schema

```js
UIReplaceFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  color,
  defaultId, // -> UIReplaceFactory.id
  imgPath,
  replaceList: [
    {
      pgId, // -> PlaygroundFactory.id
      reId, // -> UIReplaceFactory.id
    }
  ],
  replaceType,
  size,
}
```
