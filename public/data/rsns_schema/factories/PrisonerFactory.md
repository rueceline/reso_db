# PrisonerFactory

## Schema

```js
PrisonerFactory = {
  id,
  idCN,
  mod,
  isInformalData,
  des,
  PrisonerAnimation,
  PrisonerSpeciality: [
    {
      id,
      weight,
    }
  ],
  difficultyPr,
  escapePr: [any],
  escapeSuccessPr: [any],
  extraOutputProbability,
  monitor,
  physicalQuality: [any],
  prisonParolePayParam: [any],
  prisonerCost: [
    {
      id,
      num,
    }
  ],
  prisonerIconPath,
  prisonerName,
  prisonerPersonality: [
    {
      id,
      weight,
    }
  ],
  prisonerPicturePath,
  prisonerRarity,
  prisonerSide,
}
```
