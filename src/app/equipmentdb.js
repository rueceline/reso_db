let equipmentData = [];

async function loadEquipment() {
  try {
    const res = await fetch('../../public/data/equipment.json')
    
    if (!res.ok) {
      throw new Error(`데이터 로드 실패: ${res.status}`);
    }

    equipmentData = await res.json();
    populateFilters();
    applyFilters();
  } catch (err) {
    console.error(err);
    const list = document.getElementById('equipmentList');
    list.innerHTML = '<tr><td colspan="10" class="loading">데이터를 불러오는 데 실패했습니다.</td></tr>';
  }
}

function populateFilters() {
  const raritySelect = document.getElementById('rarityFilter');
  const factionSelect = document.getElementById('factionFilter');
  const typeSelect = document.getElementById('typeFilter');

  const rarityOptions = Array.from(new Set(equipmentData.map(item => item.rarity))).sort();
  const factionOptions = Array.from(new Set(equipmentData.map(item => item.faction))).sort();  
  const typeOptions = Array.from(new Set(equipmentData.map(item => item.category))).sort();

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
    if (type && item.category !== type) return false;

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
    tbody.innerHTML = '<tr><td colspan="10" class="loading">조건에 맞는 장비가 없습니다.</td></tr>';
    return;
  }

  list.forEach(item => {
    const tr = document.createElement('tr');

    // 레어리티 기반 행 클래스 (배경색용)
    const rarityKey = (item.rarity || '').toLowerCase();
    if (rarityKey) {
      tr.classList.add(`rarity-row-${rarityKey}`);
    }

    tr.innerHTML = `
      <td class="equip-image">
        <!-- 이미지 경로는 그대로, 크기는 CSS에서 키움 -->
        <img src="../../public/assets/3.png" class="equip-img">
      </td>

      <!-- 이름 -->
      <td class="equipment-name">${formatName(item.name || '')}</td>

      <!-- 희귀도 -->
      <td>
        <span class="rarity-badge rarity-${rarityKey}">
          ${item.rarity || ''}
        </span>
      </td>

      <!-- 분류: category -->
      <td>${item.category || ''}</td>

      <!-- 소속: faction -->
      <td>${item.faction || ''}</td>

      <!-- 속성: stat_type -->
      <td>${item.stat_type || ''}</td>

      <!-- 초기값: min_value -->
      <td>${item.min_value ?? ''}</td>

      <!-- 대값: max_value -->
      <td>${item.max_value ?? ''}</td>

      <!-- 옵션: effect -->
      <td class="equipment-effect">${formatMultiline(item.effect)}</td>

      <!-- 입수 방법: obtain -->
      <td class="equipment-source">${formatMultiline(item.obtain)}</td>
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
