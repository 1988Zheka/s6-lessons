(SELECT
    max(u.registration_dt) < now() AS 'no future dates',
    min(u.registration_dt) > '2020-09-03' AS 'no false-start dates',
    'users' AS dataset
 FROM VT260324747F4B__STAGING.users u)
UNION ALL
(SELECT
    max(g.registration_dt) < now(),
    min(g.registration_dt) > '2020-09-03',
    'groups'
 FROM VT260324747F4B__STAGING.groups g)
UNION ALL
(SELECT
    max(d.message_ts) < now(),
    min(d.message_ts) > '2020-09-03',
    'dialogs'
 FROM VT260324747F4B__STAGING.dialogs d);
