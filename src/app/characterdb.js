let allCharacters = [];

async function loadData() {
  try {
    const res = await fetch('data/characters.json');
    if (!res.ok) {
      throw new Error('데이터 로드 실패: ' + res.status);
    }

    allCharacters = await res.json();
    applyFilters();
  } catch (err) {
    console.error(err);

    const list = document.getElementById('list');
    list.innerHTML = '<p>데이터를 불러오는 데 실패했습니다.</p>';
  }
}

function applyFilters() {
  const searchInput = document.getElementById('search');
  const raritySelect = document.getElementById('rarity');
  const elementSelect = document.getElementById('element');
  const roleSelect = document.getElementById('role');

  const q = searchInput.value.trim().toLowerCase();
  const rarity = raritySelect.value;
  const element = elementSelect.value;
  const role = roleSelect.value;

  const filtered = allCharacters.filter(ch => {
    if (rarity && ch.rarity !== rarity) {
      return false;
    }

    if (element && ch.element !== element) {
      return false;
    }

    if (role && ch.role !== role) {
      return false;
    }

    if (q) {
      const haystack = (
        ch.name +
        ch.rarity +
        ch.element +
        ch.role +
        (ch.tags || []).join(' ')
      ).toLowerCase();

      if (!haystack.includes(q)) {
        return false;
      }
    }

    return true;
  });

  renderList(filtered);
}

function renderList(list) {
  const container = document.getElementById('list');
  const countEl = document.getElementById('count');

  countEl.textContent = `검색 결과: ${list.length}명`;
  container.innerHTML = '';

  if (list.length === 0) {
    container.innerHTML = '<p>조건에 맞는 캐릭터가 없습니다.</p>';
    return;
  }

  list.forEach(ch => {
    const div = document.createElement('div');
    div.className = 'card';

    const tags = (ch.tags || []).map(t => `<span class="badge">${t}</span>`).join(' ');

    div.innerHTML = `
      <h3>${ch.name} (${ch.rarity})</h3>
      <p>속성: ${ch.element} / 역할: ${ch.role}</p>
      <p>${tags}</p>
    `;

    container.appendChild(div);
  });
}

function setupEvents() {
  document.getElementById('search').addEventListener('input', applyFilters);
  document.getElementById('rarity').addEventListener('change', applyFilters);
  document.getElementById('element').addEventListener('change', applyFilters);
  document.getElementById('role').addEventListener('change', applyFilters);
}

setupEvents();
loadData();
