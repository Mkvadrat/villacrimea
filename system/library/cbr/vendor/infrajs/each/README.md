[![Latest Stable Version](https://poser.pugx.org/infrajs/each/v/stable)](https://packagist.org/packages/infrajs/each) [![Total Downloads](https://poser.pugx.org/infrajs/each/downloads)](https://packagist.org/packages/infrajs/each)

### Each::exec - Collback for each element of array or for simple value.

> The function processes the transmitted data as if it were an indexed array of unit length;
> If you really gave an indexed array, then an anonymous function run for each element of the index array; 
> If you gave any type except an index array, the data is processed as an indexed array with one element and passed to the anonymous function will run for one item.
> For an element with a null value the function will not run.

```
$counter = 0;
$el = [2, [4, 6], 5];
Each::exec($el, function ($b) use (&$counter) {
    $counter++;
    if ($counter === 3) {
        assert(6 === $b);
    }
});
```

### Each::isAssoc - this method checks whether the passed argument is an associative array.

```
$elements = ['9' => '42', 8, 4, 5, 3];
assert(true === Each::isAssoc($elements));
$elements = [9, 8, 4, 5, 3];
assert(false === Each::isAssoc($elements));
```

### Each::isInt - this method checks the passed argument is a number.

> If the passed text argument in the form of a number (without spaces or additional text), then the method will work with parameters such as the number.

```
$el = 12;
assert(true === Each::isInt($el));
$el = '12';
assert(true === Each::isInt($el));
```

### Each::isEqual - this method checks whether the passed arguments by reference.

> The method returns true only when the two variables are references to each other.

```
$a = 1;
$b = &$a;
assert(true === Each::isEqual($a, $b));
```

### Testing

##### Testing run the file test.php:

> positive answer

```
{result:1}
```

> negative answer

```
{"result":0, msg:"В работе кода произошел сбой."}
```

##### Testing with PHPunit

```
phpunit --bootstrap Each.php tests/EachTest
```


### Each::exec - callback-функция для каждого элемента индексного массива или для простого значения.

> Функция обрабатывает переданные данные, как будто они переданы в индексном массиве единичной длины;
> Если действительно передан индексный массив, то анонимная фукцния сработает для каждого элемента индексного массива; 
> Если передан любой тип, кроме индексного массива, то данные обработаются как индексный массив с одним переданным элементом и анонимная функция запустится для одного элемента.
> Для элемента со значением null функция запускаться не будет.

```
$counter = 0;
$el = [2, [4, 6], 5];
Each::exec($el, function ($b) use (&$counter) {
    $counter++;
    if ($counter === 3) {
        assert(6 === $b);
    }
});
```

### Each::isAssoc - данный метод проверяет, является ли переданный аргумент ассоциативным массивом.

```
$elements = ['9' => '42', 8, 4, 5, 3];
assert(true === Each::isAssoc($elements));
$elements = [9, 8, 4, 5, 3];
assert(false === Each::isAssoc($elements));
```

### Each::isInt - данный метод проверяет, является переданный аргумент числом.

> Если передан текстовый аргумент в виде числа (без пробелов и дополнительного текста), то метод отработает с таким параметром, как с числом.

```
$el = 12;
assert(true === Each::isInt($el));
$el = '12';
assert(true === Each::isInt($el));
```

### Each::isEqual - данный метод проверяет, являются ли переданные аргументы ссылками.

> Метод возвращает true, только когда две переменные являются ссылками друг на друга.

```
$a = 1;
$b = &$a;
assert(true === Each::isEqual($a, $b));
```

### Тест

##### Для тестирования откройте в браузере test.php:

> при положительном ответе вы увидете следующее сообщение

```
{"result":1}
```

> если в работе кода произойдет сбой, то сообщение будет

```
{"result":0, msg:"В работе кода произошел сбой."}
```

##### Для тестирование с помощью PHPunit

```
phpunit --bootstrap Each.php tests/EachTest
```
