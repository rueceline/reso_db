# 공통 규칙 (초안)

이 문서는 파일별 스키마에서 반복되는 규칙을 한 곳에 모아두기 위한 용도입니다.
필요할 때마다 업데이트하면 됩니다.

## 타입 표기
- `u8/u16/u32/s32/f32` 등: 원본 BinaryConfig 기반 추정 타입
- `string`: string pool 인덱스 또는 이미 풀린 문자열(파일별로 다를 수 있음)
- `[T]`: 리스트
- `[any]`: 아직 구조가 확정되지 않은 배열/오브젝트

## ID / FK 표기
- `XFactory.someId -> YFactory.id` 형태로 적음
- `hit_ratio`, `gap`, `total`은 자동 추정 결과의 참고치

## 확정도 태그(권장)
- confirmed: 확정
- likely: 가능성 높음
- unknown: 미확정
