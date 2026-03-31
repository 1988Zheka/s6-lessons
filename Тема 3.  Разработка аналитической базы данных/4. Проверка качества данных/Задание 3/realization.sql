SELECT COUNT(g.group_name),
       COUNT(DISTINCT hash(g.group_name))
FROM VT260324747F4B__STAGING.groups g;
