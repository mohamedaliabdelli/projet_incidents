const API = 'http://127.0.0.1:5000';

const CHART_COLORS = ['#ef4444', '#f59e0b', '#10b981', '#3b82f6', '#8b5cf6'];

Chart.defaults.color = '#6b7280';
Chart.defaults.borderColor = 'rgba(255,255,255,0.05)';

async function loadStats(table, elementId) {
    try {
        const res = await fetch(`${API}/api/${table}/stats`);
        const data = await res.json();
        document.getElementById(elementId).textContent = data.total.toLocaleString();
        return data;
    } catch (e) {
        document.getElementById(elementId).textContent = 'Erreur';
        return null;
    }
}

function makeDonut(canvasId, data) {
    if (!data) return;
    const filtered = data.by_severity.filter(s => s.severity !== 'Severity');
    new Chart(document.getElementById(canvasId), {
        type: 'doughnut',
        data: {
            labels: filtered.map(s => s.severity),
            datasets: [{
                data: filtered.map(s => s.count),
                backgroundColor: CHART_COLORS,
                borderWidth: 2,
                borderColor: '#1a1d2e'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom', labels: { padding: 15, font: { size: 12 } } }
            },
            cutout: '65%'
        }
    });
}

async function init() {
    const vswr = await loadStats('vswr', 'total-vswr');
    const clock = await loadStats('clock', 'total-clock');
    const rtwp = await loadStats('rtwp', 'total-rtwp');
    await loadStats('alarmes_environnement', 'total-env');
    await loadStats('impact_service', 'total-impact');

    makeDonut('chart-vswr', vswr);
    makeDonut('chart-clock', clock);

    // Bar chart total par type
    new Chart(document.getElementById('chart-total'), {
        type: 'bar',
        data: {
            labels: ['VSWR', 'Clock', 'RTWP', 'ENV', 'Impact'],
            datasets: [{
                label: 'Total incidents',
                data: [
                    vswr ? vswr.total : 0,
                    clock ? clock.total : 0,
                    rtwp ? rtwp.total : 0,
                    0, 0
                ],
                backgroundColor: CHART_COLORS,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: {
                y: { grid: { color: 'rgba(255,255,255,0.05)' } },
                x: { grid: { display: false } }
            }
        }
    });
}

init();