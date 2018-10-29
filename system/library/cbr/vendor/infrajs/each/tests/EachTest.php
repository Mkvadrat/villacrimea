<?php
use \infrajs\each\Each;
require_once __DIR__ . '/../Each.php';

class EachTest extends PHPUnit_Framework_TestCase
{
    public function testEach(){
        /**
         * Проверка на ассоциативный массив.
         * Метод возвращает true только в том случае, если массив ассоциативный.
         */
        $elements = ['9' => '42', 8, 4, 5, 3];
        $res = Each::isAssoc($elements);
        $this->assertTrue($res);
        $elements = 10;
        $res = Each::isAssoc($elements);
        $this->assertTrue(null === $res);
        $elements = [9, 8, 4, 5, 3];
        $res = Each::isAssoc($elements);
        $this->assertTrue(false === $res);

        /**
         * Проверка на число.
         * Если передано число в текстовом формате, то метод должен отработать
         * с этим аргументом как с числом.
         */
        $el = '';
        $res = Each::isInt($el);
        $this->assertTrue(false === $res);
        $el = 12;
        $res = Each::isInt($el);
        $this->assertTrue(true === $res);
        $el = '12';
        $res = Each::isInt($el);
        $this->assertTrue(true === $res);
        $el = '12 ';
        $res = Each::isInt($el);
        $this->assertTrue(false === $res);

        /**
         * Проверка ссылок друг на друга.
         * Метод возвращает true, когда две переменные являются ссылками друг на друга.
         */
        $a = 1;
        $b = 1;
        $res = Each::isEqual($a, $b);
        $this->assertTrue(false === $res);
        $a = 1;
        $b = $a;
        $res = Each::isEqual($a, $b);
        $this->assertTrue(false === $res);
        $a = 1;
        $b = &$a;
        $res = Each::isEqual($a, $b);
        $this->assertTrue(true === $res);

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
        $this->assertTrue(2 === $counter);
        $counter = 0;
        $el = [2, [4, 6], 5];
        Each::exec($el, function ($b) use (&$counter) {
            $counter++;
            if ($counter === 3) {
                $this->assertTrue(6 === $b);
            }
        });
        $this->assertTrue(4 === $counter);
        $counter = 0;
        $el = 1;
        Each::exec($el, function () use (&$counter) {
            $counter++;
        });
        $this->assertTrue(1 === $counter);
        $el = 'test';
        Each::exec($el, function () use (&$counter) {
            $counter++;
        });
        $this->assertTrue(2 === $counter);
        $el = ['name' => 'oduvanio', 'email' => 'mail'];
        Each::exec($el, function () use (&$counter) {
            $counter++;
        });
        $this->assertTrue(3 === $counter);
    }
}