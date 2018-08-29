<?php
// HTTP
define('HTTP_SERVER', 'http://villacrimea.loc/');

// HTTPS
define('HTTPS_SERVER', 'http://villacrimea.loc/');

// DIR
define('DIR_APPLICATION', $_SERVER['DOCUMENT_ROOT']. '/catalog/');
define('DIR_SYSTEM', $_SERVER['DOCUMENT_ROOT']. '/system/');
define('DIR_IMAGE', $_SERVER['DOCUMENT_ROOT']. '/image/');
define('DIR_LANGUAGE', $_SERVER['DOCUMENT_ROOT']. '/catalog/language/');
define('DIR_TEMPLATE', $_SERVER['DOCUMENT_ROOT']. '/catalog/view/theme/');
define('DIR_CONFIG', $_SERVER['DOCUMENT_ROOT']. '/system/config/');
define('DIR_CACHE', $_SERVER['DOCUMENT_ROOT']. '/system/storage/cache/');
define('DIR_DOWNLOAD', $_SERVER['DOCUMENT_ROOT']. '/system/storage/download/');
define('DIR_LOGS', $_SERVER['DOCUMENT_ROOT']. '/system/storage/logs/');
define('DIR_MODIFICATION', $_SERVER['DOCUMENT_ROOT']. '/system/storage/modification/');
define('DIR_UPLOAD', $_SERVER['DOCUMENT_ROOT']. '/system/storage/upload/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '1234');
define('DB_DATABASE', 'villacrimea');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');
