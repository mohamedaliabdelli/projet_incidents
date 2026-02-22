from flask import Blueprint, jsonify
from sqlalchemy import create_engine, text

engine=create_engine('mysql+pymysql://root:Dali-123@localhost/incidents_reseau')

vswr_bp=Blueprint('vswr', __name__)

@vswr_bp.route('/api/vswr', methods=['GET'])
def get_vswr():
    with engine.connect() as conn:
        result = conn.execute(text('SELECT * FROM vswr LIMIT 100 '))
        rows = [dict(row._mapping)for row in result]
    return jsonify(rows)

@vswr_bp.route('/api/vswr/stats', methods=['GET'])
def get_vswr_stats():
    with engine.connect() as conn:
        total =conn.execute(text('SELECT COUNT(*) AS total FROM vswr')).fetchone()
        by_severity=conn.execute(text('SELECT severity, COUNT(*) as count FROM vswr GROUP BY severity')).fetchall()
    return jsonify({
        'total': total._mapping['total'],
        'by_severity': [dict(r._mapping) for r in by_severity]
    })