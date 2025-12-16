# Resonance Solstice Database

> 레조넌스 게임 데이터 기반 DB / GitHub Pages 사이트 소스 저장소  
> 비공식 · 비영리 팬 프로젝트

![Last updated](https://img.shields.io/github/last-commit/ruecelinee/reso_db?label=Last%20updated)

Pages URL: https://rueceline.github.io/reso_db/

---

## 📌 프로젝트 소개

**reso_db**는 게임 레조넌스 솔스티스의 데이터를 기반으로 웹에서 열람 가능한 DB 사이트를 구축하기 위한 데이터 저장소입니다.

---

## 📁 프로젝트 구조

```text
reso_db/
├─ public/
│  └─ data/
│     ├─ CN/          # 원본 데이터 (중국어)
│     ├─ KR/          # 한국어 적용 데이터
├─ scripts/           # 데이터 처리용 스크립트
└─ README.md

```

---

## ✅ 요구 사항

- Windows
- Node.js 18 LTS 이상
- Python 3.10 이상

---

## 🚀 사용 방법

### 1단계. rsns-unpack 설치

```bat
npm i -g @tsuk1ko/rsns-unpack
```

---

### 2단계. 게임 데이터 추출

`reso_db` 루트에서 실행:

```bat
npx rsns-unpack .\public\data .\public\data\KR
```

- `public/data` : 원본 게임 데이터
- `public/data/KR` : 번역/문자열 리소스

---

### 3단계. 한국어 데이터 적용

번역 파일을 이용해 한국어가 적용된 JSON 파일을 생성합니다.

```bat
python scripts/apply_ko_translation.py
```

---

## ⚠️ Disclaimer

- 본 프로젝트는 **비공식 팬 프로젝트**입니다.
- 모든 게임 데이터 및 리소스의 저작권은 원작사에 귀속됩니다.
- 비상업적·연구·정보 제공 목적에 한해 사용됩니다.
- 권리자의 요청이 있을 경우 언제든지 중단될 수 있습니다.

---

## 🙏 Credits

- Data extraction: rsns-unpack  
  https://www.npmjs.com/package/@tsuk1ko/rsns-unpack
  
- lua data unpack: rsns-data
  https://github.com/milkory/rsns-data
  
---

## 📌 진행 상황

- [x] 데이터 추출
- [x] 한국어 번역 적용
- [ ] 데이터 참조 자동화
- [ ] DB 사이트 UI 구성
