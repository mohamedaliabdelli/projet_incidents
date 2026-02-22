import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('mysql+pymysql://root:Dali-123@localhost/incidents_reseau')

date_cols=['last_occurred', 'cleared_on', 'first_occurred', 'acknowledged_on','received_on', 'occurrence_notify_time', 'clearance_notify_time']
def clean_date(val):
    if val == '-' or val is None:
        return None
    try:
        return pd.to_datetime(val, dayfirst=True)
    except:
        return None
    
cols_vswr_clock=[
    'alarm_type', 'severity', 'alarm_source', 'comment', 'name','last_occurred', 'cleared_on', 'location_information', 'ne_type',
    'mo_name', 'occurrence_times', 'first_occurred', 'alarm_id',
    'acknowledged_on', 'cleared_by', 'acknowledged_by', 'clearance_status',
    'acknowledgement_status', 'source_system', 'rru_name', 'rf_site_name',
    'cell_name', 'bbu_name', 'enodeb_id', 'gnodeb_id', 'log_serial_number',
    'dev_root_csn', 'user_label', 'equipment_alarm_serial_number',
    'additional_information', 'maintenance_status', 'list_serial_number',
    'trouble_ticket_id', 'maintenance_region', 'subnet', 'type',
    'request_id', 'common_alarm_identifier', 'toggling_times',
    'external_resource_id', 'link_name', 'link_type', 'auto_clear',
    'clearance_type', 'object_type', 'operation_impact_flag', 'received_on',
    'ne_address', 'alarm_duration', 'associated_alarm_group_id',
    'ne_virtual_mark', 'occurrence_notify_time', 'clearance_notify_time'
]

cols_rtwp_impact=[
    'alarm_type', 'severity', 'alarm_source', 'name', 'comment',
    'last_occurred', 'cleared_on', 'location_information', 'occurrence_times',
    'ne_type', 'mo_name', 'first_occurred', 'acknowledged_on', 'cleared_by',
    'acknowledged_by', 'clearance_status', 'acknowledgement_status',
    'additional_information', 'type', 'alarm_duration', 'alarm_id',
    'associated_alarm_group_id', 'auto_clear', 'bbu_name', 'clearance_type',
    'common_alarm_identifier', 'dev_root_csn', 'equipment_alarm_serial_number',
    'external_resource_id', 'list_serial_number', 'log_serial_number',
    'maintenance_status', 'ne_address', 'object_type', 'operation_impact_flag',
    'rru_name', 'received_on', 'request_id', 'toggling_times', 'user_label',
    'enodeb_id', 'gnodeb_id', 'source_system', 'rf_site_name', 'cell_name',
    'trouble_ticket_id', 'maintenance_region', 'subnet', 'link_name',
    'link_type', 'ne_virtual_mark', 'occurrence_notify_time', 'clearance_notify_time'
]

cols_env=[
    'alarm_type', 'severity', 'alarm_source', 'name', 'last_occurred',
    'cleared_on', 'location_information', 'comment', 'mo_name',
    'occurrence_times', 'alarm_id', 'first_occurred', 'acknowledged_on',
    'cleared_by', 'acknowledged_by', 'clearance_status', 'rru_name',
    'acknowledgement_status', 'bbu_name', 'enodeb_id', 'log_serial_number',
    'user_label', 'equipment_alarm_serial_number', 'additional_information',
    'ne_type', 'maintenance_status', 'source_system', 'rf_site_name',
    'cell_name', 'gnodeb_id', 'dev_root_csn', 'list_serial_number',
    'trouble_ticket_id', 'maintenance_region', 'subnet', 'type', 'request_id',
    'common_alarm_identifier', 'toggling_times', 'external_resource_id',
    'link_name', 'link_type', 'auto_clear', 'clearance_type', 'object_type',
    'operation_impact_flag', 'received_on', 'ne_address', 'alarm_duration',
    'associated_alarm_group_id', 'ne_virtual_mark', 'occurrence_notify_time',
    'clearance_notify_time'
]

def apply_clean_date(df):
    for col in date_cols:
        if col in df.columns:
            df[col]=df[col].apply(clean_date)
    return df

def import_vswr():
    df = pd.read_excel('data/raw/VSWR.xlsx', skiprows=5 , header=None)
    df.columns =cols_vswr_clock
    df = apply_clean_date(df)
    df.to_sql('vswr', engine, if_exists='append', index=False)
    print("VSWR importe !")

def import_clock():
    df = pd.read_excel('data/raw/clock.xlsx', skiprows=5 , header=None)
    df.columns = cols_vswr_clock
    df=apply_clean_date(df)
    df.to_sql('clock', engine, if_exists='append', index=False)
    print("Clock importe !")

def import_rtwp():
    df = pd.read_excel('data/raw/RTWP (interférence).xlsx', skiprows=5, header=None)
    df.columns = cols_rtwp_impact
    df=apply_clean_date(df)
    df.to_sql('rtwp', engine, if_exists='append', index=False)
    print("RTWP importe !")

def import_impact_service():
    df = pd.read_excel('data/raw/impact service.xlsx', skiprows=5, header=None)
    df.columns = cols_rtwp_impact
    df=apply_clean_date(df)
    df.to_sql('impact_service', engine, if_exists='append', index=False)
    print("Impact Service importe !")

def import_env():
    df = pd.read_excel('data/raw/alarmes environnement.xlsx', skiprows=5, header=None)
    df.columns = cols_env
    df=apply_clean_date(df)
    df.to_sql('alarmes_environnement', engine, if_exists='append', index=False)
    print("Alarmes ENV importees !")

if __name__ == '__main__':
    import_vswr()
    import_clock()
    import_rtwp()
    import_impact_service()
    import_env()
    print("Tous les fichiers importes avec succes !")