let equipmentData = [];

async function loadEquipment() {
  try {
    const res = await fetch('data/equipment.json');
    if (!res.ok) {
      throw new Error(`데이터 로드 실패: ${res.status}`);
    }

    equipmentData = await res.json();
    populateFilters();
    applyFilters();
  } catch (err) {
    console.error(err);
    const list = document.getElementById('equipmentList');
    list.innerHTML = '<tr><td colspan="7" class="loading">데이터를 불러오는 데 실패했습니다.</td></tr>';
  }
}

function populateFilters() {
  const raritySelect = document.getElementById('rarityFilter');
  const factionSelect = document.getElementById('factionFilter');
  const typeSelect = document.getElementById('typeFilter');

  const rarityOptions = Array.from(new Set(equipmentData.map(item => item.rarity))).sort();
  const factionOptions = Array.from(new Set(equipmentData.map(item => item.faction))).sort();
  const typeOptions = Array.from(new Set(equipmentData.map(item => item.type))).sort();

  fillSelect(raritySelect, rarityOptions, '전체');
  fillSelect(factionSelect, factionOptions, '전체');
  fillSelect(typeSelect, typeOptions, '전체');

  raritySelect.addEventListener('change', applyFilters);
  factionSelect.addEventListener('change', applyFilters);
  typeSelect.addEventListener('change', applyFilters);
}

function fillSelect(select, options, defaultLabel) {
  select.innerHTML = '';
  const defaultOption = document.createElement('option');
  defaultOption.value = '';
  defaultOption.textContent = defaultLabel;
  select.appendChild(defaultOption);

  options.forEach(value => {
    const opt = document.createElement('option');
    opt.value = value;
    opt.textContent = value;
    select.appendChild(opt);
  });
}

function applyFilters() {
  const rarity = document.getElementById('rarityFilter').value;
  const faction = document.getElementById('factionFilter').value;
  const type = document.getElementById('typeFilter').value;

  const filtered = equipmentData.filter(item => {
    if (rarity && item.rarity !== rarity) return false;
    if (faction && item.faction !== faction) return false;
    if (type && item.type !== type) return false;
    return true;
  });

  renderList(filtered);
}

function renderList(list) {
  const tbody = document.getElementById('equipmentList');
  const countEl = document.getElementById('equipmentCount');

  countEl.textContent = `총 ${list.length}개`;
  tbody.innerHTML = '';

  if (!list.length) {
    tbody.innerHTML = '<tr><td colspan="7" class="loading">조건에 맞는 장비가 없습니다.</td></tr>';
    return;
  }

  list.forEach(item => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td class="equipment-name">${formatName(item.name)}</td>
      <td><span class="rarity-badge rarity-${item.rarity.toLowerCase()}">${item.rarity}</span></td>
      <td>${item.faction}</td>
      <td>${item.type}</td>
      <td>
        <div class="stat-label">${item.stat_type}</div>
        <div class="stat-range">${item.min_value} ~ ${item.max_value}</div>
      </td>
      <td class="equipment-effect">${formatMultiline(item.effect)}</td>
      <td class="equipment-source">${formatMultiline(item.source)}</td>
    `;

    tbody.appendChild(tr);
  });
}

function formatName(name) {
  return name.split('\n').map(part => `<span>${part}</span>`).join('<br>');
}

function formatMultiline(text) {
  return text ? text.replace(/\n/g, '<br>') : '';
}

loadEquipment();
