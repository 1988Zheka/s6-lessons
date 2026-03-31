(SELECT COUNT(1) AS total,
        COUNT(DISTINCT u.id) AS uniq,
        'users' AS dataset
 FROM VT260324747F4B__STAGING.users u)
UNION ALL
(SELECT COUNT(1),
        COUNT(DISTINCT g.id),
        'groups'
 FROM VT260324747F4B__STAGING.groups g)
UNION ALL
(SELECT COUNT(1),
        COUNT(DISTINCT d.message_id),
        'dialogs'
 FROM VT260324747F4B__STAGING.dialogs d);
