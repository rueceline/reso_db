# Resonance 리소스 추출 작업 정리

본 문서는 **Resonance(레조넌스)** 게임의 UnityCN 기반 리소스 구조를 분석하고,
**음성(AudioClip) 추출까지 완료한 시점의 확정된 사실, 작업 방식, 그리고 다음 단계 로드맵**을 정리한 README이다.

---

## 1. 결론 요약

* Resonance는 **UnityCN 커스텀 UnityFS 압축**을 사용한다.
* 표준 Unity 툴(AssetRipper / UABEA / AssetStudio)은 정상적으로 실패한다.
* **UnityCN Key가 포함된 전용 툴(RazTools 계열)**로만 정적 언팩 가능하다.
* AudioClip 추출은 성공했고, **wav 파일로 정상 재생 가능**하다.
* MonoBehaviour(JSON)는 재생 옵션용이며, **음성 파일 경로/텍스트 매칭 정보는 포함하지 않는다.**

---

## 2. 음성(AudioClip) 추출 파이프라인 (확정)

### 2.1 대상 폴더

```
레조넌스_Data\Patch\Asset\translate\jp\sound\cv_japanese\
```

하위 예시:

```
plot\m1\
plot\m2\
plot\m3\
```

---

### 2.2 추출 방식

* https://github.com/RazTools/Studio/releases
1. UnityCN 지원 툴 실행
2. 게임 선택: **Resonance (UnityCN Key 자동 적용)**
3. 폴더 단위로 Import (개별 .asset 선택 ❌)
4. Asset Type에서 **AudioClip** 확인
5. AudioClip 전체 Export → `wav`

---

### 2.3 결과 특성 (중요)

* `.asset` 파일 개수와 `wav` 파일 개수는 **1:1이 아니다.**
* 하나의 `.asset` 안에 **여러 AudioClip**이 들어 있는 구조가 정상이다.
* 추출된 wav 파일명은 **툴이 자동 생성한 논리적 이름**이다.

예시:

```
UI_Plot_M1_7_027.wav
```

의미:

* `UI_Plot` : 음성 분류/컨텍스트
* `M1` : 챕터(m1)
* `7` : 내부 사운드 그룹 또는 이벤트 ID
* `027` : 그룹 내 인덱스

이 이름은 **파일 시스템 경로가 아니라, 런타임 재생 키(audioKey)**에 가깝다.

---

## 3. MonoBehaviour / SoundRandomValue.json의 의미

예시:

```json
{
  "volumeMax": 1.0,
  "volumeMin": 1.0,
  "pitchMax": 1.0,
  "pitchMin": 1.0
}
```

* AudioClip 자체 ❌
* 파일 경로 ❌
* 대사 텍스트 매칭 정보 ❌

역할:

* 음성 재생 시 볼륨/피치 범위를 정의하는 **재생 옵션 컴포넌트**
* AudioClip과 **런타임에서 연결**될 뿐, 정적 매칭 정보는 제공하지 않음

---

## 4. 음성 ↔ 대사 텍스트 매칭에 대한 결론

### 4.1 번호 순 매칭은 신뢰 불가

* 같은 챕터 내에서 순서가 비슷할 수는 있으나
* 무음 줄, 선택지, UI 음성, 컷신 등으로 쉽게 어긋남
* **검증용 가설 수준**으로만 사용 가능

### 4.2 실제 매칭에 사용되는 고리(후속 단계)

* 스토리 연출 데이터(컷신/스크립트)
* Dialogue / Voice 테이블(있는 경우)
* Timeline/Playable 데이터

이들에서 보통:

```
audioKey (예: UI_Plot_M1_7_027)
textId   (ConfigLanguage 키)
characterId
```

같은 참조 구조가 발견된다.

### 4.3 현재 단계에서 반드시 지켜야 할 것

* **wav 파일명(자동 생성 키) 그대로 유지**
* **폴더 구조(m1/m2/…) 유지**

이 두 가지만 지키면, 나중에 자동/반자동 매칭이 가능하다.

---

## 5. 현재까지의 작업 상태 정리

* 음성(AudioClip) 추출: **완료**
* 추출 결과 품질: **정상 재생 확인**
* 매칭 데이터 조사: **보류 (후속 단계)**

---

## 6. 다음 단계 로드맵

### 6.1 다음 목표

**장비 이미지 추출 → DB 장비 페이지 적용**

### 6.2 이미지 추출 대상 폴더 (예정)

```
Patch\Asset\ui\
Patch\Asset\equipment\
Patch\Asset\item\
```

### 6.3 목표 결과

* Sprite / Texture2D 추출 → png
* `equipment_db.json`의 `icon_key`와 연결
* 장비 DB 페이지에서 실제 이미지 표시 확인

### 6.4 이후 확장

* 캐릭터 이미지
* 아이템 이미지
* 스킬 아이콘
* UI 공용 아이콘

---

## 7. 다음 작업 재개 시 시작 문구 예시

> "다음 단계: 장비 이미지 추출부터 진행"

위 문구로 시작하면, 본 문서를 기준으로 바로 이어서 작업 가능.

---

(END)
