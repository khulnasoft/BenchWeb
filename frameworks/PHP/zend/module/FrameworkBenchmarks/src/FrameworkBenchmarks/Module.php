<?php

namespace BenchWeb;

/**
 * Module class for the benchmarks of BenchWeb
 *
 * @author Marco Pivetta <ocramius@gmail.com>
 * @link   http://www.techempower.com/benchmarks
 */
class Module
{
    /**
     * @return array
     */
    public function getConfig()
    {
        return array(
            'router' => array(
                'routes' => array(
                    'plaintext' => array(
                      'type' => 'Zend\Router\Http\Literal',
                      'options' => array(
                          'route' => '/plaintext',
                          'defaults' => array(
                              'controller' => 'BenchWeb\Controller\BenchController',
                              'action' => 'plaintext',
                          ),
                      ),
                    ),
                    'json' => array(
                        'type' => 'Zend\Router\Http\Literal',
                        'options' => array(
                            'route' => '/json',
                            'defaults' => array(
                                'controller' => 'BenchWeb\Controller\BenchController',
                                'action' => 'json',
                            ),
                        ),
                    ),
                    'db' => array(
                        'type' => 'Zend\Router\Http\Literal',
                        'options' => array(
                            'route' => '/db',
                            'defaults' => array(
                                'controller' => 'BenchWeb\Controller\BenchController',
                                'action' => 'db',
                            ),
                        ),
                    ),
                    'queries' => array(
                        'type' => 'Zend\Router\Http\Literal',
                        'options' => array(
                            'route' => '/queries',
                            'defaults' => array(
                                'controller' => 'BenchWeb\Controller\BenchController',
                                'action' => 'queries',
                            ),
                        ),
                    ),
                    'updates' => array(
                        'type' => 'Zend\Router\Http\Literal',
                        'options' => array(
                            'route' => '/updates',
                            'defaults' => array(
                                'controller' => 'BenchWeb\Controller\BenchController',
                                'action' => 'updates',
                            ),
                        ),
                    ),
                ),
            ),
            'db' => array(
                'driver' => 'Pdo',
                'dsn'    => 'mysql:dbname=hello_world;host=localhost',
            ),
            'controllers' => array(
                'factories' => array(
                    'BenchWeb\Controller\BenchController'
                        => 'BenchWeb\ServiceFactory\BenchControllerServiceFactory'
                ),
            ),
            'service_manager' => array(
                'factories' => array(
                    'Zend\Db\Adapter\Adapter' => 'Zend\Db\Adapter\AdapterServiceFactory',
                ),
            ),
            'view_manager' => array(
                'strategies' => array(
                    'ViewJsonStrategy',
                ),
            ),
        );
    }
}
