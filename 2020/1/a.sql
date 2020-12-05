SELECT a.val * b.val AS multiplier, a.val, b.val
FROM one a, one b
WHERE
	a.val <= b.val AND
	a.val + b.val = 2020;
