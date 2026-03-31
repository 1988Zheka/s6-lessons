INSERT INTO VT260324747F4B__DWH.h_users(hk_user_id, user_id, registration_dt, load_dt, load_src)
SELECT hash(id) AS hk_user_id,
       id AS user_id,
       registration_dt,
       now() AS load_dt,
       's3' AS load_src
FROM VT260324747F4B__STAGING.users
WHERE hash(id) NOT IN (SELECT hk_user_id FROM VT260324747F4B__DWH.h_users);

INSERT INTO VT260324747F4B__DWH.h_groups(hk_group_id, group_id, registration_dt, load_dt, load_src)
SELECT hash(id) AS hk_group_id,
       id AS group_id,
       registration_dt,
       now() AS load_dt,
       's3' AS load_src
FROM VT260324747F4B__STAGING.groups
WHERE hash(id) NOT IN (SELECT hk_group_id FROM VT260324747F4B__DWH.h_groups);

INSERT INTO VT260324747F4B__DWH.h_dialogs(hk_message_id, message_id, message_ts, load_dt, load_src)
SELECT hash(message_id) AS hk_message_id,
       message_id,
       message_ts,
       now() AS load_dt,
       's3' AS load_src
FROM VT260324747F4B__STAGING.dialogs
WHERE hash(message_id) NOT IN (SELECT hk_message_id FROM VT260324747F4B__DWH.h_dialogs);
