# Работа с данными от Центрального Банка России

[XML от cbr.ru](http://www.cbr.ru/scripts/Root.asp?PrtId=SXML)

## Установка через composer

```json
{
	"akiyatkin/cbr":"~1"
}
```
## Использование в php

```
use akiyatkin\cbr\CBR;

$data = CBR::get(); //Актуальны курсы валют на сегодня. С кэшем на 1 час.
echo '<pre>';
print_r($data);
```

## Использование с [infrajs/controller](https://github.com/infrajs/controller)

Подключить слой

```json
{
	"external":"-cbr/today.layer.json"
}
```