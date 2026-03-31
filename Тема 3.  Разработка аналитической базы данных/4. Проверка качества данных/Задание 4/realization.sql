(SELECT min(u.registration_dt) AS datestamp,
        'earliest user registration' AS info
 FROM VT260324747F4B__STAGING.users u)
UNION ALL
(SELECT max(u.registration_dt),
        'latest user registration'
 FROM VT260324747F4B__STAGING.users u)
UNION ALL
(SELECT min(g.registration_dt),
        'earliest group creation'
 FROM VT260324747F4B__STAGING.groups g)
UNION ALL
(SELECT max(g.registration_dt),
        'latest group creation'
 FROM VT260324747F4B__STAGING.groups g)
UNION ALL
(SELECT min(d.message_ts),
        'earliest dialog message'
 FROM VT260324747F4B__STAGING.dialogs d)
UNION ALL
(SELECT max(d.message_ts),
        'latest dialog message'
 FROM VT260324747F4B__STAGING.dialogs d);
