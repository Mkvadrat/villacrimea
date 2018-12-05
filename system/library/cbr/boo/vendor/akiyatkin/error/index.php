<?php
use infrajs\ans\Ans;
use infrajs\access\Access;



Access::admin(true);

$ans = array();
$src = ini_get("error_log");

if (Ans::REQ('clear') && is_file($src)) {
	file_put_contents($src, '');
}

if (!is_file($src)) {
	return Ans::log($ans, 'Файл с логами не найден '.$src);
}
echo $src;
echo '<p><form method="POST"><input type="hidden" name="clear" value="true"><button type="submit">очистить</button></form></p>';
echo '<pre>';
$ar = file($src);
$ar = array_reverse($ar);
echo implode($ar);
