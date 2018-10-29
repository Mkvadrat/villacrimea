<?php
namespace akiyatkin\cbr;
require(DIR_SYSTEM . 'library/cbr/boo/vendor/autoload.php');
use infrajs\router\Router;
use akiyatkin\boo\MemCache;
use infrajs\nostore\Nostore;

class CBR {
	public static function get()
	{
		$data = MemCache::exec('Курсы валют', function () {
			//$src = "http://www.cbr.ru/scripts/XML_daily.asp";
			$src = "https://www.cbr-xml-daily.ru/daily.xml";
			$cbr = simplexml_load_file($src);
			if (!$cbr) {
				Nostore::on();
				return array();
			}
			
			$attr = $cbr->attributes();
			$t = strtotime($attr['Date'][0]);
			$data = array();
			$data['date'] = $t;
			$data['list'] = array();
			for ($i = 0, $l = sizeof($cbr->Valute); $i < $l; $i++) {
				$v = $cbr->Valute[$i][0];
				$data["list"][(string)$v->CharCode] = array(
					"char" => (string)$v->CharCode,
					"title" => (string)$v->Name,
					"value" => (string)$v->Value
				);
			}
			
			return $data;
		}, array(), ['akiyatkin\boo\Cache','getDurationTime'], ['8:00']);
		return $data;
	}
}
