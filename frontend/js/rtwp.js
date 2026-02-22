const API = 'http://127.0.0.1:5000';
Chart.defaults.color = '#6b7280';
Chart.defaults.borderColor = 'rgba(255,255,255,0.05)';

let allData = [];

document.addEventListener('DOMContentLoaded', () => {
    loadRtwpStats();
    loadRtwpData();
});

async function loadRtwpStats() {
    try {
        const res = await fetch(`${API}/api/rtwp/stats`);
        const data = await res.json();
        document.getElementById('total-rtwp').textContent = data.total.toLocaleString();

        let major = 0, minor = 0;
        data.by_severity.forEach(s => {
            if (s.severity === 'Major') major = s.count;
            if (s.severity === 'Minor') minor = s.count;
        });
        document.getElementById('major-rtwp').textContent = major.toLocaleString();
        document.getElementById('minor-rtwp').textContent = minor.toLocaleString();

        const filtered = data.by_severity.filter(s => s.severity !== 'Severity');
        new Chart(document.getElementById('chart-severity'), {
            type: 'doughnut',
            data: {
                labels: filtered.map(s => s.severity),
                datasets: [{ data: filtered.map(s => s.count), backgroundColor: ['#ef4444','#f59e0b','#10b981','#3b82f6'], borderWidth: 2, borderColor: '#1a1d2e' }]
            },
            options: { responsive: true, cutout: '65%', plugins: { legend: { position: 'bottom' } } }
        });
    } catch(e) { console.error(e); }
}

async function loadRtwpData() {
    try {
        const res = await fetch(`${API}/api/rtwp?limit=200`);
        allData = await res.json();

        let cleared = allData.filter(r => r.clearance_status === 'Cleared').length;
        document.getElementById('cleared-rtwp').textContent = cleared.toLocaleString();

        const uncleared = allData.filter(r => r.clearance_status === 'Uncleared').length;
        new Chart(document.getElementById('chart-status'), {
            type: 'bar',
            data: {
                labels: ['Cleared', 'Uncleared'],
                datasets: [{ data: [cleared, uncleared], backgroundColor: ['#10b981', '#ef4444'], borderRadius: 6 }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { grid: { color: 'rgba(255,255,255,0.05)' } }, x: { grid: { display: false } } } }
        });

        renderTable(allData);
    } catch(e) { console.error(e); }
}

function renderTable(data) {
    const tbody = document.getElementById('rtwp-table-body');
    if (!data.length) {
        tbody.innerHTML = '<tr><td colspan="8" style="text-align:center;padding:30px;color:#6b7280">Aucun résultat</td></tr>';
        return;
    }
    tbody.innerHTML = data.slice(0, 100).map((row, i) => `
        <tr>
            <td style="color:#6b7280">${i + 1}</td>
            <td>${formatDate(row.first_occurred)}</td>
            <td>${row.bbu_name || '-'}</td>
            <td>${row.cell_name || '-'}</td>
            <td>${row.name || '-'}</td>
            <td><span class="badge badge-${(row.severity || '').toLowerCase()}">${row.severity || '-'}</span></td>
            <td><span class="badge badge-${(row.clearance_status || '').toLowerCase()}">${row.clearance_status || '-'}</span></td>
            <td>${row.alarm_duration || '-'}</td>
        </tr>
    `).join('');
}

function formatDate(d) {
    if (!d) return '-';
    try { return new Date(d).toLocaleString('fr-FR'); } catch { return d; }
}

function applyFilters() {
    const sev = document.getElementById('filter-severity').value;
    const status = document.getElementById('filter-status').value;
    const site = document.getElementById('filter-site').value.toLowerCase();
    let filtered = allData;
    if (sev) filtered = filtered.filter(r => r.severity === sev);
    if (status) filtered = filtered.filter(r => r.clearance_status === status);
    if (site) filtered = filtered.filter(r => (r.bbu_name || '').toLowerCase().includes(site));
    renderTable(filtered);
}

function resetFilters() {
    document.getElementById('filter-severity').value = '';
    document.getElementById('filter-status').value = '';
    document.getElementById('filter-site').value = '';
    renderTable(allData);
}