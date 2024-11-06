<?php

use Swoole\Database\PDOPool;
class MysqlSwow extends MysqlSwoole
{

    public function __construct($size)
    {
        $this->pool = new Pool("mysql:host=bw-database;dbname=hello_world", 'benchmarkdbuser', 'benchmarkdbpass', $size);
    }

}