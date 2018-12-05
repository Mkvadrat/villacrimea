<?php
namespace infrajs\each;
if (!is_file('vendor/autoload.php')) {
    chdir('../../../'); //Согласно фактическому расположению файла
    require_once('vendor/autoload.php');
}

    /**
     * Проверка на ассоциативный массив.
     * Метод возвращает true только в том случае, если массив ассоциативный.
     */
    $elements = ['9' => '42', 8, 4, 5, 3];
    assert(true === Each::isAssoc($elements));
    $elements = 10;
    assert(null === Each::isAssoc($elements));
    $elements = [9, 8, 4, 5, 3];
    assert(false === Each::isAssoc($elements));

    /**
     * Проверка на число.
     * Если передано число в текстовом формате, то метод должен отработать
     * с этим аргументом как с числом.
     */
    $el = '';
    assert(false === Each::isInt($el));
    $el = 12;
    assert(true === Each::isInt($el));
    $el = '12';
    assert(true === Each::isInt($el));
    $el = '12 ';
    assert(false === Each::isInt($el));

    /**
     * Проверка ссылок друг на друга.
     * Метод возвращает true, когда две переменные являются ссылками друг на друга.
     */
    $a = 1;
    $b = 1;
    assert(false === Each::isEqual($a, $b));
    $a = 1;
    $b = $a;
    assert(false === Each::isEqual($a, $b));
    $a = 1;
    $b = &$a;
    assert(true === Each::isEqual($a, $b));

    /**
     * Проверяем, количество вызовов и на какой элемент попадаем при определенном количестве вызовов.
     * Для индексного массива количество итераций анонимной функции должно равняться количеству элементов в массиве.
     * Если в индексном массиве находится вложенный индексный массив, то анонимная функция должна вызываться и
     * для каждого индекса вложенного массива.
     * Если методу передан простой элемент или ассоциативный массив, вызов анонимной функции
     * должен произойти только один раз.
     */
    $counter = 0;
    $el = ['oduvanio', 'mail'];
    Each::exec($el, function &() use (&$counter) {
        $r = null;
        $counter++;
        return $r;
    });
    assert(2 === $counter);
    $counter = 0;
    $el = [2, [4, 6], 5];
    Each::exec($el, function &($b) use (&$counter) {
        $r = null;
        $counter++;
        if ($counter === 3) {
            assert(6 === $b);
        }
        return $r;
    });
    assert(4 === $counter);
    $counter = 0;
    $el = 1;
    Each::exec($el, function &() use (&$counter) {
        $r = null;
        $counter++;
        return $r;
    });
    assert(1 === $counter);
    $el = 'test';
    Each::exec($el, function &() use (&$counter) {
        $r = null;
        $counter++;
        return $r;
    });
    assert(2 === $counter);
    $el = ['name' => 'oduvanio', 'email' => 'mail'];
    Each::exec($el, function &() use (&$counter) {
        $r = null;
        $counter++;
        return $r;
    });
    assert(3 === $counter);

    echo '{"result": 1}';