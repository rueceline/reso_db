// app/utils/text.js

/**
 * 텍스트/마크업 변환 유틸
 * - 문자열을 DOM에 넣기 전에 필요한 변환을 한 곳에서 담당한다.
 */

/**
 * <color=#RRGGBB>...</color> 태그를 span 스타일로 변환한다.
 * - 중첩 태그는 단순 치환 기준으로 처리한다.
 */
export function formatColorTagsToHtml(text) {
  if (text == null) { return ""; }

  let out = String(text);

  // 1) JSON에 문자열로 남아있는 "\\n" → 실제 개행
  out = out.replace(/\\n/g, '\n');

  // 2) <color=#xxxxxx> → span 변환
  out = out.replace(/<color=#[0-9a-fA-F]{6}>/g, m => {
    const color = m.slice(7, 14);
    return `<span style="color:${color}">`;
  });

  out = out.replace(/<\/color>/g, "</span>");

  // 3) 개행 문자 → <br>
  out = out.replace(/\n/g, '<br>');

  return out;
}

/**
 * HTML escape
 */
export function escapeHtml(s) {
  return String(s ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}