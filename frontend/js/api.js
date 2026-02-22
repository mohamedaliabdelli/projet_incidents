const API_BASE_URL = 'http://127.0.0.1:5000';

async function apiCall(endpoint) {
    try {
        const res = await fetch(`${API_BASE_URL}/api${endpoint}`);
        if (!res.ok) throw new Error('Erreur API');
        return await res.json();
    } catch (error) {
        console.error('API call failed:', error);
        throw error;
    }
}

async function getClockStats() { return apiCall('/clock/stats'); }
async function getClockIncidents(params = {}) { return apiCall('/clock'); }

async function getVswrStats() { return apiCall('/vswr/stats'); }
async function getVswrIncidents(params = {}) { return apiCall('/vswr'); }

async function getRTWPStats() { return apiCall('/rtwp/stats'); }
async function getRTWPIncidents(params = {}) { return apiCall('/rtwp'); }

async function getEnvStats() { return apiCall('/alarmes_environnement/stats'); }
async function getEnvIncidents(params = {}) { return apiCall('/alarmes_environnement'); }

async function getImpactStats() { return apiCall('/impact_service/stats'); }
async function getImpactIncidents(params = {}) { return apiCall('/impact_service'); }