SELECT
	a.val * b.val * c.val AS multiplier,
	a.val,
	b.val,
	c.val
FROM one a, one b, one c
WHERE
	a.val <= b.val AND
	b.val <= c.val AND
	a.val + b.val + c.val = 2020;
