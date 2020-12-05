SELECT
	a.val * b.val * c.val,
	a.val,
	b.val,
	c.val
FROM one a, one b, one c
WHERE a.val + b.val + c.val = 2020;
