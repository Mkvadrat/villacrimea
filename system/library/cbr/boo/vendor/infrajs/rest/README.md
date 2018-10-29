# Набор js и php методов для работы с адресной срокой в REST стиле.

Функция ```Rest::get``` не имеет встроенного кэша. Срабатывает только один обработчик и возвращается результат его работы.

```php
use infrajs\rest\Rest;
// pos/Kemppi/Minarc
$ans = Rest::get(function() {
	// Срабатывает когда ничего другова не сработало
	$ans = array('msg' => 'ок');
	return $ans;
}, 'pos', function(){
	// Срабатывает для крошки pos
}, 'test', [function(){
		// Срабатывает для крошки test
	}, 'one', function(){
		// Срабатывает для адреса test/one
}], function($param1 = false, $param2 = false){
	// Срабатывает для любой крошки
}); 	
return Ans::ret($ans);
```