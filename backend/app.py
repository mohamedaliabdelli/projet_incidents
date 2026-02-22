from flask import Flask, jsonify, request
from flask_cors import CORS
from sqlalchemy import create_engine, text

app = Flask(__name__)
CORS(app, origins=["http://127.0.0.1:5500", "http://localhost:5500"])

engine = create_engine('mysql+pymysql://root:Dali-123@localhost/incidents_reseau')

# ─── FONCTION STATS ───────────────────────────────────────────

def get_stats(table):
    with engine.connect() as conn:
        total = conn.execute(text(f'SELECT COUNT(*) as total FROM {table}')).fetchone()
        by_severity = conn.execute(text(f'SELECT severity, COUNT(*) as count FROM {table} GROUP BY severity')).fetchall()
    return {
        'total': total._mapping['total'],
        'by_severity': [dict(r._mapping) for r in by_severity]
    }

def get_data(table, limit=50):
    with engine.connect() as conn:
        result = conn.execute(text(f'SELECT * FROM {table} LIMIT {limit}'))
        return [dict(r._mapping) for r in result]

# ─── HOME ──────────────────────────────────────────────────────

@app.route('/')
def home():
    return "Backend DRS_003 en marche"

# ─── STATS ────────────────────────────────────────────────────

@app.route('/api/vswr/stats')
def vswr_stats():
    return jsonify(get_stats('vswr'))

@app.route('/api/clock/stats')
def clock_stats():
    return jsonify(get_stats('clock'))

@app.route('/api/rtwp/stats')
def rtwp_stats():
    return jsonify(get_stats('rtwp'))

@app.route('/api/impact_service/stats')
def impact_stats():
    return jsonify(get_stats('impact_service'))

@app.route('/api/alarmes_environnement/stats')
def env_stats():
    return jsonify(get_stats('alarmes_environnement'))

# ─── DONNÉES ──────────────────────────────────────────────────

@app.route('/api/vswr')
def vswr_data():
    limit = request.args.get('limit', 50)
    return jsonify(get_data('vswr', limit))

@app.route('/api/clock')
def clock_data():
    limit = request.args.get('limit', 50)
    return jsonify(get_data('clock', limit))

@app.route('/api/rtwp')
def rtwp_data():
    limit = request.args.get('limit', 50)
    return jsonify(get_data('rtwp', limit))

@app.route('/api/impact_service')
def impact_data():
    limit = request.args.get('limit', 50)
    return jsonify(get_data('impact_service', limit))

@app.route('/api/alarmes_environnement')
def env_data():
    limit = request.args.get('limit', 50)
    return jsonify(get_data('alarmes_environnement', limit))

# ─── LANCEMENT ────────────────────────────────────────────────

if __name__ == '__main__':
    app.run(debug=True, port=5000)