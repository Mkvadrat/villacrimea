<?php
use \infrajs\hash\Hash;
require_once __DIR__ . '/../Hash.php';
class HashTest extends PHPUnit_Framework_TestCase
{
	public function testHash()
	{
		$a = [];
		$this->assertTrue('40cd750bba9870f18aada2478b24840a' === Hash::make($a));
		$a[] = 'Передали текст';
		$this->assertTrue('c6a45e965497496002680ac385b17b05' === Hash::make($a));
		$a[] = function(){};
		$this->assertTrue('c6008bd78fcdc1a923c65ecddc8f67ba' === Hash::make($a));
		$a[] = new Hash;
		$this->assertTrue('58843b5ad3da812f794515abe816c979' === Hash::make($a));
		$b = new Hash;
		$this->assertTrue('639cb6369416f4178c26b9fabba9a38f' === Hash::make($b));
		$b = true;
		$this->assertTrue('431014e4a761ea216e9a35f20aaec61c' === Hash::make($b));
		$b = false;
		$this->assertTrue('a2072c8a50f1127f73a55a6b5f574da7' === Hash::make($b));
		$b = 15;
		$this->assertTrue('3ae4e7e87b9038a299ee40119700914a' === Hash::make($b));
		$b = 'текст';
		$this->assertTrue('c899e3abc57a1426a4404a74e0a5a0cf' === Hash::make($b));
		$b = function(){};
		$this->assertTrue('b35bcc328f12fccc6d8c7f7ed98cd0f1' === Hash::make($b));
	}
}