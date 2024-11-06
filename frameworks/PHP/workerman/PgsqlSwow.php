<?php

use Swoole\Database\PDOPool;
class PgsqlSwow extends MysqlSwow
{

    public function __construct($size)
    {
        $this->pool = new Pool("pgsql:host=bw-database;dbname=hello_world", 'benchmarkdbuser', 'benchmarkdbpass', $size);
    }

}