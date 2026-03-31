DROP TABLE IF EXISTS VT260324747F4B__DWH.l_user_message CASCADE;
DROP TABLE IF EXISTS VT260324747F4B__DWH.l_groups_dialogs CASCADE;
DROP TABLE IF EXISTS VT260324747F4B__DWH.l_admins CASCADE;

CREATE TABLE VT260324747F4B__DWH.l_user_message (
    hk_l_user_message int NOT NULL,
    hk_user_id int NOT NULL CONSTRAINT fk_l_user_message_user REFERENCES VT260324747F4B__DWH.h_users (hk_user_id),
    hk_message_id int NOT NULL CONSTRAINT fk_l_user_message_message REFERENCES VT260324747F4B__DWH.h_dialogs (hk_message_id),
    load_dt timestamp,
    load_src varchar(20),
    CONSTRAINT C_PRIMARY PRIMARY KEY (hk_l_user_message) DISABLED
)
ORDER BY load_dt
SEGMENTED BY hk_user_id ALL NODES
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

CREATE TABLE VT260324747F4B__DWH.l_groups_dialogs (
    hk_l_groups_dialogs int NOT NULL,
    hk_group_id int NOT NULL CONSTRAINT fk_l_groups_dialogs_group REFERENCES VT260324747F4B__DWH.h_groups (hk_group_id),
    hk_message_id int NOT NULL CONSTRAINT fk_l_groups_dialogs_message REFERENCES VT260324747F4B__DWH.h_dialogs (hk_message_id),
    load_dt timestamp,
    load_src varchar(20),
    CONSTRAINT C_PRIMARY PRIMARY KEY (hk_l_groups_dialogs) DISABLED
)
ORDER BY load_dt
SEGMENTED BY hk_l_groups_dialogs ALL NODES
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

CREATE TABLE VT260324747F4B__DWH.l_admins (
    hk_l_admin_id int NOT NULL,
    hk_group_id int NOT NULL CONSTRAINT fk_l_admins_group REFERENCES VT260324747F4B__DWH.h_groups (hk_group_id),
    hk_user_id int NOT NULL CONSTRAINT fk_l_admins_user REFERENCES VT260324747F4B__DWH.h_users (hk_user_id),
    load_dt timestamp,
    load_src varchar(20),
    CONSTRAINT C_PRIMARY PRIMARY KEY (hk_l_admin_id) DISABLED
)
ORDER BY load_dt
SEGMENTED BY hk_l_admin_id ALL NODES
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);
