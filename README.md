# Resonance Solstice Database

> 레조넌스 게임 데이터 기반 DB / GitHub Pages 사이트 소스 저장소  
> 비공식 · 비영리 팬 프로젝트

![Last updated](https://img.shields.io/github/last-commit/rueceline/reso_db?label=Last%20updated)

Pages URL: https://rueceline.github.io/reso_db/

---

## 📌 프로젝트 소개

**reso_db**는 게임 레조넌스 솔스티스의 데이터를 기반으로 웹에서 열람 가능한 DB 사이트를 구축하기 위한 데이터 저장소입니다.

---

## ✅ 요구 사항

- Node.js 18 LTS 이상

---

## 🚀 사용 방법

### 1단계. pnpm 설치

```bat
npm install -g pnpm
```

---

### 2단계. rsns-unpack 로컬 설치

```bat
pnpm add @tsuk1ko/rsns-unpack
```

---

### 3단계. 게임 데이터 추출

`reso_db` 루트에서 실행:

```bat
pnpm exec rsns-unpack .\public\data\CN .\public\data\KR
```

- `public/data/CN` : 원본 게임 데이터
- `public/data/KR` : 번역/문자열 리소스

---

### 4단계. 한국어 데이터 적용

번역 파일을 이용해 한국어가 적용된 JSON 파일을 생성합니다.

```bat
node scripts/apply_kr_translation.js
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