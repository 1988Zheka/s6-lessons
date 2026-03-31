DROP TABLE IF EXISTS VT260324747F4B__DWH.h_users CASCADE;
DROP TABLE IF EXISTS VT260324747F4B__DWH.h_groups CASCADE;
DROP TABLE IF EXISTS VT260324747F4B__DWH.h_dialogs CASCADE;

CREATE TABLE VT260324747F4B__DWH.h_users (
    hk_user_id int NOT NULL,
    user_id int,
    registration_dt timestamp,
    load_dt timestamp,
    load_src varchar(20),
    CONSTRAINT C_PRIMARY PRIMARY KEY (hk_user_id) DISABLED
)
ORDER BY load_dt
SEGMENTED BY hk_user_id ALL NODES
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

CREATE TABLE VT260324747F4B__DWH.h_groups (
    hk_group_id int NOT NULL,
    group_id int,
    registration_dt timestamp,
    load_dt timestamp,
    load_src varchar(20),
    CONSTRAINT C_PRIMARY PRIMARY KEY (hk_group_id) DISABLED
)
ORDER BY load_dt
SEGMENTED BY hk_group_id ALL NODES
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

CREATE TABLE VT260324747F4B__DWH.h_dialogs (
    hk_message_id int NOT NULL,
    message_id int,
    message_ts timestamp,
    load_dt timestamp,
    load_src varchar(20),
    CONSTRAINT C_PRIMARY PRIMARY KEY (hk_message_id) DISABLED
)
ORDER BY load_dt
SEGMENTED BY hk_message_id ALL NODES
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);
