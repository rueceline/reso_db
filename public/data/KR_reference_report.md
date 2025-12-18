# KR 데이터 참조 관계 리포트

- 생성일: 2025-12-18 00:00 UTC+09:00
- 대상: KR.zip 내 `KR/*.json` (총 193개 파일)
- 방법: 각 파일의 기본키(대부분 `id`) 집합을 만들고, 다른 필드에서 발견되는 정수 ID들이 어느 파일의 `id` 집합과 가장 많이 겹치는지(매칭 비율)로 추정
- 주의: `ListFactory.json`처럼 '리스트 컨테이너' 성격의 테이블은 **직접 참조(리스트 ID)** + **리스트 내부 항목(다른 테이블 ID)**가 섞여 있어, 2단계(간접 참조)로 보는 게 안전함

## 예시: EquipmentFactory.json
- 레코드 수: 185
- 기본키: `id`
- `growthId`:
  - GrowthFactory.json (매칭 168/169, 99.4%)
- `campTagId`:
  - TagFactory.json (매칭 6/7, 85.7%)
- `skillList`:
  - SkillFactory.json (매칭 177/177, 100.0%)
- `randomSkillList`:
  - ListFactory.json (매칭 19/19, 100.0%)
- `disappearSkillList`:
  - SkillFactory.json (매칭 74/74, 100.0%)

해석(추천):
- `skillList[*].skillId`, `disappearSkillList[*].skillId`는 **SkillFactory.json의 `id`**를 직접 가리킴.
- `randomSkillList[*].skillId`는 값 형태가 8030xxxx로, **ListFactory.json의 `id`(리스트 ID)**에 먼저 매칭됨.
  - 실제 스킬 목록은 `ListFactory.json`의 해당 레코드(예: `id=80300133`) 안에 있는 `*EntryList`의 `id`들이고, 이것들이 다시 SkillFactory / EquipmentFactory 등으로 이어질 수 있음.

## 파일별 참조 추정 결과

### AFKEventFactory.json
- 레코드 수: 499
- 기본키(추정): `id`
- 참조 필드:
  - `LevelBefore` → LevelFactory.json (매칭 6/6, 100.0%)
  - `QuestConditions` → QuestFactory.json (매칭 7/7, 100.0%)
  - `boxRewardList` → ListFactory.json (매칭 20/20, 100.0%)
  - `levelId` → LevelFactory.json (매칭 397/397, 100.0%)
  - `levelList` → LevelFactory.json (매칭 26/26, 100.0%)
  - `levelList2` → ListFactory.json (매칭 8/8, 100.0%)
  - `paragraphId` → ParagraphFactory.json (매칭 5/6, 83.3%)
  - `tag` → TagFactory.json (매칭 5/6, 83.3%)
  - `triggerOrder` → LogicFactory.json (매칭 9/9, 100.0%)

### AbyssFactory.json
- 레코드 수: 165
- 기본키(추정): `id`
- 참조 필드:
  - `abyssPeriodId` → AbyssPeriodFactory.json (매칭 35/36, 97.2%)
  - `levelList` → LevelFactory.json (매칭 320/320, 100.0%)

### AbyssPeriodFactory.json
- 레코드 수: 36
- 기본키(추정): `id`
- 참조 필드:
  - `abyssList` → AbyssFactory.json (매칭 140/140, 100.0%)
  - `starReward` → ListFactory.json (매칭 4/4, 100.0%)

### ActivityFactory.json
- 레코드 수: 79
- 기본키(추정): `id`
- 참조 필드:
  - `PersonalProgressList` → QuestFactory.json (매칭 203/203, 100.0%)
  - `ServerProgressList` → QuestFactory.json (매칭 9/9, 100.0%)
  - `activityCardPack` → CollectionCardPackFactory.json (매칭 12/13, 92.3%)
  - `activityGradeList` → ActivityListFactory.json (매칭 3/3, 100.0%)
  - `activityRankList` → RankFactory.json (매칭 14/14, 100.0%)
  - `activityRewardRankList` → RankFactory.json (매칭 12/12, 100.0%)
  - `activityStoreList` → StoreFactory.json (매칭 14/14, 100.0%)
  - `allConstructionList` → ListFactory.json (매칭 9/11, 81.8%)
  - `allLevyList` → HomeBuffFactory.json (매칭 10/10, 100.0%)
  - `bannerCapsuleList` → ExtractFactory.json (매칭 3/3, 100.0%)
  - `bannerList` → ExtractFactory.json (매칭 3/3, 100.0%)
  - `battleList` → QuestFactory.json (매칭 3/3, 100.0%)
  - `blackLevelList` → LevelFactory.json (매칭 4/4, 100.0%)
  - `bossFinalList` → LevelGroupFactory.json (매칭 4/4, 100.0%)
  - `bossNormalList` → LevelGroupFactory.json (매칭 16/16, 100.0%)
  - `circleTextList` → TextFactory.json (매칭 8/8, 100.0%)
  - `constructionPreviewList` → HomeGoodsFactory.json (매칭 13/13, 100.0%)
  - `endlessLevelList` → LevelFactory.json (매칭 75/75, 100.0%)
  - `giftList` → ValuableFactory.json (매칭 3/3, 100.0%)
  - `goodsList` → HomeGoodsFactory.json (매칭 14/14, 100.0%)
  - `helpId` → ListFactory.json (매칭 16/17, 94.1%)
  - `interviewNpcList` → NPCFactory.json (매칭 4/4, 100.0%)
  - `joinPlotId` → ParagraphFactory.json (매칭 10/11, 90.9%)
  - `joinQuestId` → QuestFactory.json (매칭 9/10, 90.0%)
  - `levelQuestLimit` → QuestFactory.json (매칭 6/7, 85.7%)
  - `levelTypeList` → ActivityListFactory.json (매칭 10/10, 100.0%)
  - `npcId` → NPCFactory.json (매칭 18/19, 94.7%)
  - `personalLevyList` → HomeBuffFactory.json (매칭 10/10, 100.0%)
  - `powerRoleList` → UnitFactory.json (매칭 14/14, 100.0%)
  - `questId` → QuestFactory.json (매칭 10/11, 90.9%)
  - `rankingMail` → MailFactory.json (매칭 12/13, 92.3%)
  - `rankingReward` → ListFactory.json (매칭 12/12, 100.0%)
  - `returnBuffList` → HomeBuffFactory.json (매칭 3/3, 100.0%)
  - `returnRewards` → ItemFactory.json (매칭 5/5, 100.0%)
  - `returnTask` → QuestFactory.json (매칭 36/36, 100.0%)
  - `rewardPreviewList` → ProfilePhotoFactory.json (매칭 60/158, 38.0%) / ItemFactory.json (매칭 34/158, 21.5%)
  - `rewardsList` → ActivityListFactory.json (매칭 10/10, 100.0%)
  - `signBattleExtract` → ExtractFactory.json (매칭 6/7, 85.7%)
  - `signLevelList` → LevelFactory.json (매칭 138/138, 100.0%)
  - `signinId` → SigninFactory.json (매칭 22/22, 100.0%)
  - `skipQuestLimit` → QuestFactory.json (매칭 8/9, 88.9%)
  - `skipStationStart` → HomeStationFactory.json (매칭 6/7, 85.7%)
  - `titleTextList` → TextFactory.json (매칭 6/6, 100.0%)
  - `unlockTips` → TextFactory.json (매칭 12/13, 92.3%)
  - `voiceActivity` → SoundFactory.json (매칭 37/38, 97.4%)

### ActivityListFactory.json
- 레코드 수: 458
- 기본키(추정): `id`
- 참조 필드:
  - `activityGradeList` → HomeBuffFactory.json (매칭 10/10, 100.0%)
  - `activityPassengerList` → HomeStationFactory.json (매칭 13/13, 100.0%)
  - `city` → HomeStationFactory.json (매칭 11/12, 91.7%)
  - `enemyList` → UnitFactory.json (매칭 32/32, 100.0%)
  - `goodsList` → HomeGoodsFactory.json (매칭 128/128, 100.0%)
  - `gradeIncomeList` → HomeBuffFactory.json (매칭 6/6, 100.0%)
  - `levelList` → LevelFactory.json (매칭 77/77, 100.0%)
  - `materialList` → SourceMaterialFactory.json (매칭 10/10, 100.0%)
  - `optionFuncList` → RogueOrderFactory.json (매칭 99/99, 100.0%)
  - `orderUpList` → ManufacturingOrderFactory.json (매칭 99/99, 100.0%)
  - `passengerBufflList` → HomeBuffFactory.json (매칭 11/11, 100.0%)
  - `questList` → QuestFactory.json (매칭 43/43, 100.0%)
  - `recycleCityList` → HomeStationFactory.json (매칭 4/4, 100.0%)
  - `rogueEventList` → RogueEventFactory.json (매칭 251/251, 100.0%)
  - `rogueRefreshList` → RogueBuffFactory.json (매칭 72/142, 50.7%) / RogueEquipmentFactory.json (매칭 70/142, 49.3%)
  - `stationList` → HomeStationFactory.json (매칭 17/17, 100.0%)
  - `typeId` → TagFactory.json (매칭 7/7, 100.0%)

### AdvSkillCardFactory.json
- 레코드 수: 64
- 기본키(추정): `id`
- 참조 필드:
  - `resUrl` → AdvEffectFactory.json (매칭 5/6, 83.3%)

### AdvUnitFactory.json
- 레코드 수: 5
- 기본키(추정): `id`
- 참조 필드:
  - `status` → EnemyStatusFactory.json (매칭 4/4, 100.0%)

### AreaFactory.json
- 레코드 수: 15
- 기본키(추정): `id`
- 참조 필드:
  - `ClickDungeonEventList` → ListFactory.json (매칭 13/13, 100.0%)
  - `ClickEventList` → ListFactory.json (매칭 15/15, 100.0%)
  - `ClickLevelList` → ListFactory.json (매칭 127/127, 100.0%)
  - `LineList` → HomeLineFactory.json (매칭 28/28, 100.0%)
  - `RnWtList` → WeatherFactory.json (매칭 3/3, 100.0%)
  - `polluteLevelList` → ListFactory.json (매칭 144/145, 99.3%)

### BackgroundFactory.json
- 레코드 수: 164
- 기본키(추정): `id`
- 참조 필드:
  - `forbidWeatherList` → WeatherFactory.json (매칭 9/9, 100.0%)

### BattleInfoFactory.json
- 레코드 수: 29
- 기본키(추정): `id`
- 참조 필드:
  - `num0Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num1Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num2Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num3Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num4Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num5Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num6Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num7Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num8Id` → BattleTextFactory.json (매칭 8/8, 100.0%)
  - `num9Id` → BattleTextFactory.json (매칭 8/8, 100.0%)

### BattlePassFactory.json
- 레코드 수: 23
- 기본키(추정): `id`
- 참조 필드:
  - `PassRewardList` → ItemFactory.json (매칭 30/82, 36.6%) / UnitViewFactory.json (매칭 22/82, 26.8%)
  - `bpPrice` → ValuableFactory.json (매칭 42/42, 100.0%)
  - `extraReward` → ItemFactory.json (매칭 53/167, 31.7%) / ProfilePhotoFactory.json (매칭 22/167, 13.2%)
  - `rewardShow` → UnitViewFactory.json (매칭 22/26, 84.6%)
  - `skinThisSeason` → UnitViewFactory.json (매칭 22/22, 100.0%)

### BookFactory.json
- 레코드 수: 19
- 기본키(추정): `id`
- 참조 필드:
  - `affixList` → SkillFactory.json (매칭 140/140, 100.0%)
  - `armamentList` → HomeWeaponFactory.json (매칭 63/63, 100.0%)
  - `entryList` → RogueBuffFactory.json (매칭 92/225, 40.9%) / RogueEquipmentFactory.json (매칭 70/225, 31.1%)
  - `equipmentList` → EquipmentFactory.json (매칭 160/160, 100.0%)
  - `musicList` → SoundFactory.json (매칭 8/8, 100.0%)
  - `pictureList` → PictureFactory.json (매칭 7/7, 100.0%)
  - `profilePhotoList` → ProfilePhotoFactory.json (매칭 925/925, 100.0%)
  - `sourceList` → SourceMaterialFactory.json (매칭 116/116, 100.0%)
  - `stageList` → ListFactory.json (매칭 35/35, 100.0%)
  - `trainSoundList` → TrainSoundFactory.json (매칭 7/7, 100.0%)
  - `unitList` → UnitFactory.json (매칭 242/242, 100.0%)

### BreakthroughFactory.json
- 레코드 수: 745
- 기본키(추정): `id`
- 참조 필드:
  - `materialList` → SourceMaterialFactory.json (매칭 92/92, 100.0%)
  - `skillChangeList` → SkillFactory.json (매칭 37/37, 100.0%)
  - `skillList` → SkillFactory.json (매칭 460/460, 100.0%)
  - `skillParamOffsetList` → SkillFactory.json (매칭 23/24, 95.8%)

### BuffFactory.json
- 레코드 수: 26303
- 기본키(추정): `id`
- 참조 필드:
  - `ActionId` → UnitActionFactory.json (매칭 251/251, 100.0%)
  - `actionId` → UnitActionFactory.json (매칭 15/16, 93.8%)
  - `adjustCostList` → CardFactory.json (매칭 12/12, 100.0%)
  - `appearEffectList` → EffectFactory.json (매칭 120/120, 100.0%)
  - `battleTagIdList` → TagFactory.json (매칭 190/190, 100.0%)
  - `buffType` → BuffTypeFactory.json (매칭 4/5, 80.0%)
  - `buffTypeFO` → BuffTypeFactory.json (매칭 90/91, 98.9%)
  - `cardId` → CardFactory.json (매칭 10/11, 90.9%)
  - `changeActionList` → UnitActionFactory.json (매칭 615/615, 100.0%)
  - `controllerId` → ControllerFactory.json (매칭 38/39, 97.4%)
  - `destinationCardID` → SkillFactory.json (매칭 47/48, 97.9%)
  - `disappearEffectList` → EffectFactory.json (매칭 110/110, 100.0%)
  - `drawCardId` → SkillFactory.json (매칭 114/115, 99.1%)
  - `effectId` → EffectFactory.json (매칭 1070/1071, 99.9%)
  - `effectList` → EffectFactory.json (매칭 33/34, 97.1%)
  - `env` → WeatherFactory.json (매칭 5/6, 83.3%)
  - `envId` → WeatherFactory.json (매칭 36/37, 97.3%)
  - `envList` → WeatherFactory.json (매칭 3/3, 100.0%)
  - `filterBuffTypeFO` → BuffTypeFactory.json (매칭 5/6, 83.3%)
  - `frameEventList` → FrameEventFactory.json (매칭 452/452, 100.0%)
  - `judgeTagId` → TagFactory.json (매칭 19/20, 95.0%)
  - `judgeTagList` → TagFactory.json (매칭 218/218, 100.0%)
  - `leaderId` → LeaderCardConditionFactory.json (매칭 21/22, 95.5%)
  - `list` → UnitFactory.json (매칭 8/9, 88.9%)
  - `logicId` → LogicFactory.json (매칭 23/24, 95.8%)
  - `originalCardID` → SkillFactory.json (매칭 46/47, 97.9%)
  - `randomEffectList` → EffectFactory.json (매칭 39/39, 100.0%)
  - `skillList` → SkillFactory.json (매칭 29/29, 100.0%)
  - `skillParamList` → SkillFactory.json (매칭 31/32, 96.9%)
  - `skinList` → UnitViewFactory.json (매칭 39/39, 100.0%)
  - `sound` → SoundFactory.json (매칭 273/274, 99.6%)
  - `soundId` → SoundFactory.json (매칭 41/42, 97.6%)
  - `summonID` → UnitFactory.json (매칭 116/117, 99.1%)
  - `summonList` → UnitFactory.json (매칭 25/25, 100.0%)
  - `tagList` → TagFactory.json (매칭 175/175, 100.0%)
  - `targetBuffTypeId` → BuffTypeFactory.json (매칭 18/19, 94.7%)
  - `targetTagIds` → TagFactory.json (매칭 25/25, 100.0%)
  - `targetTagList` → TagFactory.json (매칭 127/127, 100.0%)
  - `typeTagList` → TagFactory.json (매칭 47/47, 100.0%)
  - `unit` → UnitFactory.json (매칭 20/21, 95.2%)
  - `unitId` → UnitFactory.json (매칭 19/20, 95.0%)
  - `weather` → WeatherFactory.json (매칭 12/13, 92.3%)
  - `weatherId` → WeatherFactory.json (매칭 10/11, 90.9%)

### BuildingFactory.json
- 레코드 수: 288
- 기본키(추정): `id`
- 참조 필드:
  - `PlaceDesc` → TextFactory.json (매칭 91/91, 100.0%)
  - `RecycleStoreList` → StoreFactory.json (매칭 3/3, 100.0%)
  - `StoreList` → StoreFactory.json (매칭 3/3, 100.0%)
  - `createQuestList` → ListFactory.json (매칭 26/26, 100.0%)
  - `eventList` → QuestFactory.json (매칭 51/105, 48.6%) / ParagraphFactory.json (매칭 38/105, 36.2%)
  - `exchangeStoreList` → StoreFactory.json (매칭 20/20, 100.0%)
  - `exchangeWeaponList` → StoreFactory.json (매칭 7/7, 100.0%)
  - `initialOrderPrisonList` → PrisonProcurementFactory.json (매칭 3/3, 100.0%)
  - `integralRewardList` → ListFactory.json (매칭 8/8, 100.0%)
  - `npcId` → NPCFactory.json (매칭 42/43, 97.7%)
  - `offerQuestList` → LevelFactory.json (매칭 73/130, 56.2%) / UnitFactory.json (매칭 57/130, 43.8%)
  - `passengerTagList` → ListFactory.json (매칭 30/30, 100.0%)
  - `passengerTypeList` → PassageFactory.json (매칭 40/40, 100.0%)
  - `placeType` → TagFactory.json (매칭 92/92, 100.0%)
  - `stationId` → HomeStationFactory.json (매칭 20/21, 95.2%)
  - `triggerPlot` → ParagraphFactory.json (매칭 8/9, 88.9%)
  - `triggerQuest` → QuestFactory.json (매칭 8/9, 88.9%)
  - `visitorTagList` → ListFactory.json (매칭 30/30, 100.0%)
  - `visitorTypeList` → PassageFactory.json (매칭 40/40, 100.0%)

### BulletFactory.json
- 레코드 수: 808
- 기본키(추정): `id`
- 참조 필드:
  - `appearEffectList` → EffectFactory.json (매칭 6/6, 100.0%)
  - `bulletViewId` → BulletViewFactory.json (매칭 402/403, 99.8%)
  - `disappearEffectList` → EffectFactory.json (매칭 22/22, 100.0%)
  - `effectID` → EffectFactory.json (매칭 61/62, 98.4%)
  - `envBuffId` → BuffFactory.json (매칭 25/26, 96.2%)
  - `frameEvent` → FrameEventFactory.json (매칭 19/19, 100.0%)
  - `groundEffectList` → EffectFactory.json (매칭 249/250, 99.6%)
  - `groundSoundId` → SoundFactory.json (매칭 39/40, 97.5%)
  - `hitEffect` → EffectFactory.json (매칭 54/55, 98.2%)
  - `hitSoundId` → SoundFactory.json (매칭 92/93, 98.9%)
  - `suspendView` → BulletViewFactory.json (매칭 14/14, 100.0%)

### CardAIActionFactory.json
- 레코드 수: 18
- 기본키(추정): `id`
- 참조 필드:
  - `findTargetGSId` → LogicFactory.json (매칭 16/16, 100.0%)

### CardAIConditionFactory.json
- 레코드 수: 37
- 기본키(추정): `id`
- 참조 필드:
  - `logicId` → LogicFactory.json (매칭 11/11, 100.0%)

### CardFactory.json
- 레코드 수: 527
- 기본키(추정): `id`
- 참조 필드:
  - `ExActList` → CardAIActionFactory.json (매칭 12/12, 100.0%)
  - `ExCondList` → CardAIConditionFactory.json (매칭 6/7, 85.7%)
  - `actionId` → UnitActionFactory.json (매칭 394/394, 100.0%)
  - `banishBuffId` → BuffFactory.json (매칭 5/6, 83.3%)
  - `cardAIActionList` → CardAIActionFactory.json (매칭 8/9, 88.9%)
  - `createEffectId` → EffectFactory.json (매칭 4/5, 80.0%)
  - `deriveCardList` → SkillFactory.json (매칭 3/3, 100.0%)
  - `discardBuffId` → BuffFactory.json (매칭 23/24, 95.8%)
  - `discardBySkillBuffId` → BuffFactory.json (매칭 4/5, 80.0%)
  - `inhandBuffId` → BuffFactory.json (매칭 13/14, 92.9%)
  - `inhandOverBuffId` → BuffFactory.json (매칭 6/7, 85.7%)
  - `sameCardGroupId` → TagFactory.json (매칭 6/7, 85.7%)
  - `startBuffId` → BuffFactory.json (매칭 263/264, 99.6%)
  - `tagList` → TagFactory.json (매칭 407/407, 100.0%)
  - `tagOutsideList` → TagFactory.json (매칭 5/5, 100.0%)

### ChapterFactory.json
- 레코드 수: 29
- 기본키(추정): `id`
- 참조 필드:
  - `stageInfoList` → LevelFactory.json (매칭 143/143, 100.0%)

### CityMapFactory.json
- 레코드 수: 523
- 기본키(추정): `id`
- 참조 필드:
  - `activityId` → ActivityFactory.json (매칭 6/7, 85.7%)
  - `buildingId` → BuildingFactory.json (매칭 51/52, 98.1%)
  - `dialogId` → ParagraphFactory.json (매칭 169/170, 99.4%)
  - `displayConditionsList` → QuestFactory.json (매칭 290/291, 99.7%)
  - `dungeonId` → ChapterFactory.json (매칭 25/26, 96.2%)
  - `levelId` → LevelFactory.json (매칭 93/94, 98.9%)
  - `npcId` → NPCFactory.json (매칭 79/80, 98.8%)
  - `stationPlace` → HomeStationPlaceFactory.json (매칭 9/10, 90.0%)
  - `textId` → TextFactory.json (매칭 17/18, 94.4%)

### CollectionCardFactory.json
- 레코드 수: 84
- 기본키(추정): `id`
- 참조 필드:
  - `cardTypeId` → TagFactory.json (매칭 6/6, 100.0%)
  - `correspondingPack` → CollectionCardPackFactory.json (매칭 12/12, 100.0%)

### CollectionCardPackFactory.json
- 레코드 수: 12
- 기본키(추정): `id`
- 참조 필드:
  - `otherCardList` → CollectionCardFactory.json (매칭 72/72, 100.0%)
  - `topCard` → CollectionCardFactory.json (매칭 12/12, 100.0%)

### CommodityFactory.json
- 레코드 수: 1788
- 기본키(추정): `id`
- 참조 필드:
  - `commodityItemList` → HomeFurnitureFactory.json (매칭 235/1010, 23.3%) / ItemFactory.json (매칭 187/1010, 18.5%)
  - `furnitureCondition` → HomeFurnitureFactory.json (매칭 6/7, 85.7%)
  - `moneyList` → SourceMaterialFactory.json (매칭 72/127, 56.7%) / ItemFactory.json (매칭 31/127, 24.4%)
  - `recycleItem` → HomeFurnitureFactory.json (매칭 237/302, 78.5%)

### ConfigFactory.json
- 레코드 수: 100
- 기본키(추정): `id`
- 참조 필드:
  - `BattlePassIdList` → BattlePassFactory.json (매칭 21/21, 100.0%)
  - `DropSortList` → ItemFactory.json (매칭 16/16, 100.0%)
  - `EquipTypeList` → TagFactory.json (매칭 3/3, 100.0%)
  - `LoadingTextList` → TextFactory.json (매칭 7/7, 100.0%)
  - `MagazineEnd` → TextFactory.json (매칭 3/3, 100.0%)
  - `OilLevelList` → ListFactory.json (매칭 10/11, 90.9%)
  - `Playerranklist` → ListFactory.json (매칭 9/9, 100.0%)
  - `PlotReviewList` → QuestFactory.json (매칭 7/8, 87.5%)
  - `achieveList` → ListFactory.json (매칭 11/11, 100.0%)
  - `activityMainList` → ActivityFactory.json (매칭 7/7, 100.0%)
  - `activityOperateList` → ActivityFactory.json (매칭 4/4, 100.0%)
  - `activityPlotList` → ActivityFactory.json (매칭 6/6, 100.0%)
  - `activityTimeList` → ActivityFactory.json (매칭 33/34, 97.1%)
  - `adList` → QuestFactory.json (매칭 14/14, 100.0%)
  - `addDrinkNum` → QuestFactory.json (매칭 8/8, 100.0%)
  - `addPeople` → QuestFactory.json (매칭 20/20, 100.0%)
  - `addProfit` → QuestFactory.json (매칭 46/46, 100.0%)
  - `addScore` → QuestFactory.json (매칭 24/24, 100.0%)
  - `addWeight` → QuestFactory.json (매칭 6/6, 100.0%)
  - `allGoldByLevelActivityId` → QuestFactory.json (매칭 5/5, 100.0%)
  - `apRewardList` → ItemFactory.json (매칭 5/6, 83.3%)
  - `aquariumFeed` → QuestFactory.json (매칭 5/5, 100.0%)
  - `arrestPrisonerNum` → QuestFactory.json (매칭 10/10, 100.0%)
  - `awake` → QuestFactory.json (매칭 10/10, 100.0%)
  - `bannerList` → ExtractFactory.json (매칭 65/65, 100.0%)
  - `battleInfoAllyBAList` → BattleInfoFactory.json (매칭 3/3, 100.0%)
  - `battleInfoEnemyBAList` → BattleInfoFactory.json (매칭 3/3, 100.0%)
  - `beatAnyEnemy` → QuestFactory.json (매칭 10/10, 100.0%)
  - `beatAppointBoss` → QuestFactory.json (매칭 5/5, 100.0%)
  - `bindRewardList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `bookCharacterSideEnumList` → TagFactory.json (매칭 9/9, 100.0%)
  - `bookEquipmentEnumList` → TagFactory.json (매칭 6/6, 100.0%)
  - `botanyPlant` → QuestFactory.json (매칭 5/5, 100.0%)
  - `buffCountList` → TagFactory.json (매칭 44/88, 50.0%) / BuffFactory.json (매칭 44/88, 50.0%)
  - `buildList` → HomeCoachFactory.json (매칭 6/6, 100.0%)
  - `buyElectricList` → ListFactory.json (매칭 20/20, 100.0%)
  - `buyItem` → QuestFactory.json (매칭 13/13, 100.0%)
  - `cardPackList` → CollectionCardPackFactory.json (매칭 12/12, 100.0%)
  - `carriageBuild` → QuestFactory.json (매칭 8/8, 100.0%)
  - `characterList` → VolleyballCharacterFactory.json (매칭 10/10, 100.0%)
  - `coachTypeList` → TagFactory.json (매칭 3/3, 100.0%)
  - `collectParkSeal` → QuestFactory.json (매칭 5/5, 100.0%)
  - `collisionAngleList` → ListFactory.json (매칭 5/5, 100.0%)
  - `commonRareList` → TagFactory.json (매칭 5/5, 100.0%)
  - `coreList` → EngineCoreFactory.json (매칭 5/5, 100.0%)
  - `coreLvUp` → QuestFactory.json (매칭 18/18, 100.0%)
  - `coretypeList` → EngineCoreFactory.json (매칭 5/5, 100.0%)
  - `createTypeList` → TagFactory.json (매칭 3/3, 100.0%)
  - `dailyQuestList` → QuestFactory.json (매칭 9/9, 100.0%)
  - `dayLog` → QuestFactory.json (매칭 7/7, 100.0%)
  - `decorate` → QuestFactory.json (매칭 7/7, 100.0%)
  - `defaultConcealList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `dialog` → QuestFactory.json (매칭 4/4, 100.0%)
  - `dressTypeOrder` → TagFactory.json (매칭 8/8, 100.0%)
  - `eatBento` → QuestFactory.json (매칭 8/8, 100.0%)
  - `elecLevelUp` → QuestFactory.json (매칭 6/6, 100.0%)
  - `electricList` → ListFactory.json (매칭 100/101, 99.0%)
  - `enemyCampEnumList` → TagFactory.json (매칭 5/5, 100.0%)
  - `enemyEnumSideList` → TagFactory.json (매칭 26/26, 100.0%)
  - `enemyStrengthEnumList` → TagFactory.json (매칭 3/3, 100.0%)
  - `energyItemList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `enterCity` → QuestFactory.json (매칭 7/7, 100.0%)
  - `entertain` → QuestFactory.json (매칭 8/8, 100.0%)
  - `entrustList` → EntrustFactory.json (매칭 5/5, 100.0%)
  - `enumJobList` → TagFactory.json (매칭 3/3, 100.0%)
  - `enumSideList` → TagFactory.json (매칭 10/10, 100.0%)
  - `environmentList` → ListFactory.json (매칭 6/6, 100.0%)
  - `expList` → ListFactory.json (매칭 8/9, 88.9%)
  - `expSourceMaterialList` → SourceMaterialFactory.json (매칭 4/4, 100.0%)
  - `favorItemList` → SourceMaterialFactory.json (매칭 10/10, 100.0%)
  - `filmList` → QuestFactory.json (매칭 5/5, 100.0%)
  - `finishOrder` → QuestFactory.json (매칭 8/8, 100.0%)
  - `finishPark` → QuestFactory.json (매칭 6/6, 100.0%)
  - `finishParkByTicket` → QuestFactory.json (매칭 9/9, 100.0%)
  - `finishParkCarEvent` → QuestFactory.json (매칭 3/3, 100.0%)
  - `finishRogue` → QuestFactory.json (매칭 12/12, 100.0%)
  - `finishRogueSuc` → QuestFactory.json (매칭 31/31, 100.0%)
  - `floorTypeList` → TagFactory.json (매칭 5/5, 100.0%)
  - `foodItemList` → SourceMaterialFactory.json (매칭 3/3, 100.0%)
  - `frjLevel` → QuestFactory.json (매칭 9/9, 100.0%)
  - `gacha` → QuestFactory.json (매칭 3/3, 100.0%)
  - `getAnyCharacter` → QuestFactory.json (매칭 10/10, 100.0%)
  - `guideList` → GuideFactory.json (매칭 200/237, 84.4%)
  - `haveArea` → QuestFactory.json (매칭 5/5, 100.0%)
  - `haveFurniture` → QuestFactory.json (매칭 72/72, 100.0%)
  - `homeEnergyItemList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `hyOrderNum` → QuestFactory.json (매칭 20/20, 100.0%)
  - `initCoachList` → HomeCoachFactory.json (매칭 4/4, 100.0%)
  - `initialOrderList` → ManufacturingOrderFactory.json (매칭 6/6, 100.0%)
  - `invest` → QuestFactory.json (매칭 22/22, 100.0%)
  - `inviteRewardList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `itemCost` → QuestFactory.json (매칭 17/17, 100.0%)
  - `leafletEnd` → TextFactory.json (매칭 3/3, 100.0%)
  - `levelMaxGoldByLevelId` → QuestFactory.json (매칭 5/5, 100.0%)
  - `lineList` → HomeLineFactory.json (매칭 44/44, 100.0%)
  - `loseReowrd` → ItemFactory.json (매칭 3/3, 100.0%)
  - `mainStoreList` → ListFactory.json (매칭 8/8, 100.0%)
  - `manufacture` → QuestFactory.json (매칭 24/24, 100.0%)
  - `manufactureLevel` → QuestFactory.json (매칭 6/6, 100.0%)
  - `materialLevelGroupList` → LevelGroupFactory.json (매칭 16/16, 100.0%)
  - `materialOrderNum` → QuestFactory.json (매칭 6/6, 100.0%)
  - `monsterList` → TagFactory.json (매칭 6/6, 100.0%)
  - `normalCarriageList` → TagFactory.json (매칭 5/5, 100.0%)
  - `onceProfit` → QuestFactory.json (매칭 29/29, 100.0%)
  - `openBuildingList` → BuildingFactory.json (매칭 8/8, 100.0%)
  - `openCityList` → HomeStationFactory.json (매칭 10/10, 100.0%)
  - `oviceOrderList` → ListFactory.json (매칭 12/12, 100.0%)
  - `parkGukaOwn` → QuestFactory.json (매칭 3/3, 100.0%)
  - `passAnyBuoyLevel` → QuestFactory.json (매칭 3/3, 100.0%)
  - `passAnyDangerLevel` → QuestFactory.json (매칭 5/5, 100.0%)
  - `passAnyLevel` → QuestFactory.json (매칭 24/24, 100.0%)
  - `passAnySafeLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `passAnyTowerLevel` → QuestFactory.json (매칭 8/8, 100.0%)
  - `passAnyTwigLevel` → QuestFactory.json (매칭 3/3, 100.0%)
  - `passBattleLevelAll` → QuestFactory.json (매칭 7/7, 100.0%)
  - `passByLevelIdGradeDifficult` → QuestFactory.json (매칭 5/5, 100.0%)
  - `passBylevelId` → QuestFactory.json (매칭 397/398, 99.7%)
  - `passKabaneriLevel` → QuestFactory.json (매칭 25/25, 100.0%)
  - `passSafeLevelAll` → QuestFactory.json (매칭 6/6, 100.0%)
  - `passSafeLevelLimitCity` → QuestFactory.json (매칭 3/3, 100.0%)
  - `passSafeSideLevelLimitPool` → QuestFactory.json (매칭 24/24, 100.0%)
  - `passengerLevel` → QuestFactory.json (매칭 6/6, 100.0%)
  - `petFeed` → QuestFactory.json (매칭 5/5, 100.0%)
  - `petPersonalityList` → TagFactory.json (매칭 9/9, 100.0%)
  - `petVarityList` → TagFactory.json (매칭 9/9, 100.0%)
  - `polluteAreaList` → AreaFactory.json (매칭 15/15, 100.0%)
  - `polluteBalloonList` → ListFactory.json (매칭 13/13, 100.0%)
  - `polluteRegularList` → ListFactory.json (매칭 11/11, 100.0%)
  - `priceDownWin` → QuestFactory.json (매칭 5/5, 100.0%)
  - `priceUpWin` → QuestFactory.json (매칭 5/5, 100.0%)
  - `prisonCanteenLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonCellNum` → QuestFactory.json (매칭 5/5, 100.0%)
  - `prisonDWLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonExerciseLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonFRLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonMedicalLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonPersonalityNameList` → TagFactory.json (매칭 13/13, 100.0%)
  - `prisonPowerLevel` → QuestFactory.json (매칭 11/11, 100.0%)
  - `prisonProduceMaterialNum` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonProduceNum` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonPunishLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonRZLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonReleaseLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonRoomNum` → QuestFactory.json (매칭 4/4, 100.0%)
  - `prisonSecurityLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonShopLevel` → QuestFactory.json (매칭 11/11, 100.0%)
  - `prisonSpaceNum` → QuestFactory.json (매칭 4/4, 100.0%)
  - `prisonTransitFleetNum` → QuestFactory.json (매칭 5/5, 100.0%)
  - `prisonTransitLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonVisitLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonWarehouseCPNum` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonWarehouseYLNum` → QuestFactory.json (매칭 10/10, 100.0%)
  - `prisonWorkshopNum` → QuestFactory.json (매칭 5/5, 100.0%)
  - `prisonZWLevel` → QuestFactory.json (매칭 10/10, 100.0%)
  - `productionFurnitureList` → TagFactory.json (매칭 6/6, 100.0%)
  - `protectCountList` → TagFactory.json (매칭 22/22, 100.0%)
  - `publicize` → QuestFactory.json (매칭 6/6, 100.0%)
  - `putPrisonerInNum` → QuestFactory.json (매칭 10/10, 100.0%)
  - `questList` → QuestFactory.json (매칭 40/40, 100.0%)
  - `rateBento` → TextFactory.json (매칭 5/5, 100.0%)
  - `refreshGoods` → QuestFactory.json (매칭 6/7, 85.7%)
  - `resonance` → QuestFactory.json (매칭 16/16, 100.0%)
  - `rewardsList` → ItemFactory.json (매칭 9/11, 81.8%)
  - `roleGrade` → QuestFactory.json (매칭 36/36, 100.0%)
  - `roleList` → UnitFactory.json (매칭 3/3, 100.0%)
  - `sellItem` → QuestFactory.json (매칭 13/13, 100.0%)
  - `sellItemProfit` → QuestFactory.json (매칭 18/18, 100.0%)
  - `sellItemServer` → QuestFactory.json (매칭 9/9, 100.0%)
  - `serverStoreList` → StoreFactory.json (매칭 4/4, 100.0%)
  - `skinItemList` → ItemFactory.json (매칭 62/62, 100.0%)
  - `slowDownList` → ListFactory.json (매칭 20/21, 95.2%)
  - `speedUpList` → ListFactory.json (매칭 20/21, 95.2%)
  - `stationList` → HomeStationFactory.json (매칭 32/32, 100.0%)
  - `storeMainList` → StoreFactory.json (매칭 3/3, 100.0%)
  - `storyQuestChapterList` → ListFactory.json (매칭 3/3, 100.0%)
  - `strengthenEquipment` → QuestFactory.json (매칭 16/16, 100.0%)
  - `studyList` → TrainSkinStudyFactory.json (매칭 15/15, 100.0%)
  - `teamList` → UnitFactory.json (매칭 3/3, 100.0%)
  - `teamOrderList` → ManufacturingOrderFactory.json (매칭 22/22, 100.0%)
  - `trade` → QuestFactory.json (매칭 5/5, 100.0%)
  - `tradeLevel` → QuestFactory.json (매칭 6/6, 100.0%)
  - `trailerUpgradeCost` → ListFactory.json (매칭 100/100, 100.0%)
  - `trainList` → ListFactory.json (매칭 35/35, 100.0%)
  - `trainMaintain` → QuestFactory.json (매칭 5/5, 100.0%)
  - `trainRemould` → QuestFactory.json (매칭 5/5, 100.0%)
  - `trainRepair` → QuestFactory.json (매칭 5/5, 100.0%)
  - `trainWash` → QuestFactory.json (매칭 5/5, 100.0%)
  - `trainWeaponTypeList` → TagFactory.json (매칭 8/8, 100.0%)
  - `travel` → QuestFactory.json (매칭 14/14, 100.0%)
  - `tvEnd` → TextFactory.json (매칭 3/3, 100.0%)
  - `typeConstantList` → TagFactory.json (매칭 8/8, 100.0%)
  - `upGradeTrainWeapon` → QuestFactory.json (매칭 5/5, 100.0%)
  - `useParkBroom` → QuestFactory.json (매칭 3/3, 100.0%)
  - `useParkCoinInOneGame` → QuestFactory.json (매칭 4/4, 100.0%)
  - `useParkItem` → QuestFactory.json (매칭 3/3, 100.0%)
  - `volleyballGame` → QuestFactory.json (매칭 6/6, 100.0%)
  - `winReowrd` → ItemFactory.json (매칭 3/3, 100.0%)

### ControllerFactory.json
- 레코드 수: 667
- 기본키(추정): `id`
- 참조 필드:
  - `actionList` → UnitActionFactory.json (매칭 628/628, 100.0%)
  - `commandList` → UnitActionFactory.json (매칭 83/83, 100.0%)
  - `enemySkillList` → ListFactory.json (매칭 5/5, 100.0%)
  - `energySkillList` → UnitActionFactory.json (매칭 147/147, 100.0%)
  - `normalAttackCritID` → UnitActionFactory.json (매칭 7/8, 87.5%)
  - `showupSkillList` → UnitActionFactory.json (매칭 178/178, 100.0%)
  - `skillList` → UnitActionFactory.json (매칭 515/515, 100.0%)

### CubeRogueFactory.json
- 레코드 수: 22
- 기본키(추정): `id`
- 참조 필드:
  - `bookTypeList` → BookFactory.json (매칭 5/5, 100.0%)
  - `cubeList` → ActivityListFactory.json (매칭 42/43, 97.7%)
  - `descentBuffList` → RogueBuffFactory.json (매칭 16/16, 100.0%)
  - `extraGetList` → ItemFactory.json (매칭 6/6, 100.0%)
  - `museSkill` → ListFactory.json (매칭 21/22, 95.5%)
  - `planeSkill` → ListFactory.json (매칭 21/22, 95.5%)
  - `rogueTeamList` → RogueTeamFactory.json (매칭 6/6, 100.0%)
  - `skillList` → RogueBuffFactory.json (매칭 30/30, 100.0%)
  - `slideSoundList` → SoundFactory.json (매칭 3/3, 100.0%)
  - `typeLimitList` → TagFactory.json (매칭 7/7, 100.0%)

### DataFactory.json
- 레코드 수: 75
- 기본키(추정): `id`
- 참조 필드:
  - `from` → ListFactory.json (매칭 4/4, 100.0%)

### DictionaryFactory.json
- 레코드 수: 2
- 기본키(추정): `id`
- 참조 필드:
  - `Control` → TagFactory.json (매칭 15/15, 100.0%)
  - `Defence` → TagFactory.json (매칭 7/7, 100.0%)
  - `Technical` → TagFactory.json (매칭 31/31, 100.0%)

### EffectFactory.json
- 레코드 수: 8735
- 기본키(추정): `id`
- 참조 필드:
  - `soundId` → SoundFactory.json (매칭 3/3, 100.0%)

### EnemyGroupFactory.json
- 레코드 수: 5
- 기본키(추정): `id`
- 참조 필드:
  - `enemys` → AdvUnitFactory.json (매칭 4/4, 100.0%)

### EnemyStatusFactory.json
- 레코드 수: 8
- 기본키(추정): `id`
- 참조 필드:
  - `weaponid` → EnemyWeaponFactory.json (매칭 7/7, 100.0%)

### EnemyWaveFactory.json
- 레코드 수: 4193
- 기본키(추정): `id`
- 참조 필드:
  - `dropTableList` → ListFactory.json (매칭 763/763, 100.0%)
  - `effectBeforeBattleId` → EffectFactory.json (매칭 6/7, 85.7%)
  - `enemyList` → UnitFactory.json (매칭 944/997, 94.7%)
  - `finishGuildanceList` → GuildanceFactory.json (매칭 126/126, 100.0%)
  - `goingGuildanceList` → GuildanceFactory.json (매칭 20/20, 100.0%)
  - `startGuildanceList` → GuildanceFactory.json (매칭 10/10, 100.0%)

### EnemyWeaponFactory.json
- 레코드 수: 15
- 기본키(추정): `id`
- 참조 필드:
  - `bulletid` → AdvBulletFactory.json (매칭 5/6, 83.3%)

### EngineCoreFactory.json
- 레코드 수: 14
- 기본키(추정): `id`
- 참조 필드:
  - `battleName` → TextFactory.json (매칭 13/13, 100.0%)
  - `battleNum` → TextFactory.json (매칭 13/13, 100.0%)
  - `challengeTips` → TextFactory.json (매칭 13/13, 100.0%)
  - `coreExpList` → ListFactory.json (매칭 27/28, 96.4%)
  - `coreLevelList` → UnitFactory.json (매칭 32/64, 50.0%) / LevelFactory.json (매칭 32/64, 50.0%)
  - `mvpNum` → TextFactory.json (매칭 13/13, 100.0%)
  - `name` → TextFactory.json (매칭 13/13, 100.0%)
  - `nameEN` → TextFactory.json (매칭 13/13, 100.0%)
  - `record` → TextFactory.json (매칭 13/13, 100.0%)
  - `rewardDes` → TextFactory.json (매칭 13/13, 100.0%)
  - `settlementNum` → TextFactory.json (매칭 13/13, 100.0%)

### EntrustFactory.json
- 레코드 수: 5
- 기본키(추정): `id`
- 참조 필드:
  - `recommendSideList` → TagFactory.json (매칭 5/5, 100.0%)
  - `rewardList` → SourceMaterialFactory.json (매칭 4/5, 80.0%)

### EquipmentFactory.json
- 레코드 수: 185
- 기본키(추정): `id`
- 참조 필드:
  - `campTagId` → TagFactory.json (매칭 6/7, 85.7%)
  - `disappearSkillList` → SkillFactory.json (매칭 74/74, 100.0%)
  - `growthId` → GrowthFactory.json (매칭 168/169, 99.4%)
  - `randomSkillList` → ListFactory.json (매칭 19/19, 100.0%)
  - `skillList` → SkillFactory.json (매칭 177/177, 100.0%)

### ExtractFactory.json
- 레코드 수: 75
- 기본키(추정): `id`
- 참조 필드:
  - `anecdoteQuestId` → QuestFactory.json (매칭 10/11, 90.9%)
  - `btnList` → UnitFactory.json (매칭 51/51, 100.0%)
  - `capsuleList` → HomeFurnitureFactory.json (매칭 31/97, 32.0%) / ItemFactory.json (매칭 20/97, 20.6%)
  - `costList` → ItemFactory.json (매칭 17/17, 100.0%)
  - `costTenList` → ItemFactory.json (매칭 17/17, 100.0%)
  - `goldenList` → ItemFactory.json (매칭 6/6, 100.0%)
  - `newNormalList` → ListFactory.json (매칭 57/57, 100.0%)
  - `protectTag` → TagFactory.json (매칭 12/13, 92.3%)
  - `tenList` → UnitFactory.json (매칭 18/18, 100.0%)
  - `tryList` → LevelFactory.json (매칭 53/53, 100.0%)
  - `upList` → UnitFactory.json (매칭 51/51, 100.0%)

### FoodFactory.json
- 레코드 수: 67
- 기본키(추정): `id`
- 참조 필드:
  - `battleBuffDes` → TextFactory.json (매칭 6/7, 85.7%)
  - `battleBuffList` → HomeBuffFactory.json (매칭 92/92, 100.0%)
  - `memberTrust` → UnitFactory.json (매칭 87/87, 100.0%)
  - `performFurnitureList` → HomeFurnitureFactory.json (매칭 4/4, 100.0%)
  - `rewards` → SourceMaterialFactory.json (매칭 3/3, 100.0%)

### FormulaFactory.json
- 레코드 수: 300
- 기본키(추정): `id`
- 참조 필드:
  - `added` → HomeGoodsFactory.json (매칭 70/101, 69.3%)
  - `composeCondition` → ItemFactory.json (매칭 3/3, 100.0%)
  - `draw` → HomeGoodsFactory.json (매칭 70/104, 67.3%)
  - `drawForm` → HomeGoodsFactory.json (매칭 78/108, 72.2%)
  - `drawingItem` → ProductionFactory.json (매칭 99/99, 100.0%)
  - `unlockenergyCondition` → EngineCoreFactory.json (매칭 5/5, 100.0%)

### FrameEventFactory.json
- 레코드 수: 3474
- 기본키(추정): `id`
- 참조 필드:
  - `buffFO` → BuffFactory.json (매칭 4/5, 80.0%)
  - `buffId` → BuffFactory.json (매칭 3127/3128, 100.0%)
  - `bulletId` → BulletFactory.json (매칭 648/649, 99.8%)
  - `hitSoundID` → SoundFactory.json (매칭 29/30, 96.7%)
  - `targetTagList` → TagFactory.json (매칭 4/4, 100.0%)

### GuKaFactory.json
- 레코드 수: 41
- 기본키(추정): `id`
- 참조 필드:
  - `skillList` → SkillFactory.json (매칭 40/40, 100.0%)
  - `upgradeCostList` → ListFactory.json (매칭 9/9, 100.0%)

### GuideFactory.json
- 레코드 수: 217
- 기본키(추정): `id`
- 참조 필드:
  - `completeQuest` → QuestFactory.json (매칭 47/48, 97.9%)
  - `levelFinishedFO` → LevelFactory.json (매칭 6/7, 85.7%)
  - `levelId` → LevelFactory.json (매칭 4/5, 80.0%)
  - `orderList` → GuideOrderFactory.json (매칭 1045/1045, 100.0%)
  - `reachStation` → HomeStationFactory.json (매칭 6/7, 85.7%)

### GuideOrderFactory.json
- 레코드 수: 1138
- 기본키(추정): `id`
- 참조 필드:
  - `furnitureId` → HomeFurnitureFactory.json (매칭 3/3, 100.0%)
  - `paragraphId` → ParagraphFactory.json (매칭 83/83, 100.0%)
  - `questId` → QuestFactory.json (매칭 10/10, 100.0%)
  - `roleList` → LevelRoleFactory.json (매칭 5/5, 100.0%)
  - `soundId` → SoundFactory.json (매칭 201/202, 99.5%)
  - `unitId` → UnitFactory.json (매칭 3/3, 100.0%)

### GuildanceConditionFactory.json
- 레코드 수: 75
- 기본키(추정): `id`
- 참조 필드:
  - `cardList` → CardFactory.json (매칭 22/22, 100.0%)

### GuildanceFactory.json
- 레코드 수: 354
- 기본키(추정): `id`
- 참조 필드:
  - `conditionList` → GuildanceConditionFactory.json (매칭 48/48, 100.0%)
  - `orderList` → GuildanceOrderFactory.json (매칭 549/549, 100.0%)

### GuildanceOrderFactory.json
- 레코드 수: 670
- 기본키(추정): `id`
- 참조 필드:
  - `actionId` → UnitActionFactory.json (매칭 5/5, 100.0%)
  - `buff` → BuffFactory.json (매칭 44/44, 100.0%)
  - `guildanceID` → GuildanceFactory.json (매칭 156/156, 100.0%)
  - `paragraphID` → ParagraphFactory.json (매칭 167/168, 99.4%)
  - `soundId` → SoundFactory.json (매칭 71/72, 98.6%)
  - `targetId` → CardFactory.json (매칭 17/18, 94.4%)
  - `targetTagList` → TagFactory.json (매칭 11/11, 100.0%)

### HomeBuffFactory.json
- 레코드 수: 187
- 기본키(추정): `id`
- 참조 필드:
  - `battleBuff` → SkillFactory.json (매칭 89/89, 100.0%)
  - `listReturn` → LevelFactory.json (매칭 16/16, 100.0%)

### HomeCharacterFactory.json
- 레코드 수: 355
- 기본키(추정): `id`
- 참조 필드:
  - `Favorability` → ItemFactory.json (매칭 3/3, 100.0%)
  - `PetExpSourceMaterialList` → SourceMaterialFactory.json (매칭 4/4, 100.0%)
  - `characteristicList` → TagFactory.json (매칭 21/21, 100.0%)
  - `chatGroupList` → HomeChatBubbleFactory.json (매칭 4/4, 100.0%)
  - `favoriteCharacterList` → UnitFactory.json (매칭 50/50, 100.0%)
  - `petID` → PetFactory.json (매칭 50/51, 98.0%)
  - `speakDefaultList` → HomeChatBubbleFactory.json (매칭 21/21, 100.0%)
  - `upgradeList` → PetUpgradeFactory.json (매칭 6/6, 100.0%)

### HomeCharacterSkinFactory.json
- 레코드 수: 275
- 기본키(추정): `id`
- 참조 필드:
  - `skinType` → TagFactory.json (매칭 10/10, 100.0%)

### HomeChatBubbleFactory.json
- 레코드 수: 38
- 기본키(추정): `id`
- 참조 필드:
  - `chatList` → HomeChatContentFactory.json (매칭 132/132, 100.0%)
  - `chatSpecifyList` → HomeCharacterFactory.json (매칭 10/10, 100.0%)

### HomeCoachFactory.json
- 레코드 수: 27
- 기본키(추정): `id`
- 참조 필드:
  - `coachType` → TagFactory.json (매칭 7/7, 100.0%)
  - `defaultFloor` → HomeFurnitureFactory.json (매칭 14/15, 93.3%)
  - `defaultSkin` → HomeCoachSkinFactory.json (매칭 5/5, 100.0%)
  - `defaultTemplate` → HomeTemplateFactory.json (매칭 18/19, 94.7%)
  - `defaultWallPaper` → HomeFurnitureFactory.json (매칭 13/14, 92.9%)
  - `skinList` → HomeCoachSkinFactory.json (매칭 257/257, 100.0%)
  - `weaponTypeList` → ListFactory.json (매칭 3/3, 100.0%)

### HomeCoachSkinFactory.json
- 레코드 수: 367
- 기본키(추정): `id`
- 참조 필드:
  - `TBUnit` → TrainBattleUnitFactory.json (매칭 9/10, 90.0%)
  - `coachType` → TagFactory.json (매칭 6/6, 100.0%)
  - `jetEffect` → EffectFactory.json (매칭 8/9, 88.9%)
  - `normalEntryList` → TrainWeaponSkillFactory.json (매칭 88/88, 100.0%)
  - `produceMaterialList` → ItemFactory.json (매칭 62/62, 100.0%)
  - `skinItem` → ItemFactory.json (매칭 61/62, 98.4%)
  - `skinTag` → TagFactory.json (매칭 62/63, 98.4%)
  - `study` → TrainSkinStudyFactory.json (매칭 14/15, 93.3%)
  - `visualAngle` → ConfigFactory.json (매칭 8/9, 88.9%)

### HomeFurnitureFactory.json
- 레코드 수: 794
- 기본키(추정): `id`
- 참조 필드:
  - `FemaleFurnitureSkin` → HomeFurnitureSkinFactory.json (매칭 13/14, 92.9%)
  - `FurnitureSkillList` → HomeFurnitureSkillFactory.json (매칭 136/136, 100.0%)
  - `SkinList` → HomeFurnitureSkinFactory.json (매칭 3/3, 100.0%)
  - `defaultSkin` → HomeFurnitureSkinFactory.json (매칭 659/659, 100.0%)
  - `formulaGroup` → ProductionFactory.json (매칭 138/138, 100.0%)
  - `functionType` → TagFactory.json (매칭 14/15, 93.3%)
  - `manufactureType` → TagFactory.json (매칭 6/7, 85.7%)
  - `type` → TagFactory.json (매칭 18/18, 100.0%)
  - `upgradeCostList` → SourceMaterialFactory.json (매칭 29/33, 87.9%)

### HomeFurnitureSkinFactory.json
- 레코드 수: 680
- 기본키(추정): `id`
- 참조 필드:
  - `tagList` → TagFactory.json (매칭 6/6, 100.0%)

### HomeGoodsFactory.json
- 레코드 수: 335
- 기본키(추정): `id`
- 참조 필드:
  - `goodsType` → TagFactory.json (매칭 19/20, 95.0%)
  - `producerList` → HomeStationFactory.json (매칭 24/24, 100.0%)

### HomeGoodsQuotationFactory.json
- 레코드 수: 7286
- 기본키(추정): `id`
- 참조 필드:
  - `goodsId` → HomeGoodsFactory.json (매칭 242/242, 100.0%)

### HomeLineFactory.json
- 레코드 수: 46
- 기본키(추정): `id`
- 참조 필드:
  - `AreaTipList` → TextFactory.json (매칭 23/23, 100.0%)
  - `AttractionList` → ParagraphFactory.json (매칭 13/13, 100.0%)
  - `LineWeatherList` → WeatherFactory.json (매칭 9/9, 100.0%)
  - `areaList` → AreaFactory.json (매칭 15/15, 100.0%)
  - `bgmId` → SoundFactory.json (매칭 13/13, 100.0%)
  - `boxList` → AFKEventFactory.json (매칭 4/4, 100.0%)
  - `forceNeedleList` → AFKEventFactory.json (매칭 5/5, 100.0%)
  - `lineBgList` → BackgroundFactory.json (매칭 64/64, 100.0%)
  - `lineLevelList` → ListFactory.json (매칭 61/61, 100.0%)
  - `lineMsg` → TrainRoadMsgFactory.json (매칭 10/10, 100.0%)
  - `mapNeedleList` → MapNeedleFactory.json (매칭 28/28, 100.0%)
  - `station01` → HomeStationFactory.json (매칭 22/22, 100.0%)
  - `station02` → HomeStationFactory.json (매칭 25/25, 100.0%)

### HomeSkillFactory.json
- 레코드 수: 269
- 기본키(추정): `id`
- 참조 필드:
  - `city` → HomeStationFactory.json (매칭 16/17, 94.1%)
  - `goodsList` → HomeGoodsFactory.json (매칭 47/47, 100.0%)
  - `tagId` → TagFactory.json (매칭 4/5, 80.0%)

### HomeStationFactory.json
- 레코드 수: 38
- 기본키(추정): `id`
- 참조 필드:
  - `acquisitionList` → HomeGoodsQuotationFactory.json (매칭 5126/5126, 100.0%)
  - `barStoreList` → StoreFactory.json (매칭 8/8, 100.0%)
  - `battleLevelList` → LevelFactory.json (매칭 206/226, 91.2%)
  - `cityLeafletLest` → ListFactory.json (매칭 92/92, 100.0%)
  - `cityLeafletList` → BuildingFactory.json (매칭 92/92, 100.0%)
  - `cityStateList` → CityMapFactory.json (매칭 47/72, 65.3%)
  - `cocStoreList` → StoreFactory.json (매칭 16/16, 100.0%)
  - `constructStageList` → ListFactory.json (매칭 22/22, 100.0%)
  - `correspondingConstruction` → ItemFactory.json (매칭 11/12, 91.7%)
  - `createOrderList` → ListFactory.json (매칭 55/55, 100.0%)
  - `exchangeStoreList` → StoreFactory.json (매칭 5/5, 100.0%)
  - `force` → TagFactory.json (매칭 9/10, 90.0%)
  - `investList` → ListFactory.json (매칭 40/40, 100.0%)
  - `investRankBuffList` → HomeSkillFactory.json (매칭 4/4, 100.0%)
  - `keepSingleMealList` → FoodFactory.json (매칭 3/3, 100.0%)
  - `keepTeamMealList` → FoodFactory.json (매칭 4/4, 100.0%)
  - `lockStationQuestList` → QuestFactory.json (매칭 10/10, 100.0%)
  - `materialRecycleList` → SourceMaterialFactory.json (매칭 97/99, 98.0%)
  - `nameId` → TextFactory.json (매칭 21/23, 91.3%)
  - `petRecycleStoreList` → StoreFactory.json (매칭 4/4, 100.0%)
  - `petStoreList` → StoreFactory.json (매칭 4/4, 100.0%)
  - `pullOutTimeLineList` → TimeLineFactory.json (매칭 5/5, 100.0%)
  - `questId` → QuestFactory.json (매칭 12/13, 92.3%)
  - `repRewardList` → ListFactory.json (매칭 200/201, 99.5%)
  - `sellList` → HomeGoodsQuotationFactory.json (매칭 187/187, 100.0%)
  - `timeLineList` → TimeLineFactory.json (매칭 6/6, 100.0%)
  - `trainHelpChat` → ParagraphFactory.json (매칭 9/9, 100.0%)
  - `trainList` → ListFactory.json (매칭 6/6, 100.0%)

### HomeStationPlaceFactory.json
- 레코드 수: 13
- 기본키(추정): `id`
- 참조 필드:
  - `keepSingleMealList` → FoodFactory.json (매칭 24/24, 100.0%)
  - `keepTeamMealList` → FoodFactory.json (매칭 27/27, 100.0%)
  - `npcList` → HomeCharacterFactory.json (매칭 13/13, 100.0%)
  - `npcRefreshList` → HomeCharacterFactory.json (매칭 13/13, 100.0%)
  - `resId` → HomeCoachFactory.json (매칭 12/13, 92.3%)
  - `serverId` → HomeCharacterFactory.json (매칭 8/9, 88.9%)
  - `textRightTip` → TextFactory.json (매칭 4/5, 80.0%)
  - `textSettlement` → TextFactory.json (매칭 4/5, 80.0%)

### HomeTemplateFactory.json
- 레코드 수: 21
- 기본키(추정): `id`
- 참조 필드:
  - `furnitures` → HomeFurnitureFactory.json (매칭 120/120, 100.0%)

### HomeTrainSceneFactory.json
- 레코드 수: 36
- 기본키(추정): `id`
- 참조 필드:
  - `parts` → HomeTrainFactory.json (매칭 35/35, 100.0%)

### HomeTrainSceneGroupFactory.json
- 레코드 수: 27
- 기본키(추정): `id`
- 참조 필드:
  - `roadGroup` → HomeTrainSceneFactory.json (매칭 3/3, 100.0%)
  - `skyGroup` → HomeTrainSceneFactory.json (매칭 24/24, 100.0%)

### HomeWeaponFactory.json
- 레코드 수: 86
- 기본키(추정): `id`
- 참조 필드:
  - `coreList` → EngineCoreFactory.json (매칭 5/5, 100.0%)
  - `effectTypeEffect` → EffectFactory.json (매칭 19/20, 95.0%)
  - `growUpEntryList` → TrainWeaponSkillFactory.json (매칭 235/235, 100.0%)
  - `hitEventType` → TagFactory.json (매칭 6/6, 100.0%)
  - `normalEntryList` → TrainWeaponSkillFactory.json (매칭 51/51, 100.0%)
  - `typeWeapon` → TagFactory.json (매칭 8/8, 100.0%)

### ItemFactory.json
- 레코드 수: 882
- 기본키(추정): `id`
- 참조 필드:
  - `campType` → TagFactory.json (매칭 5/6, 83.3%)
  - `characterId` → UnitFactory.json (매칭 19/19, 100.0%)
  - `correspondingCity` → HomeStationFactory.json (매칭 11/11, 100.0%)
  - `cubeItemEffect` → RogueOrderFactory.json (매칭 12/12, 100.0%)
  - `drawing` → ProductionFactory.json (매칭 109/109, 100.0%)
  - `exchangeList` → EquipmentFactory.json (매칭 119/756, 15.7%) / SourceMaterialFactory.json (매칭 99/756, 13.1%)
  - `homeBuffId` → HomeBuffFactory.json (매칭 4/4, 100.0%)
  - `parkBuildingGrid` → ParkGridFactory.json (매칭 8/9, 88.9%)
  - `skinID` → HomeCoachSkinFactory.json (매칭 61/62, 98.4%)

### KabaneriMapFactory.json
- 레코드 수: 17
- 기본키(추정): `id`
- 참조 필드:
  - `grid2Pool` → KabaneriMapGridFactory.json (매칭 8/8, 100.0%)
  - `grid3Pool` → KabaneriMapGridFactory.json (매칭 3/3, 100.0%)
  - `gridPool` → KabaneriMapGridFactory.json (매칭 5/5, 100.0%)
  - `luaEventList` → KabaneriEventFactory.json (매칭 18/18, 100.0%)
  - `monsterGenertor` → TrainBattleUnitFactory.json (매칭 4/4, 100.0%)
  - `weatherPool` → TrainRoadMsgFactory.json (매칭 12/12, 100.0%)

### LeaderCardConditionFactory.json
- 레코드 수: 117
- 기본키(추정): `id`
- 참조 필드:
  - `buffFO` → BuffFactory.json (매칭 8/8, 100.0%)
  - `cardId` → CardFactory.json (매칭 7/8, 87.5%)
  - `reverseTagList` → TagFactory.json (매칭 5/5, 100.0%)
  - `tagList` → TagFactory.json (매칭 49/49, 100.0%)

### LevelFactory.json
- 레코드 수: 2909
- 기본키(추정): `id`
- 참조 필드:
  - `CorrespondingList` → ListFactory.json (매칭 25/26, 96.2%)
  - `abyssId` → AbyssFactory.json (매칭 140/140, 100.0%)
  - `activityId` → ActivityFactory.json (매칭 19/20, 95.0%)
  - `bgIdList` → BackgroundFactory.json (매칭 146/146, 100.0%)
  - `bgmId` → SoundFactory.json (매칭 56/57, 98.2%)
  - `bossId` → UnitFactory.json (매칭 158/159, 99.4%)
  - `buildingId` → BuildingFactory.json (매칭 9/10, 90.0%)
  - `chapterId` → ChapterFactory.json (매칭 29/30, 96.7%)
  - `cityId` → HomeStationFactory.json (매칭 18/19, 94.7%)
  - `correspondingActivity` → ActivityFactory.json (매칭 22/23, 95.7%)
  - `defaultAutoCode` → TextFactory.json (매칭 5/6, 83.3%)
  - `dropTableList` → ListFactory.json (매칭 1510/1510, 100.0%)
  - `enemyBookList` → UnitFactory.json (매칭 7/7, 100.0%)
  - `enemyWaveList` → EnemyWaveFactory.json (매칭 3735/3735, 100.0%)
  - `firstPassAward` → SourceMaterialFactory.json (매칭 95/142, 66.9%)
  - `firstPassAwardS` → ItemFactory.json (매칭 3/3, 100.0%)
  - `guildanceListZero` → GuildanceFactory.json (매칭 15/15, 100.0%)
  - `homeChrId` → HomeCharacterFactory.json (매칭 11/12, 91.7%)
  - `insZoneBGMId` → SoundFactory.json (매칭 25/26, 96.2%)
  - `levelBuffList` → BuffFactory.json (매칭 32/32, 100.0%)
  - `levelCoreId` → EngineCoreFactory.json (매칭 13/14, 92.9%)
  - `levelRoleList` → LevelRoleFactory.json (매칭 152/152, 100.0%)
  - `paragraphId` → ParagraphFactory.json (매칭 165/166, 99.4%)
  - `questList` → QuestFactory.json (매칭 600/600, 100.0%)
  - `randWaveList` → ListFactory.json (매칭 71/71, 100.0%)
  - `stageList` → ListFactory.json (매칭 167/167, 100.0%)
  - `timeReward` → ListFactory.json (매칭 9/9, 100.0%)
  - `unlockQuestList` → QuestFactory.json (매칭 24/24, 100.0%)
  - `weatherId` → WeatherFactory.json (매칭 13/14, 92.9%)
  - `weatherList` → WeatherFactory.json (매칭 9/9, 100.0%)

### LevelGroupFactory.json
- 레코드 수: 36
- 기본키(추정): `id`
- 참조 필드:
  - `bossRewardList` → ListFactory.json (매칭 32/32, 100.0%)
  - `bossViewId` → UnitViewFactory.json (매칭 18/18, 100.0%)
  - `closedTextId` → TextFactory.json (매칭 6/6, 100.0%)
  - `levelList` → LevelFactory.json (매칭 196/196, 100.0%)
  - `rankRewardList` → ListFactory.json (매칭 24/24, 100.0%)

### LevelRoleFactory.json
- 레코드 수: 443
- 기본키(추정): `id`
- 참조 필드:
  - `e1s1Id` → SkillFactory.json (매칭 41/42, 97.6%)
  - `e1s2Id` → SkillFactory.json (매칭 24/25, 96.0%)
  - `e1s3Id` → SkillFactory.json (매칭 17/18, 94.4%)
  - `e1s4Id` → SkillFactory.json (매칭 13/14, 92.9%)
  - `e2s1Id` → SkillFactory.json (매칭 5/6, 83.3%)
  - `e2s2Id` → SkillFactory.json (매칭 4/5, 80.0%)
  - `e2s3Id` → SkillFactory.json (매칭 6/7, 85.7%)
  - `e3s1Id` → SkillFactory.json (매칭 9/10, 90.0%)
  - `e3s2Id` → SkillFactory.json (매칭 4/5, 80.0%)
  - `e3s3Id` → SkillFactory.json (매칭 4/5, 80.0%)
  - `e3s4Id` → SkillFactory.json (매칭 4/5, 80.0%)
  - `e3s6Id` → SkillFactory.json (매칭 5/6, 83.3%)
  - `equip1Id` → EquipmentFactory.json (매칭 18/19, 94.7%)
  - `equip2Id` → EquipmentFactory.json (매칭 4/5, 80.0%)
  - `equip3Id` → EquipmentFactory.json (매칭 8/9, 88.9%)
  - `unitId` → UnitFactory.json (매칭 92/92, 100.0%)
  - `unitViewId` → UnitViewFactory.json (매칭 154/154, 100.0%)

### ListFactory.json
- 레코드 수: 7794
- 기본키(추정): `id`
- 참조 필드:
  - `EquipmentEntryList` → SkillFactory.json (매칭 140/140, 100.0%)
  - `IncludeParagraph` → ParagraphFactory.json (매칭 596/597, 99.8%)
  - `OrderList` → QuestFactory.json (매칭 158/158, 100.0%)
  - `PlaceDesc` → TextFactory.json (매칭 91/91, 100.0%)
  - `Unlockright` → TextFactory.json (매칭 4/4, 100.0%)
  - `achieveStartList` → QuestFactory.json (매칭 234/234, 100.0%)
  - `achievementList` → QuestFactory.json (매칭 6/6, 100.0%)
  - `adList` → PondFactory.json (매칭 32/32, 100.0%)
  - `areaStationList` → HomeStationFactory.json (매칭 10/10, 100.0%)
  - `attributeGradeList` → SkillFactory.json (매칭 675/675, 100.0%)
  - `awardList` → ItemFactory.json (매칭 31/45, 68.9%)
  - `boxGoodsList` → HomeGoodsFactory.json (매칭 149/151, 98.7%)
  - `boxList` → AFKEventFactory.json (매칭 11/11, 100.0%)
  - `breakItemList` → SourceMaterialFactory.json (매칭 40/41, 97.6%)
  - `buildingId` → BuildingFactory.json (매칭 10/10, 100.0%)
  - `carRouteList` → ParkGridFactory.json (매칭 38/38, 100.0%)
  - `classifyName` → TextFactory.json (매칭 4/4, 100.0%)
  - `collectionCardList` → CollectionCardFactory.json (매칭 7/7, 100.0%)
  - `commodityList` → ValuableFactory.json (매칭 178/178, 100.0%)
  - `dataTab` → DataFactory.json (매칭 57/98, 58.2%)
  - `dayQuestList` → LevelFactory.json (매칭 27/27, 100.0%)
  - `dialogList` → TextFactory.json (매칭 277/277, 100.0%)
  - `drinkBuffList` → HomeBuffFactory.json (매칭 10/10, 100.0%)
  - `dropList` → EquipmentFactory.json (매칭 159/288, 55.2%) / HomeGoodsFactory.json (매칭 71/288, 24.7%)
  - `electricMaterialList` → SourceMaterialFactory.json (매칭 31/33, 93.9%)
  - `enemyList` → UnitFactory.json (매칭 12/13, 92.3%)
  - `enemyRandWaveList` → EnemyWaveFactory.json (매칭 401/401, 100.0%)
  - `environmentList` → TrainRoadMsgFactory.json (매칭 42/42, 100.0%)
  - `eventLevelList` → AFKEventFactory.json (매칭 70/70, 100.0%)
  - `eventList` → AFKEventFactory.json (매칭 9/9, 100.0%)
  - `eventWeightList` → AFKEventFactory.json (매칭 380/380, 100.0%)
  - `goodsList` → ItemFactory.json (매칭 69/72, 95.8%)
  - `help` → TextFactory.json (매칭 215/215, 100.0%)
  - `helpTitle` → TextFactory.json (매칭 55/55, 100.0%)
  - `investChoose` → PondFactory.json (매칭 60/60, 100.0%)
  - `investorRankList` → RankFactory.json (매칭 9/9, 100.0%)
  - `investorRewList` → ItemFactory.json (매칭 21/21, 100.0%)
  - `kabanerList` → KabaneriMapFactory.json (매칭 15/15, 100.0%)
  - `levelList` → LevelFactory.json (매칭 346/346, 100.0%)
  - `leveldropList` → SourceMaterialFactory.json (매칭 113/197, 57.4%) / ItemFactory.json (매칭 38/197, 19.3%)
  - `mainStoreList` → StoreFactory.json (매칭 8/8, 100.0%)
  - `materialList` → SourceMaterialFactory.json (매칭 68/70, 97.1%)
  - `needleInMapList` → MapNeedleFactory.json (매칭 21/21, 100.0%)
  - `normalTagList` → TagFactory.json (매칭 47/47, 100.0%)
  - `notebook` → DataFactory.json (매칭 8/8, 100.0%)
  - `orderList` → ManufacturingOrderFactory.json (매칭 126/126, 100.0%)
  - `passengerAction4` → PassageFactory.json (매칭 3/3, 100.0%)
  - `passengerTypeList` → PassageFactory.json (매칭 40/40, 100.0%)
  - `placeType` → TagFactory.json (매칭 91/91, 100.0%)
  - `polluteRegularList` → AreaFactory.json (매칭 8/8, 100.0%)
  - `prisonFurniturePosition` → HomeFurnitureFactory.json (매칭 3/3, 100.0%)
  - `prisonerOrderList` → PrisonProcurementFactory.json (매칭 111/111, 100.0%)
  - `questList` → QuestFactory.json (매칭 343/343, 100.0%)
  - `questList1` → QuestFactory.json (매칭 116/119, 97.5%)
  - `questList2` → QuestFactory.json (매칭 102/113, 90.3%)
  - `questList3` → QuestFactory.json (매칭 106/118, 89.8%)
  - `questList4` → QuestFactory.json (매칭 75/85, 88.2%)
  - `questList5` → QuestFactory.json (매칭 114/124, 91.9%)
  - `randomList` → GuKaFactory.json (매칭 33/33, 100.0%)
  - `rareGoodsList` → HomeGoodsFactory.json (매칭 45/45, 100.0%)
  - `rewardList` → UnitFactory.json (매칭 85/196, 43.4%) / ItemFactory.json (매칭 51/196, 26.0%)
  - `shopList` → CommodityFactory.json (매칭 123/123, 100.0%)
  - `sideQuestList` → LevelFactory.json (매칭 242/242, 100.0%)
  - `skillBuffList` → SkillFactory.json (매칭 150/150, 100.0%)
  - `skillList` → SkillFactory.json (매칭 45/45, 100.0%)
  - `skipQuestList` → QuestFactory.json (매칭 10/10, 100.0%)
  - `stageQuestList` → StageQuestFactory.json (매칭 26/26, 100.0%)
  - `stationSceneList` → SoundFactory.json (매칭 21/22, 95.5%)
  - `textTipsList` → TextFactory.json (매칭 6/6, 100.0%)
  - `trainLook` → HomeCoachSkinFactory.json (매칭 19/19, 100.0%)
  - `trainName` → TextFactory.json (매칭 33/33, 100.0%)
  - `trainWeaponList` → HomeWeaponFactory.json (매칭 13/13, 100.0%)

### MailFactory.json
- 레코드 수: 396
- 기본키(추정): `id`
- 참조 필드:
  - `questId` → QuestFactory.json (매칭 12/13, 92.3%)
  - `rewards` → ItemFactory.json (매칭 47/66, 71.2%)

### ManufacturingOrderFactory.json
- 레코드 수: 152
- 기본키(추정): `id`
- 참조 필드:
  - `requireProduction` → ProductionFactory.json (매칭 47/47, 100.0%)
  - `rewardsList` → ItemFactory.json (매칭 3/3, 100.0%)

### MapNeedleFactory.json
- 레코드 수: 58
- 기본키(추정): `id`
- 참조 필드:
  - `LevelBefore` → LevelFactory.json (매칭 29/29, 100.0%)
  - `LevelConditions` → LevelFactory.json (매칭 3/3, 100.0%)
  - `ParagraphBefore` → ParagraphFactory.json (매칭 23/23, 100.0%)
  - `QuestConditions` → QuestFactory.json (매칭 25/25, 100.0%)
  - `triggerOrder` → MapSessionFactory.json (매칭 39/50, 78.0%)

### MapSessionFactory.json
- 레코드 수: 121
- 기본키(추정): `id`
- 참조 필드:
  - `mapNeedleList` → MapNeedleFactory.json (매칭 19/19, 100.0%)
  - `needWinlevel` → LevelFactory.json (매칭 27/28, 96.4%)
  - `onEnterId` → ParagraphFactory.json (매칭 43/80, 53.8%) / LogicFactory.json (매칭 35/80, 43.8%)

### MonopolyEventFactory.json
- 레코드 수: 248
- 기본키(추정): `id`
- 참조 필드:
  - `buffList` → SkillFactory.json (매칭 11/13, 84.6%)
  - `goodsList` → ItemFactory.json (매칭 40/40, 100.0%)
  - `gukaList` → GuKaFactory.json (매칭 40/40, 100.0%)
  - `levelID` → LevelFactory.json (매칭 14/14, 100.0%)
  - `levelIDList` → LevelFactory.json (매칭 5/5, 100.0%)
  - `randomRewardList` → ItemFactory.json (매칭 44/44, 100.0%)
  - `rewardList` → ItemFactory.json (매칭 7/7, 100.0%)

### MonopolyGameGridFactory.json
- 레코드 수: 89
- 기본키(추정): `id`
- 참조 필드:
  - `gridEventList` → MonopolyEventFactory.json (매칭 15/15, 100.0%)

### MonopolyGameMapFactory.json
- 레코드 수: 4
- 기본키(추정): `id`
- 참조 필드:
  - `bossRewardList` → ItemFactory.json (매칭 4/4, 100.0%)
  - `cityList` → MonopolyGameGridFactory.json (매칭 16/16, 100.0%)
  - `eventLimit` → MonopolyEventFactory.json (매칭 5/5, 100.0%)
  - `gameGradeList` → ListFactory.json (매칭 180/180, 100.0%)
  - `gridList` → MonopolyGameGridFactory.json (매칭 89/89, 100.0%)
  - `rankGridList` → MonopolyGameGridFactory.json (매칭 16/16, 100.0%)

### NPCFactory.json
- 레코드 수: 174
- 기본키(추정): `id`
- 참조 필드:
  - `ItemText` → TextFactory.json (매칭 26/26, 100.0%)
  - `OneText` → TextFactory.json (매칭 6/6, 100.0%)
  - `StoreText` → TextFactory.json (매칭 12/12, 100.0%)
  - `UseItem` → TextFactory.json (매칭 11/11, 100.0%)
  - `acceptQuestText` → TextFactory.json (매칭 16/16, 100.0%)
  - `addQuestSuccessText` → TextFactory.json (매칭 8/8, 100.0%)
  - `buyDownText` → TextFactory.json (매칭 11/11, 100.0%)
  - `buyFlatText` → TextFactory.json (매칭 11/11, 100.0%)
  - `buySettlementText` → TextFactory.json (매칭 17/17, 100.0%)
  - `buySuccessText` → TextFactory.json (매칭 44/44, 100.0%)
  - `buyUpText` → TextFactory.json (매칭 10/10, 100.0%)
  - `cancelBuyText` → TextFactory.json (매칭 11/11, 100.0%)
  - `cancelQuestText` → TextFactory.json (매칭 16/16, 100.0%)
  - `cancelSellText` → TextFactory.json (매칭 11/11, 100.0%)
  - `cancelSignText` → TextFactory.json (매칭 29/29, 100.0%)
  - `discardText` → TextFactory.json (매칭 29/29, 100.0%)
  - `drinkText` → TextFactory.json (매칭 6/6, 100.0%)
  - `enterExchangeText` → TextFactory.json (매칭 43/43, 100.0%)
  - `enterRecycleText` → TextFactory.json (매칭 4/4, 100.0%)
  - `enterText` → TextFactory.json (매칭 156/200, 78.0%)
  - `exchangeSuccessText` → TextFactory.json (매칭 22/22, 100.0%)
  - `fishSellText` → TextFactory.json (매칭 3/3, 100.0%)
  - `fishStoreText` → TextFactory.json (매칭 6/6, 100.0%)
  - `goodsSoundList` → SoundFactory.json (매칭 776/874, 88.8%)
  - `haggleFailText` → TextFactory.json (매칭 11/11, 100.0%)
  - `haggleSuccessText` → TextFactory.json (매칭 11/11, 100.0%)
  - `investFiveText` → TextFactory.json (매칭 8/8, 100.0%)
  - `investFourText` → TextFactory.json (매칭 8/8, 100.0%)
  - `investOneText` → TextFactory.json (매칭 8/8, 100.0%)
  - `investText` → TextFactory.json (매칭 4/4, 100.0%)
  - `investThreeText` → TextFactory.json (매칭 8/8, 100.0%)
  - `investTwoText` → TextFactory.json (매칭 8/8, 100.0%)
  - `levelListText` → TextFactory.json (매칭 23/23, 100.0%)
  - `openWarehouseText` → TextFactory.json (매칭 11/11, 100.0%)
  - `orderSuccessText` → TextFactory.json (매칭 60/60, 100.0%)
  - `prisonExchangeText` → TextFactory.json (매칭 3/3, 100.0%)
  - `prisonMaterialText` → TextFactory.json (매칭 3/3, 100.0%)
  - `prisonOpenShopText` → TextFactory.json (매칭 3/3, 100.0%)
  - `prisonOpenWarehouseText` → TextFactory.json (매칭 3/3, 100.0%)
  - `prisonProductlText` → TextFactory.json (매칭 3/3, 100.0%)
  - `questListNullText` → TextFactory.json (매칭 8/8, 100.0%)
  - `questListText` → TextFactory.json (매칭 16/16, 100.0%)
  - `raiseFailText` → TextFactory.json (매칭 11/11, 100.0%)
  - `raiseSuccessText` → TextFactory.json (매칭 11/11, 100.0%)
  - `recycleSuccessText` → TextFactory.json (매칭 4/4, 100.0%)
  - `rewardGetText` → TextFactory.json (매칭 4/4, 100.0%)
  - `saleOutText` → TextFactory.json (매칭 9/9, 100.0%)
  - `sellDownText` → TextFactory.json (매칭 11/11, 100.0%)
  - `sellFlatText` → TextFactory.json (매칭 11/11, 100.0%)
  - `sellSettlementText` → TextFactory.json (매칭 17/17, 100.0%)
  - `sellSuccessText` → TextFactory.json (매칭 11/11, 100.0%)
  - `sellUpText` → TextFactory.json (매칭 11/11, 100.0%)
  - `signText` → TextFactory.json (매칭 29/29, 100.0%)
  - `stationSoundList` → SoundFactory.json (매칭 98/112, 87.5%)
  - `tabBattleText` → TextFactory.json (매칭 45/45, 100.0%)
  - `tabBuyText` → TextFactory.json (매칭 21/21, 100.0%)
  - `tabOrderText` → TextFactory.json (매칭 60/60, 100.0%)
  - `tabSellText` → TextFactory.json (매칭 21/21, 100.0%)
  - `talkText` → TextFactory.json (매칭 532/544, 97.8%)
  - `upperText` → TextFactory.json (매칭 6/6, 100.0%)

### ParagraphFactory.json
- 레코드 수: 807
- 기본키(추정): `id`
- 참조 필드:
  - `DescList` → PlotFactory.json (매칭 108/108, 100.0%)
  - `completeQuest` → QuestFactory.json (매칭 227/228, 99.6%)
  - `plotList` → PlotFactory.json (매칭 52/52, 100.0%)
  - `plotListGril` → PlotFactory.json (매칭 5/5, 100.0%)

### ParkGridFactory.json
- 레코드 수: 250
- 기본키(추정): `id`
- 참조 필드:
  - `gridEventList` → MonopolyEventFactory.json (매칭 27/27, 100.0%)
  - `gridSealList` → ItemFactory.json (매칭 4/4, 100.0%)

### ParkMapFactory.json
- 레코드 수: 2
- 기본키(추정): `id`
- 참조 필드:
  - `combineSealList` → ParkSealFactory.json (매칭 35/35, 100.0%)
  - `gridList` → ParkGridFactory.json (매칭 245/245, 100.0%)
  - `gukaList` → GuKaFactory.json (매칭 40/40, 100.0%)
  - `isQuestClearProgressList` → QuestFactory.json (매칭 4/4, 100.0%)
  - `singleDialogList` → MonopolyEventFactory.json (매칭 6/6, 100.0%)
  - `singleSealList` → ParkSealFactory.json (매칭 4/4, 100.0%)
  - `startList` → ParkGridFactory.json (매칭 4/4, 100.0%)
  - `taskInitialList` → QuestFactory.json (매칭 14/14, 100.0%)
  - `ticketBuffList` → ItemFactory.json (매칭 3/3, 100.0%)

### ParkSealFactory.json
- 레코드 수: 40
- 기본키(추정): `id`
- 참조 필드:
  - `combineSeal` → ItemFactory.json (매칭 4/4, 100.0%)
  - `combineSkillId` → SkillFactory.json (매칭 35/35, 100.0%)
  - `itemId` → ItemFactory.json (매칭 4/4, 100.0%)
  - `skillId` → SkillFactory.json (매칭 4/4, 100.0%)

### PassageFactory.json
- 레코드 수: 92
- 기본키(추정): `id`
- 참조 필드:
  - `age` → TagFactory.json (매칭 4/4, 100.0%)
  - `career` → TagFactory.json (매칭 16/16, 100.0%)
  - `gender` → TagFactory.json (매칭 3/3, 100.0%)
  - `homePassage` → HomeCharacterFactory.json (매칭 92/92, 100.0%)
  - `passageDesc` → TextFactory.json (매칭 52/52, 100.0%)
  - `tag` → ListFactory.json (매칭 30/30, 100.0%)

### PetFactory.json
- 레코드 수: 51
- 기본키(추정): `id`
- 참조 필드:
  - `homeCharacter` → HomeCharacterFactory.json (매칭 50/50, 100.0%)
  - `petVarity` → TagFactory.json (매칭 8/8, 100.0%)

### PlaygroundFactory.json
- 레코드 수: 9
- 기본키(추정): `id`
- 참조 필드:
  - `PublicizeList` → PondFactory.json (매칭 3/3, 100.0%)
  - `expList` → PondFactory.json (매칭 60/61, 98.4%)
  - `extendList` → HomeCoachFactory.json (매칭 5/5, 100.0%)
  - `furnitureTypeList` → TagFactory.json (매칭 3/3, 100.0%)
  - `levelList` → LevelFactory.json (매칭 13/13, 100.0%)
  - `parkPond` → PondFactory.json (매칭 60/61, 98.4%)
  - `questList` → QuestFactory.json (매칭 143/143, 100.0%)

### PlotFactory.json
- 레코드 수: 3611
- 기본키(추정): `id`
- 참조 필드:
  - `FemaleVideo` → VideoFactory.json (매칭 27/28, 96.4%)
  - `MaleVideo` → VideoFactory.json (매칭 27/28, 96.4%)
  - `TimeLine` → TimeLineFactory.json (매칭 28/28, 100.0%)
  - `paragraph_1` → ParagraphFactory.json (매칭 179/180, 99.4%)
  - `paragraph_2` → ParagraphFactory.json (매칭 176/177, 99.4%)
  - `soundId` → SoundFactory.json (매칭 88/89, 98.9%)
  - `tip01` → DataFactory.json (매칭 52/52, 100.0%)
  - `unitID` → UnitFactory.json (매칭 25/26, 96.2%)
  - `unitViewID` → UnitViewFactory.json (매칭 167/168, 99.4%)

### PondFactory.json
- 레코드 수: 158
- 기본키(추정): `id`
- 참조 필드:
  - `Type` → TagFactory.json (매칭 3/3, 100.0%)
  - `adDesc` → TextFactory.json (매칭 32/32, 100.0%)
  - `adType` → TagFactory.json (매칭 32/32, 100.0%)
  - `advPublicizeList` → BuildingFactory.json (매칭 60/60, 100.0%)
  - `dec` → TextFactory.json (매칭 3/3, 100.0%)
  - `leafletPublicizeList` → BuildingFactory.json (매칭 60/60, 100.0%)
  - `name` → TextFactory.json (매칭 3/3, 100.0%)
  - `passengerTagList` → ListFactory.json (매칭 30/30, 100.0%)
  - `passengerTypeList` → PassageFactory.json (매칭 49/49, 100.0%)
  - `type` → TagFactory.json (매칭 40/40, 100.0%)

### PrisonFactory.json
- 레코드 수: 1
- 기본키(추정): `id`
- 참조 필드:
  - `characterHappenList` → TagFactory.json (매칭 11/11, 100.0%)
  - `characterList` → TagFactory.json (매칭 11/11, 100.0%)
  - `healthEventEffectList` → TagFactory.json (매칭 5/5, 100.0%)
  - `healthNaturalEffectList` → TagFactory.json (매칭 5/5, 100.0%)
  - `initWeekOrderList` → PrisonProcurementFactory.json (매칭 5/5, 100.0%)
  - `interceptRoomList` → PrisonRoomTypeFactory.json (매칭 4/4, 100.0%)
  - `leaveMessage` → TextFactory.json (매칭 15/15, 100.0%)
  - `lvDesList` → TextFactory.json (매칭 9/9, 100.0%)
  - `lvList` → HomeFurnitureFactory.json (매칭 10/10, 100.0%)
  - `prison` → PrisonRoomTypeFactory.json (매칭 32/32, 100.0%)
  - `prisonRoomPosition` → ListFactory.json (매칭 6/6, 100.0%)
  - `taskAllList` → QuestFactory.json (매칭 260/260, 100.0%)
  - `taskInitialList` → QuestFactory.json (매칭 21/21, 100.0%)

### PrisonProcurementFactory.json
- 레코드 수: 162
- 기본키(추정): `id`
- 참조 필드:
  - `costList` → HomeGoodsFactory.json (매칭 8/8, 100.0%)
  - `requireItemList` → HomeGoodsFactory.json (매칭 38/38, 100.0%)
  - `requireProduction` → ProductionFactory.json (매칭 37/37, 100.0%)
  - `rewardsList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `target` → HomeGoodsFactory.json (매칭 10/10, 100.0%)
  - `weekPerRewardsList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `weekRequireItemList` → HomeGoodsFactory.json (매칭 29/29, 100.0%)
  - `weekRequireProduction` → ProductionFactory.json (매칭 29/29, 100.0%)
  - `weekTotalRewardsList` → ItemFactory.json (매칭 3/3, 100.0%)

### PrisonRoomFactory.json
- 레코드 수: 258
- 기본키(추정): `id`
- 참조 필드:
  - `cureTimeList` → TagFactory.json (매칭 10/10, 100.0%)
  - `formulaList` → ProductionFactory.json (매칭 15/15, 100.0%)
  - `timeBrig` → TagFactory.json (매칭 5/5, 100.0%)
  - `unlockFormulaList` → ProductionFactory.json (매칭 15/15, 100.0%)
  - `unlockMachineList` → HomeFurnitureFactory.json (매칭 10/10, 100.0%)

### PrisonerEventFactory.json
- 레코드 수: 1
- 기본키(추정): `id`
- 참조 필드:
  - `haloFetterList` → TagFactory.json (매칭 10/10, 100.0%)
  - `personalityFetterList` → TagFactory.json (매칭 14/14, 100.0%)

### PrisonerFactory.json
- 레코드 수: 56
- 기본키(추정): `id`
- 참조 필드:
  - `PrisonerAnimation` → HomeCharacterFactory.json (매칭 55/55, 100.0%)
  - `monitor` → TagFactory.json (매칭 4/4, 100.0%)
  - `prisonerPersonality` → TagFactory.json (매칭 13/13, 100.0%)
  - `prisonerRarity` → TagFactory.json (매칭 3/3, 100.0%)
  - `prisonerSide` → TagFactory.json (매칭 10/10, 100.0%)

### ProductionFactory.json
- 레코드 수: 157
- 기본키(추정): `id`
- 참조 필드:
  - `condition` → FormulaFactory.json (매칭 297/297, 100.0%)
  - `costList` → HomeGoodsFactory.json (매칭 31/32, 96.9%)
  - `formulaType` → TagFactory.json (매칭 6/6, 100.0%)
  - `product` → HomeGoodsFactory.json (매칭 57/57, 100.0%)
  - `unlock` → ItemFactory.json (매칭 104/105, 99.0%)

### QuestFactory.json
- 레코드 수: 2787
- 기본키(추정): `id`
- 참조 필드:
  - `activityId` → ActivityFactory.json (매칭 7/8, 87.5%)
  - `bannerList` → ExtractFactory.json (매칭 11/11, 100.0%)
  - `buffActivate` → HomeBuffFactory.json (매칭 4/5, 80.0%)
  - `changeCityStateList` → HomeStationFactory.json (매칭 8/8, 100.0%)
  - `cityList` → HomeStationFactory.json (매칭 3/3, 100.0%)
  - `client` → ProfilePhotoFactory.json (매칭 144/145, 99.3%)
  - `endStationList` → HomeStationFactory.json (매칭 20/20, 100.0%)
  - `giftList` → ValuableFactory.json (매칭 11/11, 100.0%)
  - `goodsList` → HomeGoodsFactory.json (매칭 76/76, 100.0%)
  - `passengerList` → PassageFactory.json (매칭 30/30, 100.0%)
  - `preLevel` → LevelFactory.json (매칭 3/3, 100.0%)
  - `requireItemList` → HomeGoodsFactory.json (매칭 70/71, 98.6%)
  - `rewardsList` → ItemFactory.json (매칭 84/201, 41.8%) / EquipmentFactory.json (매칭 36/201, 17.9%)
  - `startStation` → HomeStationFactory.json (매칭 20/21, 95.2%)
  - `teleportEndStation` → HomeStationFactory.json (매칭 9/10, 90.0%)
  - `teleportStartStation` → HomeStationFactory.json (매칭 10/11, 90.9%)
  - `traceList` → QuestTrackFactory.json (매칭 322/323, 99.7%)
  - `typeIcon` → TagFactory.json (매칭 4/5, 80.0%)
  - `unlockCity` → HomeStationFactory.json (매칭 7/8, 87.5%)

### QuestTrackFactory.json
- 레코드 수: 358
- 기본키(추정): `id`
- 참조 필드:
  - `stateList` → CityMapFactory.json (매칭 300/301, 99.7%)

### QuestTypeFactory.json
- 레코드 수: 125
- 기본키(추정): `id`
- 참조 필드:
  - `questList` → QuestFactory.json (매칭 1165/1165, 100.0%)

### RandomBattleFactory.json
- 레코드 수: 11
- 기본키(추정): `id`
- 참조 필드:
  - `initEquipList` → ListFactory.json (매칭 30/30, 100.0%)
  - `initRoleList` → ListFactory.json (매칭 40/40, 100.0%)
  - `randomBattleLevelList` → ListFactory.json (매칭 57/57, 100.0%)
  - `rewardFinish` → ListFactory.json (매칭 9/9, 100.0%)

### RankFactory.json
- 레코드 수: 48
- 기본키(추정): `id`
- 참조 필드:
  - `skipStation` → HomeStationFactory.json (매칭 8/9, 88.9%)

### RogueBuffFactory.json
- 레코드 수: 143
- 기본키(추정): `id`
- 참조 필드:
  - `buffList` → RogueOrderFactory.json (매칭 17/17, 100.0%)
  - `correspondingTeam` → RogueTeamFactory.json (매칭 4/5, 80.0%)
  - `effect` → SkillFactory.json (매칭 93/94, 98.9%)
  - `intensifyEffect` → SkillFactory.json (매칭 72/73, 98.6%)
  - `skillEffect` → RogueOrderFactory.json (매칭 28/28, 100.0%)

### RogueEquipmentFactory.json
- 레코드 수: 80
- 기본키(추정): `id`
- 참조 필드:
  - `attributeList` → RogueOrderFactory.json (매칭 26/26, 100.0%)
  - `conditionList` → RogueOrderFactory.json (매칭 71/72, 98.6%)

### RogueEventFactory.json
- 레코드 수: 273
- 기본키(추정): `id`
- 참조 필드:
  - `levelId` → LevelFactory.json (매칭 174/175, 99.4%)
  - `npcId` → NPCFactory.json (매칭 10/11, 90.9%)
  - `optionList` → ActivityListFactory.json (매칭 192/192, 100.0%)
  - `typeId` → TagFactory.json (매칭 7/7, 100.0%)

### RogueOrderFactory.json
- 레코드 수: 283
- 기본키(추정): `id`
- 참조 필드:
  - `descent` → RogueBuffFactory.json (매칭 16/17, 94.1%)
  - `eventId` → RogueEventFactory.json (매칭 10/10, 100.0%)
  - `insufficientTips` → TextFactory.json (매칭 5/6, 83.3%)
  - `levelId` → LevelFactory.json (매칭 18/18, 100.0%)
  - `rewardList` → ActivityListFactory.json (매칭 20/21, 95.2%)
  - `skillId` → SkillFactory.json (매칭 69/70, 98.6%)
  - `typeId` → TagFactory.json (매칭 7/7, 100.0%)

### RogueTeamFactory.json
- 레코드 수: 6
- 기본키(추정): `id`
- 참조 필드:
  - `extraBuffList` → RogueBuffFactory.json (매칭 25/26, 96.2%)
  - `initialEffectList` → SkillFactory.json (매칭 4/4, 100.0%)

### SigninFactory.json
- 레코드 수: 27
- 기본키(추정): `id`
- 참조 필드:
  - `SigninAwardList` → ListFactory.json (매칭 39/39, 100.0%)
  - `SigninRewardList` → ListFactory.json (매칭 81/81, 100.0%)

### SkillFactory.json
- 레코드 수: 4368
- 기본키(추정): `id`
- 참조 필드:
  - `attributeIntensify` → ListFactory.json (매칭 315/315, 100.0%)
  - `buffId` → BuffFactory.json (매칭 2685/2686, 100.0%)
  - `cardID` → CardFactory.json (매칭 494/495, 99.8%)
  - `tagFilterList` → TagFactory.json (매칭 189/189, 100.0%)
  - `tagId` → TagFactory.json (매칭 228/229, 99.6%)

### SourceMaterialFactory.json
- 레코드 수: 292
- 기본키(추정): `id`
- 참조 필드:
  - `CorrespondingRole` → UnitFactory.json (매칭 91/91, 100.0%)
  - `usedPetVarity` → TagFactory.json (매칭 9/9, 100.0%)

### StageQuestFactory.json
- 레코드 수: 26
- 기본키(추정): `id`
- 참조 필드:
  - `questList` → QuestFactory.json (매칭 153/153, 100.0%)
  - `stageReward` → ItemFactory.json (매칭 3/3, 100.0%)

### StoreConditionFactory.json
- 레코드 수: 8
- 기본키(추정): `id`
- 참조 필드:
  - `stationOpen` → HomeStationFactory.json (매칭 7/8, 87.5%)

### StoreFactory.json
- 레코드 수: 109
- 기본키(추정): `id`
- 참조 필드:
  - `activityId` → ActivityFactory.json (매칭 5/5, 100.0%)
  - `capacityType` → TagFactory.json (매칭 4/4, 100.0%)
  - `conditions` → StoreConditionFactory.json (매칭 7/8, 87.5%)
  - `currencyShow` → ItemFactory.json (매칭 20/20, 100.0%)
  - `moneyList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `recycleShopList` → CommodityFactory.json (매칭 288/288, 100.0%)
  - `shopList` → CommodityFactory.json (매칭 1227/1289, 95.2%)

### TagFactory.json
- 레코드 수: 1949
- 기본키(추정): `id`
- 참조 필드:
  - `buffId` → HomeBuffFactory.json (매칭 8/8, 100.0%)
  - `skillBuff` → SkillFactory.json (매칭 5/6, 83.3%)

### TalentFactory.json
- 레코드 수: 661
- 기본키(추정): `id`
- 참조 필드:
  - `attributeIntensify` → ListFactory.json (매칭 135/135, 100.0%)
  - `skillActiveUpgrade` → SkillFactory.json (매칭 141/141, 100.0%)
  - `skillChangeList` → SkillFactory.json (매칭 101/101, 100.0%)
  - `skillIntensify` → SkillFactory.json (매칭 282/283, 99.6%)
  - `skillList` → SkillFactory.json (매칭 462/462, 100.0%)
  - `skillParamOffsetList` → SkillFactory.json (매칭 12/13, 92.3%)

### TextFactory.json
- 레코드 수: 11887
- 기본키(추정): `id`
- 참조 필드:
  - `soundList` → SoundFactory.json (매칭 1165/1166, 99.9%)

### TimeLineFactory.json
- 레코드 수: 43
- 기본키(추정): `id`
- 참조 필드:
  - `fixedActorList` → UnitFactory.json (매칭 3/3, 100.0%)

### TrainBattleBulletFactory.json
- 레코드 수: 12
- 기본키(추정): `id`
- 참조 필드:
  - `BulletEffect` → EffectFactory.json (매칭 9/9, 100.0%)

### TrainBattleSkillFactory.json
- 레코드 수: 24
- 기본키(추정): `id`
- 참조 필드:
  - `AudioList` → SoundFactory.json (매칭 5/5, 100.0%)
  - `BulletList` → TrainBattleBulletFactory.json (매칭 3/3, 100.0%)

### TrainBattleUnitFactory.json
- 레코드 수: 38
- 기본키(추정): `id`
- 참조 필드:
  - `Skills` → TrainBattleSkillFactory.json (매칭 6/6, 100.0%)
  - `buff` → KabaneriBuffFactory.json (매칭 11/12, 91.7%)
  - `deathFx` → KBEffectFactory.json (매칭 5/6, 83.3%)
  - `hitSound` → SoundFactory.json (매칭 7/7, 100.0%)

### TrainRoadMsgFactory.json
- 레코드 수: 49
- 기본키(추정): `id`
- 참조 필드:
  - `weatherList` → WeatherFactory.json (매칭 4/4, 100.0%)

### TrainSkinStudyFactory.json
- 레코드 수: 21
- 기본키(추정): `id`
- 참조 필드:
  - `energyPrepare` → EngineCoreFactory.json (매칭 5/5, 100.0%)
  - `itemCost` → SourceMaterialFactory.json (매칭 17/19, 89.5%)
  - `itemPrepare` → ItemFactory.json (매칭 14/14, 100.0%)
  - `reward` → ItemFactory.json (매칭 15/15, 100.0%)
  - `showPic` → HomeCoachSkinFactory.json (매칭 15/16, 93.8%)

### TrainSoundFactory.json
- 레코드 수: 10
- 기본키(추정): `id`
- 참조 필드:
  - `tryListenId` → SoundFactory.json (매칭 10/10, 100.0%)
  - `voiceDeparture` → SoundFactory.json (매칭 15/16, 93.8%)
  - `voiceDeparturePassenger` → SoundFactory.json (매칭 15/16, 93.8%)
  - `voiceWillArrive` → SoundFactory.json (매칭 14/15, 93.3%)
  - `voiceWillArrivePassenger` → SoundFactory.json (매칭 14/15, 93.3%)

### TrainWeaponSkillFactory.json
- 레코드 수: 418
- 기본키(추정): `id`
- 참조 필드:
  - `entryTag` → TagFactory.json (매칭 78/78, 100.0%)
  - `lineidList` → HomeLineFactory.json (매칭 3/3, 100.0%)
  - `skillBuff` → SkillFactory.json (매칭 27/28, 96.4%)

### TurntableBattleFactory.json
- 레코드 수: 1
- 기본키(추정): `id`
- 참조 필드:
  - `abyssPeriodList` → AbyssPeriodFactory.json (매칭 35/35, 100.0%)
  - `levelBossList` → ListFactory.json (매칭 74/74, 100.0%)

### UnitActionFactory.json
- 레코드 수: 4780
- 기본키(추정): `id`
- 참조 필드:
  - `buffFO` → BuffFactory.json (매칭 21/22, 95.5%)
  - `stateIdList` → UnitStateFactory.json (매칭 5227/5228, 100.0%)
  - `targetTagList` → TagFactory.json (매칭 26/26, 100.0%)

### UnitFactory.json
- 레코드 수: 1213
- 기본키(추정): `id`
- 참조 필드:
  - `FoodList` → FoodFactory.json (매칭 10/10, 100.0%)
  - `ProfilePhotoList` → ProfilePhotoFactory.json (매칭 347/347, 100.0%)
  - `abilityList` → TagFactory.json (매칭 37/37, 100.0%)
  - `actionAttackedBackID` → UnitActionFactory.json (매칭 395/396, 99.7%)
  - `actionAttackedID` → UnitActionFactory.json (매칭 395/396, 99.7%)
  - `actionDeadID` → UnitActionFactory.json (매칭 398/399, 99.7%)
  - `actionKnockUpID` → UnitActionFactory.json (매칭 61/62, 98.4%)
  - `actionMoveID` → UnitActionFactory.json (매칭 396/397, 99.7%)
  - `actionStandID` → UnitActionFactory.json (매칭 397/398, 99.7%)
  - `actionStunID` → UnitActionFactory.json (매칭 394/395, 99.7%)
  - `actionVictoryID` → UnitActionFactory.json (매칭 170/171, 99.4%)
  - `awakeList` → AwakeFactory.json (매칭 28/28, 100.0%)
  - `birthdayCake` → ItemFactory.json (매칭 5/6, 83.3%)
  - `bossHpTemp` → BattleInfoFactory.json (매칭 5/6, 83.3%)
  - `breakthroughList` → BreakthroughFactory.json (매칭 719/720, 99.9%)
  - `bulletControllerList` → BulletControllerFactory.json (매칭 14/14, 100.0%)
  - `controllerId` → ControllerFactory.json (매칭 527/528, 99.8%)
  - `deadAddBuffToOwner` → BuffFactory.json (매칭 11/12, 91.7%)
  - `enemyCamp` → TagFactory.json (매칭 7/8, 87.5%)
  - `enemyDrop` → SourceMaterialFactory.json (매칭 91/91, 100.0%)
  - `enemySkillList` → ListFactory.json (매칭 545/545, 100.0%)
  - `enemyType` → TagFactory.json (매칭 4/5, 80.0%)
  - `equipmentSlotList` → TagFactory.json (매칭 3/3, 100.0%)
  - `fileList` → UnitViewFactory.json (매칭 9/10, 90.0%)
  - `growthId` → GrowthFactory.json (매칭 384/385, 99.7%)
  - `growthTagList` → GrowthFactory.json (매칭 10/10, 100.0%)
  - `homeCharacter` → HomeCharacterFactory.json (매칭 96/97, 99.0%)
  - `homeSkillList` → HomeSkillFactory.json (매칭 188/188, 100.0%)
  - `ownerDeadAddBuffID` → BuffFactory.json (매칭 17/18, 94.4%)
  - `passiveSkillList` → SkillFactory.json (매칭 642/642, 100.0%)
  - `prisonerDrop` → PrisonerFactory.json (매칭 54/54, 100.0%)
  - `resistanceList` → TagFactory.json (매칭 21/21, 100.0%)
  - `rewardList` → SourceMaterialFactory.json (매칭 92/92, 100.0%)
  - `sideId` → TagFactory.json (매칭 39/40, 97.5%)
  - `skillList` → SkillFactory.json (매칭 282/283, 99.6%)
  - `skinList` → UnitViewFactory.json (매칭 157/157, 100.0%)
  - `tagList` → TagFactory.json (매칭 164/164, 100.0%)
  - `talentList` → TalentFactory.json (매칭 638/638, 100.0%)
  - `viewId` → UnitViewFactory.json (매칭 406/407, 99.8%)
  - `weaknessList` → TagFactory.json (매칭 13/13, 100.0%)

### UnitStateFactory.json
- 레코드 수: 5323
- 기본키(추정): `id`
- 참조 필드:
  - `effectList` → EffectFactory.json (매칭 2997/2998, 100.0%)
  - `frameEventList` → FrameEventFactory.json (매칭 2882/2882, 100.0%)
  - `previousActionList` → UnitActionFactory.json (매칭 96/96, 100.0%)
  - `soundList` → SoundFactory.json (매칭 1228/1229, 99.9%)
  - `viewId` → UnitViewFactory.json (매칭 337/338, 99.7%)

### UnitViewFactory.json
- 레코드 수: 691
- 기본키(추정): `id`
- 참조 필드:
  - `ProfilePhotoList` → ProfilePhotoFactory.json (매칭 245/245, 100.0%)
  - `character` → UnitFactory.json (매칭 98/99, 99.0%)
  - `exchangeBulletList` → BulletFactory.json (매칭 175/175, 100.0%)
  - `exchangeEffectList` → EffectFactory.json (매칭 1538/1538, 100.0%)
  - `exchangeSoundList` → SoundFactory.json (매칭 15/15, 100.0%)
  - `gachaVoice` → SoundFactory.json (매칭 86/87, 98.9%)
  - `homeSkill` → HomeSkillFactory.json (매칭 36/37, 97.3%)
  - `mainUIVoice` → SoundFactory.json (매칭 94/95, 98.9%)
  - `profilePhotoID` → ProfilePhotoFactory.json (매칭 162/163, 99.4%)
  - `skinBattlePass` → BattlePassFactory.json (매칭 20/21, 95.2%)

### ValuableFactory.json
- 레코드 수: 502
- 기본키(추정): `id`
- 참조 필드:
  - `correspondCharacter` → UnitFactory.json (매칭 51/52, 98.1%)
  - `correspondStore` → StoreFactory.json (매칭 6/7, 85.7%)
  - `dayRewardList` → ListFactory.json (매칭 8/8, 100.0%)
  - `des` → TextFactory.json (매칭 25/26, 96.2%)
  - `rewardList` → ItemFactory.json (매칭 88/301, 29.2%) / SourceMaterialFactory.json (매칭 65/301, 21.6%)
  - `showList` → ItemFactory.json (매칭 3/3, 100.0%)
  - `title` → TextFactory.json (매칭 13/14, 92.9%)

### VolleyballCharacterFactory.json
- 레코드 수: 10
- 기본키(추정): `id`
- 참조 필드:
  - `profilePhoto` → ProfilePhotoFactory.json (매칭 10/10, 100.0%)
  - `roleID` → UnitFactory.json (매칭 9/10, 90.0%)

### WeatherFactory.json
- 레코드 수: 57
- 기본키(추정): `id`
- 참조 필드:
  - `buffId` → BuffFactory.json (매칭 47/48, 97.9%)
  - `effectId` → EffectFactory.json (매칭 30/31, 96.8%)
  - `endEffectId` → EffectFactory.json (매칭 7/8, 87.5%)
