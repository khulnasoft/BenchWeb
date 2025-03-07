<?php
return array(
	"database" => [
		'default' => [
			"wrapper" => "\\Ubiquity\\db\\providers\\pdo\\PDOWrapper",
			"type" => "mysql",
			"dbName" => "hello_world",
			"serverName" => "bw-database", // bw-database
			"port" => 3306,
			"user" => "benchmarkdbuser", // benchmarkdbuser
			"password" => "benchmarkdbpass", // benchmarkdbpass
			"options" => [
				\PDO::ATTR_PERSISTENT => true,
				\PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
			],
			"cache" => false
		]
	],
	"test" => false,
	"debug" => false,
	"cache" => [
		"directory" => "cache/",
		"system" => "Ubiquity\\cache\\system\\ArrayCache",
		"params" => []
	],
	"mvcNS" => [
		"models" => "models",
		"controllers" => "controllers",
		"rest" => ""
	]
);
