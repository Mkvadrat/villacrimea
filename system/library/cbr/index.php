<?php
use infrajs\ans\Ans;
use akiyatkin\cbr\CBR;

$ans = array();

$data = CBR::get();

$ans['data'] = $data;

return Ans::ret($ans);
