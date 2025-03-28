<?php

namespace BenchWeb\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\Stdlib\ArrayUtils;
use Zend\View\Model\JsonModel;
use Zend\View\Model\ViewModel;
use Zend\Http\Headers;
use Zend\Db\TableGateway\TableGateway;

/**
 * Controller that produces the json for the DB benchmarks of BenchWeb
 *
 * @author Marco Pivetta <ocramius@gmail.com>
 * @link   http://www.khulnasoft.com/benchmarks
 */
class BenchController extends AbstractActionController
{
    /**
     * @var \Zend\Db\TableGateway\TableGateway
     */
    protected $tableGateway;

    /**
     * @param TableGateway $tableGateway
     */
    public function __construct(TableGateway $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }

    public function jsonAction()
    {
        return new JsonModel(array('message' => 'Hello, World!'));
    }

    /**
     * @return \Zend\View\Model\JsonModel
     */
    public function dbAction()
    {
        $result = $this->tableGateway->select(array('id' => mt_rand(1, 10000)));

        foreach ($result as $return) {
            return new JsonModel($return);
        }

        return $this->notFoundAction();
    }

    /**
     * @return \Zend\View\Model\JsonModel
     */
    public function queriesAction()
    {
        /* @var $request \Zend\Http\Request */
        $request = $this->getRequest();
        $queries = (int) $request->getQuery('queries', 1);
        $queries = max(1, $queries);
        $queries = min(500, $queries);

        $worlds  = array();

        for ($i = 0; $i < $queries; $i += 1) {
            foreach ($this->tableGateway->select(array('id' => mt_rand(1, 10000))) as $found) {
                $worlds[] = $found;
            }
        }

        return new JsonModel($worlds);
    }

    public function updatesAction()
    {
      $request = $this->getRequest();
      $queries = (int) $request->getQuery('queries', 1);
      $queries = max(1, $queries);
      $queries = min(500, $queries);

      $worlds  = array();

      for ($i = 0; $i < $queries; $i += 1) {
          $id = mt_rand(1, 10000);
          foreach ($this->tableGateway->select(array('id' => $id)) as $found) {
              $random_number = mt_rand(1, 10000);
              $found->randomNumber = $random_number;
              $this->tableGateway->update(array('randomNumber' => $random_number), array('id' => $id));
              $worlds[] = $found;
          }
      }

      return new JsonModel($worlds);
    }

    public function plaintextAction()
    {
      $response = $this->getResponse();
      $response->getHeaders()->addHeaders(array('COntent-Type' => 'text/plain'));
      $response->setContent('Hello, World!');
      return $response;
    }
}
