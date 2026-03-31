(SELECT COUNT(1), 'missing group admin info' AS info
 FROM VT260324747F4B__STAGING.groups g LEFT JOIN VT260324747F4B__STAGING.users u ON g.admin_id = u.id
 WHERE u.id IS NULL)
UNION ALL
(SELECT COUNT(1), 'missing sender info'
 FROM VT260324747F4B__STAGING.dialogs d LEFT JOIN VT260324747F4B__STAGING.users u ON d.message_from = u.id
 WHERE u.id IS NULL)
UNION ALL
(SELECT COUNT(1), 'missing receiver info'
 FROM VT260324747F4B__STAGING.dialogs d LEFT JOIN VT260324747F4B__STAGING.users u ON d.message_to = u.id
 WHERE u.id IS NULL)
UNION ALL
(SELECT COUNT(1), 'norm receiver info'
 FROM VT260324747F4B__STAGING.dialogs d LEFT JOIN VT260324747F4B__STAGING.users u ON d.message_to = u.id
 WHERE u.id IS NOT NULL);
