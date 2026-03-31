INSERT INTO VT260324747F4B__DWH.l_admins(hk_l_admin_id, hk_group_id, hk_user_id, load_dt, load_src)
SELECT hash(hg.hk_group_id, hu.hk_user_id), hg.hk_group_id, hu.hk_user_id, now(), 's3'
FROM VT260324747F4B__STAGING.groups AS g
LEFT JOIN VT260324747F4B__DWH.h_users AS hu ON g.admin_id = hu.user_id
LEFT JOIN VT260324747F4B__DWH.h_groups AS hg ON g.id = hg.group_id
WHERE hash(hg.hk_group_id, hu.hk_user_id) NOT IN (SELECT hk_l_admin_id FROM VT260324747F4B__DWH.l_admins);

INSERT INTO VT260324747F4B__DWH.l_groups_dialogs(hk_l_groups_dialogs, hk_message_id, hk_group_id, load_dt, load_src)
SELECT hash(hd.hk_message_id, hg.hk_group_id), hd.hk_message_id, hg.hk_group_id, now(), 's3'
FROM VT260324747F4B__STAGING.dialogs AS d
LEFT JOIN VT260324747F4B__DWH.h_groups AS hg ON d.message_group = hg.group_id
LEFT JOIN VT260324747F4B__DWH.h_dialogs AS hd ON d.message_id = hd.message_id
WHERE d.message_group IS NOT NULL
  AND hash(hd.hk_message_id, hg.hk_group_id) NOT IN (SELECT hk_l_groups_dialogs FROM VT260324747F4B__DWH.l_groups_dialogs);

INSERT INTO VT260324747F4B__DWH.l_user_message(hk_l_user_message, hk_user_id, hk_message_id, load_dt, load_src)
SELECT hash(hd.hk_message_id, hu.hk_user_id), hd.hk_message_id, hu.hk_user_id, now(), 's3'
FROM VT260324747F4B__STAGING.dialogs AS d
LEFT JOIN VT260324747F4B__DWH.h_users AS hu ON d.message_from = hu.user_id
LEFT JOIN VT260324747F4B__DWH.h_dialogs AS hd ON d.message_id = hd.message_id
WHERE d.message_group IS NOT NULL
  AND hash(hd.hk_message_id, hu.hk_user_id) NOT IN (SELECT hk_l_user_message FROM VT260324747F4B__DWH.l_user_message)
  AND hu.hk_user_id IS NOT NULL;
