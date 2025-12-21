/**
 * DOM 공통 유틸
 * - 페이지 파일에서 반복되는 querySelector / textContent / innerHTML 설정을 통일한다.
 * - 렌더링 편의용이며, 데이터 로딩(fetch)은 여기서 하지 않는다.
 */

export function qs(sel, root = document) {
  return root.querySelector(sel);
}

export function qsa(sel, root = document) {
  return Array.from(root.querySelectorAll(sel));
}

export function byId(id) {
  return document.getElementById(id);
}

export function setText(idOrEl, text) {
  const el = typeof idOrEl === "string" ? byId(idOrEl) : idOrEl;
  if (!el) { return; }
  el.textContent = text == null ? "" : String(text);
}

export function setHtml(idOrEl, html) {
  const el = typeof idOrEl === "string" ? byId(idOrEl) : idOrEl;
  if (!el) { return; }
  el.innerHTML = html == null ? "" : String(html);
}

export function clearChildren(el) {
  if (!el) { return; }
  while (el.firstChild) {
    el.removeChild(el.firstChild);
  }
}

export function setHidden(idOrEl, hidden) {
  const el = typeof idOrEl === "string" ? byId(idOrEl) : idOrEl;
  if (!el) { return; }
  el.hidden = !!hidden;
}
