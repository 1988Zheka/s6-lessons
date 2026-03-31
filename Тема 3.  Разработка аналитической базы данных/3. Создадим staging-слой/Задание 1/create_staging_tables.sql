DROP TABLE IF EXISTS VT260324747F4B__STAGING.dialogs CASCADE;
DROP TABLE IF EXISTS VT260324747F4B__STAGING.groups CASCADE;
DROP TABLE IF EXISTS VT260324747F4B__STAGING.users CASCADE;

CREATE TABLE VT260324747F4B__STAGING.users (
    id int NOT NULL,
    chat_name varchar(200),
    registration_dt timestamp,
    country varchar(200),
    age int,
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
)
ORDER BY id
SEGMENTED BY hash(id) ALL NODES KSAFE 1;

CREATE TABLE VT260324747F4B__STAGING.groups (
    id int NOT NULL,
    admin_id int,
    group_name varchar(100),
    registration_dt timestamp,
    is_private boolean,
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
)
ORDER BY id, admin_id
SEGMENTED BY hash(id) ALL NODES KSAFE 1
PARTITION BY registration_dt::date
GROUP BY calendar_hierarchy_day(registration_dt::date, 3, 2);

CREATE TABLE VT260324747F4B__STAGING.dialogs (
    message_id int NOT NULL,
    message_ts timestamp,
    message_from int,
    message_to int,
    message varchar(1000),
    message_group int,
    CONSTRAINT C_PRIMARY PRIMARY KEY (message_id) DISABLED
)
ORDER BY message_id
SEGMENTED BY hash(message_id) ALL NODES KSAFE 1
PARTITION BY message_ts::date
GROUP BY calendar_hierarchy_day(message_ts::date, 3, 2);
