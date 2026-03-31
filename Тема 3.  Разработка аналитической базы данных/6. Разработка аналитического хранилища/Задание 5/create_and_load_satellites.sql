-- s_admins
DROP TABLE IF EXISTS VT260324747F4B__DWH.s_admins CASCADE;
CREATE TABLE VT260324747F4B__DWH.s_admins (
    hk_admin_id bigint NOT NULL CONSTRAINT fk_s_admins_l_admins REFERENCES VT260324747F4B__DWH.l_admins (hk_l_admin_id),
    is_admin boolean, admin_from datetime, load_dt datetime, load_src varchar(20)
) ORDER BY load_dt SEGMENTED BY hk_admin_id ALL NODES
PARTITION BY load_dt::date GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

INSERT INTO VT260324747F4B__DWH.s_admins(hk_admin_id, is_admin, admin_from, load_dt, load_src)
SELECT la.hk_l_admin_id, True, hg.registration_dt, now(), 's3'
FROM VT260324747F4B__DWH.l_admins AS la
LEFT JOIN VT260324747F4B__DWH.h_groups AS hg ON la.hk_group_id = hg.hk_group_id;

-- s_group_name
DROP TABLE IF EXISTS VT260324747F4B__DWH.s_group_name CASCADE;
CREATE TABLE VT260324747F4B__DWH.s_group_name (
    hk_group_id bigint NOT NULL CONSTRAINT fk_s_group_name REFERENCES VT260324747F4B__DWH.h_groups (hk_group_id),
    group_name varchar(100), load_dt datetime, load_src varchar(20)
) ORDER BY load_dt SEGMENTED BY hk_group_id ALL NODES
PARTITION BY load_dt::date GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

INSERT INTO VT260324747F4B__DWH.s_group_name(hk_group_id, group_name, load_dt, load_src)
SELECT hk_group_id, group_name, now(), 's3'
FROM VT260324747F4B__STAGING.groups AS g
LEFT JOIN VT260324747F4B__DWH.h_groups AS hg ON g.id = hg.group_id;

-- s_group_private_status
DROP TABLE IF EXISTS VT260324747F4B__DWH.s_group_private_status CASCADE;
CREATE TABLE VT260324747F4B__DWH.s_group_private_status (
    hk_group_id bigint NOT NULL CONSTRAINT fk_s_group_private_status REFERENCES VT260324747F4B__DWH.h_groups (hk_group_id),
    is_private boolean, load_dt datetime, load_src varchar(20)
) ORDER BY load_dt SEGMENTED BY hk_group_id ALL NODES
PARTITION BY load_dt::date GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

INSERT INTO VT260324747F4B__DWH.s_group_private_status(hk_group_id, is_private, load_dt, load_src)
SELECT hk_group_id, is_private, now(), 's3'
FROM VT260324747F4B__STAGING.groups AS g
LEFT JOIN VT260324747F4B__DWH.h_groups AS hg ON g.id = hg.group_id;

-- s_dialog_info
DROP TABLE IF EXISTS VT260324747F4B__DWH.s_dialog_info CASCADE;
CREATE TABLE VT260324747F4B__DWH.s_dialog_info (
    hk_message_id bigint NOT NULL CONSTRAINT fk_s_dialog_info REFERENCES VT260324747F4B__DWH.h_dialogs (hk_message_id),
    message varchar(1000), message_from int, message_to int, load_dt datetime, load_src varchar(20)
) ORDER BY load_dt SEGMENTED BY hk_message_id ALL NODES
PARTITION BY load_dt::date GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

INSERT INTO VT260324747F4B__DWH.s_dialog_info(hk_message_id, message, message_from, message_to, load_dt, load_src)
SELECT hk_message_id, message, message_from, message_to, now(), 's3'
FROM VT260324747F4B__STAGING.dialogs AS d
LEFT JOIN VT260324747F4B__DWH.h_dialogs AS hg ON d.message_id = hg.message_id;

-- s_user_socdem
DROP TABLE IF EXISTS VT260324747F4B__DWH.s_user_socdem CASCADE;
CREATE TABLE VT260324747F4B__DWH.s_user_socdem (
    hk_user_id bigint NOT NULL CONSTRAINT s_user_socdem REFERENCES VT260324747F4B__DWH.h_users (hk_user_id),
    country varchar(100), age int, load_dt datetime, load_src varchar(20)
) ORDER BY load_dt SEGMENTED BY hk_user_id ALL NODES
PARTITION BY load_dt::date GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

INSERT INTO VT260324747F4B__DWH.s_user_socdem(hk_user_id, country, age, load_dt, load_src)
SELECT hk_user_id, country, age, now(), 's3'
FROM VT260324747F4B__STAGING.users AS u
LEFT JOIN VT260324747F4B__DWH.h_users AS hg ON u.id = hg.user_id;

-- s_user_chatinfo
DROP TABLE IF EXISTS VT260324747F4B__DWH.s_user_chatinfo CASCADE;
CREATE TABLE VT260324747F4B__DWH.s_user_chatinfo (
    hk_user_id bigint NOT NULL CONSTRAINT s_user_chatinfo REFERENCES VT260324747F4B__DWH.h_users (hk_user_id),
    chat_name varchar(1000), load_dt datetime, load_src varchar(20)
) ORDER BY load_dt SEGMENTED BY hk_user_id ALL NODES
PARTITION BY load_dt::date GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

INSERT INTO VT260324747F4B__DWH.s_user_chatinfo(hk_user_id, chat_name, load_dt, load_src)
SELECT hk_user_id, chat_name, now(), 's3'
FROM VT260324747F4B__STAGING.users AS u
LEFT JOIN VT260324747F4B__DWH.h_users AS hg ON u.id = hg.user_id;
