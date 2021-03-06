# Boo-кэш - управляемый кэш сайта
 Кэширования результата при работе с удалёнными хранилищами, обращение, к которым требует значительного времени, такими как Google Drive. 

Рекомендуется использовать на небольших сайтах (10 000 кэшей), когда администратор вносит изменения на удалённом хранилище и сбросив нужный кэш применяет изменения на сайте. Целесообразно применять в тех случаях, когда нет возможности настроить обратную связь для автоматического обновлениея кэша. Ручное и избирательное управление кэшем является ключевой особенностью **Boo-кэша**. 

Поддерживаются вложенные кэши и повторное исплользование, когда в дереве зависимостей у экземпляра кэша несколько родителей. Во всех случае кэшируемая функция выполняется один раз. При обновлении зависимых кэшей обновляются и все родительские кэши.

## Установка через composer

```json
{
	"require":{
		"akiyatkin/boo":"~1"
	}
}
```

1. Должен быть **.htaccess** с настроенной переадресацией для адресов начинающихся с символов ```!~-``` согласно правилам [infrajs/router](https://github.com/infrajs/router), чтобы в проекте работал адрес /-boo/. Совместим с любыми другими роутерами или фреймворками.
```
RewriteEngine on
RewriteCond %{REQUEST_URI} ^/[-~\!]
RewriteRule ^(.*)$ vendor/infrajs/router/index.php [L,QSA]
```

2. Необходимо настроить права для упраления кэшем. Для этого создать в корне проекта конфигурационный файл **.infra.json**. Для сервера 127.0.0.1 разрешение есть автоматически, но на других серверах нужно будет указать ip адрес в секции access.test или ```true``` для общего доступа к интерфейсу управления кэшем. Доступом управляет расширение [infrajs/access](https://github.com/infrajs/access).

Файл **.infra.json**
```json
{
	"access":{
		"test":true
	}
}
```

3. В скрипте, который работает с расширением Boo рабочая дирректория должна вести на корень проекта. Если скрипт лежит во вложенной папке должна быть команда ```chdir('../');``` согласно требованиям [infrajs/path](https://github.com/infrajs/path)

4. Для того чтобы работал параметр ```?-boo``` в адресной строке скрипта требуется выполнение ```Router::init()```, или обращение по адресу с символом **-**, тогда роутер подключается автоматически и рабочую дирректрию также не нужно менять она всегда будет от корня, вне зависимости от расположения файла скрипта.

## Использование

```php
use akiyatkin\boo\Cache;

$args = array($one, $two); //простые, необязательные параметры идентифицирующие кэш
$data = Cache::exec('Group title', function ($one, $two) {
    $data = sleep(5); //Что-то долгое
    //$one и $two чаще всего какие-то идентификаторы.
    //Можно указать более понятный title для кэша текущей обработки
    Cache::setTitle($title);
    return $data; //нерекурсивные кэшируемые данные
}, $args);
``` 
Функция сохраняет кэши и позволяет выборочно обновлять их по адресу ```/-boo/``` (С правами тестировщика [infrajs/access](https://github.com/infrajs/access) и настроенным роутером [infrajs/router](https://github.com/infrajs/router))

Для работы GET-параметра **-boo** скрипт должен вызываться или с символа **-** или содержать [инициализацию роутера](https://github.com/infrajs/router/blob/master/README.md#%D0%98%D0%BD%D0%B8%D1%86%D0%B8%D0%B0%D0%BB%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F-%D1%80%D0%BE%D1%83%D1%82%D0%B5%D1%80%D0%B0-%D0%B2-%D1%81%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D0%B5). 

## Записки разработчика
Cache сохраняет кэш на жёстком диске в папке ```!boo/```. Описание кэш-элементов для которых предусмотрена админка (BooCache) хранится в ```!boo/.tree.json```.

item.result, item.conds, item.childs восстанавливаются и их без выполнения нельзя получить из исходных данных кэш-функции. Если есть conds, то childs не нужен.

Лучше аргументы conds получитать в проверяющей функции, чем сохранять в condsarg. condsarg закэишрует значения аргументов и может сложиться, что будут использоваться старые значения, например если аргументы формируются из конфига. Запомнились в кэше, а потом конфиг был изменнён и обновления сайта произойдёт только после -update=true, так как аргумент к проверяющей фукции будет неизменным.


```/-update/``` - Выполняет установку без удаления кэша

```?-update=true``` - Удаляет весь кэш

```test = true``` - Проверки запускаются, кэш перегенерируется для обычного пользователя

```debug = true```, ```?-access = true```, ```admin = true``` - Запускают проверки, некоторые кэши не сохраняются и не обновляются. Например несжатый html и css в кэш не попадают.

```?-boo = true|root|id``` - Работает только с ```test=true```. Проверки запускаются, некоторые проверки true. - элементы перегенерируются для пользователя.

```-start/start``` - Работает только с ```test=true```. Все проверки true - все эелменты перегенерируются.

При обращение к базе данных срабатывает заголовок nostore, который отменяет сохранение кэша и нужно вызвать ```Nostore::off()``` если обращение к базе не должно запрещать кэш и написать проверку обновления используемых из базы данных.

Флаги кэш-элементов
- nostore
- checked
- loaded
- start

Динамические свойства кэш-элементов
- childs
- time
- timer
- result
- conds

Статические свойства кэш-элементов
- id
- gid
- cls
- src
- gtitle
- title
- condfn
- condargs
- args
- hash

## Контакты
Задать вопрос можно в группе ВКонтакта [https://vk.com/infrajs](https://vk.com/infrajs) или в [issues](https://github.com/akiyatkin/boo/issues) на github.
