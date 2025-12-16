# reso_db

> Resonance(레조넌스) 게임 데이터 기반 DB / GitHub Pages 사이트 소스 저장소  
> 비공식 · 비영리 팬 프로젝트

---

## 📌 프로젝트 소개

**reso_db**는 Resonance(레조넌스) 게임의 데이터를 기반으로  
웹에서 열람 가능한 DB 사이트를 구축하기 위한 데이터 저장소입니다.

- 게임 원본 리소스를 기반으로 데이터 추출
- 한국어 번역 데이터 적용
- JSON 기반 정적 데이터 구조 (별도 서버/DB 불필요)
- GitHub Pages를 통한 웹 제공

---

## 🌐 GitHub Pages

- Pages URL: https://yourname.github.io/reso_db  
- 데이터 위치: `public/data/`

> 이 저장소는 GitHub Pages를 빌드하기 위한 **소스 저장소**입니다.

---

## 📁 프로젝트 구조

```text
reso_db/
├─ public/
│  └─ data/
│     ├─ CN/          # 원본 데이터 (중국어)
│     ├─ KR/          # 한국어 적용 데이터
│     └─ EN/ JP/ ...  # (선택)
├─ scripts/           # 데이터 처리용 스크립트
└─ README.md
```

---

## ✅ 요구 사항

- Windows
- Node.js 18 LTS 이상
- npm
- Python 3.10 이상

```bat
node -v
npm -v
python --version
```

---

## 🚀 사용 방법 (단계별)

### 1단계. rsns-unpack 설치

```bat
npm i -g @tsuk1ko/rsns-unpack
```

또는 설치 없이 실행:

```bat
npx rsns-unpack
```

---

### 2단계. 게임 데이터 추출

`reso_db` 루트에서 실행:

```bat
npx rsns-unpack .\public\data .\public\data\KR
```

- `public/data` : 원본 게임 데이터
- `public/data/KR` : 번역/문자열 리소스

> ⚠️ `rsns-unpack`은 `--help` 옵션을 지원하지 않으며  
> 반드시 **저장 경로 2개**를 인자로 전달해야 합니다.

---

### 3단계. 한국어 데이터 적용

원본 데이터와 `ConfigLanguage.json`을 이용해  
한국어가 적용된 JSON 파일을 생성합니다.

```bat
python scripts/translate_data_only_v1.py
```

- 데이터 구조는 변경하지 않음
- 문자열 value만 정확히 일치하는 경우 번역 적용
- 결과는 `public/data/KR`에 저장

---

## 📝 데이터 처리 규칙

- 데이터 구조 기준은 게임 내부 `.lua` 스크립트를 따릅니다
- 키/필드 구조는 변경하지 않습니다
- 문자열 value만 번역 대상으로 처리합니다
- 매칭되지 않은 문자열은 원문을 유지합니다

---

## 🧱 DB 사용 방식

본 프로젝트에서는 **JSON 파일 자체를 DB로 사용**합니다.

- 파일 간 참조 관계는 구조 기반으로 자동 처리
- 별도의 RDBMS는 사용하지 않습니다

---

## ⚠️ 면책 조항 (Disclaimer)

- 본 프로젝트는 **비공식 팬 프로젝트**입니다.
- 모든 게임 데이터 및 리소스의 저작권은 원작사에 귀속됩니다.
- 비상업적·연구·정보 제공 목적에 한해 사용됩니다.
- 권리자의 요청이 있을 경우 언제든지 중단될 수 있습니다.

---

## 🙏 Credits

- Data extraction: rsns-unpack  
  https://www.npmjs.com/package/@tsuk1ko/rsns-unpack

---

## 📌 진행 상황

- [x] 데이터 추출
- [x] 한국어 번역 적용
- [ ] 데이터 참조 자동화
- [ ] DB 사이트 UI 구성
