# HomeCharacterSkinFactory

## Schema

```js
HomeCharacterSkinFactory = {
  id,
  idCN,
  name,
  mod,
  isInformalData,
  quality,
  des,
  iconPath,
  tipsPath,
  character: [
    {
      id,
    }
  ],
  hairList: [
    {
      hairType,
      skinPath,
      spineDataPath,
    }
  ],
  hairType,
  skinPath,
  skinType,
  spineDataPath,
}
```
