<?php
class ModelCatalogOCFilter extends Model {
  public function __construct($registry) {
    parent::__construct($registry);

    $this->load->helper('ocfilter');
    $this->load->config('ocfilter');
  }

  public function getOCFilterOptionsByCategoryId($category_id) {
    $cache_key = 'ocfilter.option.' . (int)$category_id . '.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('ocfilter_sub_category');

    $options_data = $this->cache->get($cache_key);

		if (false !== $options_data) {
			return $options_data;
		}

    $options_data = array();

    $sql = "SELECT * FROM " . DB_PREFIX . "ocfilter_option oo LEFT JOIN " . DB_PREFIX . "ocfilter_option_description ood ON (oo.option_id = ood.option_id) LEFT JOIN " . DB_PREFIX . "ocfilter_option_to_category oo2c ON (oo.option_id = oo2c.option_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (oo2c.category_id = cp.category_id)";
    }

    $sql .= " WHERE oo.status = '1' AND ood.language_id = '" . (int)$this->config->get('config_language_id') . "'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$category_id . "'";
    } else {
    	$sql .= " AND oo2c.category_id = '" . (int)$category_id . "'";
    }

    $sql .= " GROUP BY oo.option_id ORDER BY oo.sort_order";

    $options_query = $this->db->query($sql);

    foreach ($options_query->rows as $option) {
      $option_data = array_merge($option, array(
        'slide_value_min' => 0,
        'slide_value_max' => 0,
        'values' => array(),
      ));

      if (!($option['type'] == 'slide' || $option['type'] == 'slide_dual')) {
        $values_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_option_value oov LEFT JOIN " . DB_PREFIX . "ocfilter_option_value_description oovd ON (oov.value_id = oovd.value_id) WHERE oov.option_id = '" . (int)$option['option_id'] . "' AND oovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY oov.sort_order, (oovd.name = '-') DESC, (oovd.name = '0') DESC, (oovd.name + 0 > 0) DESC, (oovd.name + 0), oovd.name");

        $option_data['values'] = $values_query->rows;
      }

      $options_data[] = $option_data;
    }

    $this->cache->set($cache_key, $options_data);

    return $options_data;
  }

  public function decodeOption($keyword, $category_id) {
    // Get Option by keyword
    $sql = "SELECT oo.option_id FROM " . DB_PREFIX . "ocfilter_option oo LEFT JOIN " . DB_PREFIX . "ocfilter_option_to_category oo2c ON (oo.option_id = oo2c.option_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (oo2c.category_id = cp.category_id)";
    }

    $sql .= " WHERE oo.status = '1' AND oo.`keyword` = '" . $this->db->escape($keyword) . "'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$category_id . "'";
    } else {
    	$sql .= " AND oo2c.category_id = '" . (int)$category_id . "'";
    }

    $sql .= " LIMIT 1";

    //echo $sql . '<br /><br />';

    $query = $this->db->query($sql);

    // Get Option by ID
    if (!$query->num_rows && isID($keyword)) {
      $sql = "SELECT oo.option_id FROM " . DB_PREFIX . "ocfilter_option oo LEFT JOIN " . DB_PREFIX . "ocfilter_option_to_category oo2c ON (oo.option_id = oo2c.option_id)";

      if ($this->config->get('ocfilter_sub_category')) {
      	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (oo2c.category_id = cp.category_id)";
      }

      $sql .= " WHERE oo.status = '1' AND oo.option_id = '" . (int)$keyword . "'";

      if ($this->config->get('ocfilter_sub_category')) {
      	$sql .= " AND cp.path_id = '" . (int)$category_id . "'";
      } else {
      	$sql .= " AND oo2c.category_id = '" . (int)$category_id . "'";
      }

      $query = $this->db->query($sql);
    }

    if (!empty($query->row['option_id'])) {
    	return $query->row['option_id'];
    } else {
      return 0;
    }
  }

  public function decodeValue($keyword, $option_id) {
    $query = $this->db->query("SELECT value_id FROM " . DB_PREFIX . "ocfilter_option_value WHERE option_id = '" . (int)$option_id . "' AND `keyword` = '" . $this->db->escape($keyword) . "' LIMIT 1");

    // If keyword is ID
    if (!$query->num_rows && isID($keyword)) {
      $query = $this->db->query("SELECT value_id FROM " . DB_PREFIX . "ocfilter_option_value WHERE value_id = '" . $this->db->escape((string)$keyword) . "'");
    }

    if (!empty($query->row['value_id'])) {
    	return $query->row['value_id'];
    } else {
      return 0;
    }
  }

  public function decodeManufacturer($keyword) {
    $query = $this->db->query("SELECT REPLACE(`query`, 'manufacturer_id=', '') AS manufacturer_id FROM " . DB_PREFIX . "url_alias WHERE `query` LIKE 'manufacturer_id=%' AND LCASE(`keyword`) = '" . $this->db->escape(utf8_strtolower($keyword)) . "' LIMIT 1");

    if (!$query->num_rows && isID($keyword)) {
      $query = $this->db->query("SELECT manufacturer_id FROM " . DB_PREFIX . "manufacturer WHERE manufacturer_id = '" . (int)$keyword . "'");
    }

    if (!empty($query->row['manufacturer_id'])) {
    	return $query->row['manufacturer_id'];
    } else {
      return 0;
    }
  }

  public function decodeCategory($keywords = array()) {
    $fields = array();

    foreach ($keywords as $keyword) {
      $fields[] = "'" . $this->db->escape($keyword) . "'";
    }

    if ($fields) {
      $query = $this->db->query("SELECT
        GROUP_CONCAT(REPLACE(`query`, 'category_id=', '') ORDER BY FIELD(keyword, " . implode(", ", $fields) . ") SEPARATOR '_') AS path,
        GROUP_CONCAT(`keyword` ORDER BY FIELD(keyword, " . implode(", ", $fields) . ") SEPARATOR '/') AS keywords

        FROM " . DB_PREFIX . "url_alias WHERE `query` LIKE 'category_id=%' AND (keyword = " . implode(" OR keyword = ", $fields) . ")");

      if ($query->num_rows) {
        $result = new stdClass();

        $result->path = $query->row['path'];
        $result->keywords = explode('/', $query->row['keywords']);

        return $result;
      }
    }

    return false;
  }

  public function getSliderRange($option_id, $data) {
    $range_data = array(
      'min' => 0,
      'max' => 0
    );

    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
    	$product_sql = $this->getSearchSQL($data['filter_ocfilter']);
    } else {
    	$product_sql = false;
    }

    $sql = "SELECT MIN(oov2p.slide_value_min) AS `min`, GREATEST(MAX(oov2p.slide_value_max), MAX(oov2p.slide_value_min)) AS `max`, oov2p.option_id FROM " . DB_PREFIX . "ocfilter_option_value_to_product oov2p LEFT JOIN " . DB_PREFIX . "product p ON (oov2p.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";

    if ($product_sql && $product_sql->join) {
    	$sql .= $product_sql->join;
    }

    $sql .= " WHERE p.status = '1' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "' AND oov2p.value_id = '0' AND oov2p.option_id = '" . (int)$option_id . "'";

    if ($product_sql && $product_sql->where) {
    	$sql .= $product_sql->where;
    }

    $slider_query = $this->db->query($sql);

    if ($slider_query->num_rows) {
      $range_data['min'] = (float)$slider_query->row['min'];
      $range_data['max'] = (float)$slider_query->row['max'];
    }

    return $range_data;
  }

  public function getCategorySeoPathByCategoryId($category_id) {
    $query = $this->db->query("SELECT GROUP_CONCAT(DISTINCT ua.`keyword` ORDER BY cp.`level` SEPARATOR '/') AS path FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "url_alias ua ON (CONCAT('category_id=', cp.path_id) = ua.`query`) WHERE cp.category_id = '" . (int)$category_id . "'");

    if ($query->num_rows) {
    	return $query->row['path'];
    } else {
      return '';
    }
  }

  public function getStockStatuses() {
    $stock_statuses_data = $this->cache->get('ocfilter.stock_status');

		if (false !== $stock_statuses_data) {
			return $stock_statuses_data;
		}

		$query = $this->db->query("SELECT stock_status_id AS value_id, name, 's' AS option_id FROM " . DB_PREFIX . "stock_status WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY name");

    $stock_statuses_data = $query->rows;

    $this->cache->set('ocfilter.stock_status', $stock_statuses_data);

		return $stock_statuses_data;
	}

  public function getManufacturersByCategoryId($category_id) {
    $cache_key = 'ocfilter.manufacturer.' . (int)$category_id . '.' . (int)$this->config->get('config_store_id') . '.' . (int)$this->config->get('ocfilter_sub_category');

    $manufacturers_data = $this->cache->get($cache_key);

		if (false !== $manufacturers_data) {
			return $manufacturers_data;
		}

    $sql = "SELECT m.manufacturer_id AS value_id, m.name, 'm' AS option_id FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) LEFT JOIN " . DB_PREFIX . "product p ON (m.manufacturer_id = p.manufacturer_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    $sql .= " WHERE p.status = '1' AND m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$category_id . "'";
    } else {
    	$sql .= " AND p2c.category_id = '" . (int)$category_id . "'";
    }

    $sql .= " GROUP BY m.manufacturer_id ORDER BY m.name ASC";

    $query = $this->db->query($sql);

    $manufacturers_data = $query->rows;

    $this->cache->set($cache_key, $manufacturers_data);

		return $manufacturers_data;
	}

  public function getProductPrices($data) {
		$cache_key = 'ocfilter.price.' . (int)$this->config->get('ocfilter_consider_discount') . '.' . (int)$this->config->get('ocfilter_consider_discount') . '.' . (int)$this->config->get('ocfilter_consider_option') . '.' . (int)$this->config->get('ocfilter_sub_category') . '.' . md5(serialize($data));

		$product_price_data = $this->cache->get($cache_key);

    if (false !== $product_price_data) {
    	return $product_price_data;
    }

    $product_price_data = array(
			'min' => 0,
			'max' => 0
		);

    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
    	$product_sql = $this->getSearchSQL($data['filter_ocfilter']);
    } else {
    	$product_sql = false;
    }

    $price_from = array();
    $price_to = array();

    // Get default price range
    
    if($data['valute'] == "RUB"){
      $this->cache->delete($cache_key);
      $sql = "SELECT MIN(p.price_rub) AS `min`, MAX(p.price_rub) AS `max` FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";
    }else{
      $this->cache->delete($cache_key);
      $sql = "SELECT MIN(p.price_usd) AS `min`, MAX(p.price_usd) AS `max` FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";
    }
    
    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    /*if ($product_sql && $product_sql->join) {
    	$sql .= $product_sql->join;
    }*/

    if($data['valute'] == "RUB"){
      $sql .= " WHERE p.status = '1' AND p.price_rub > '0' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p.date_available <= '" . $this->db->escape(date('Y-m-d')) . "'";
    }else{
      $sql .= " WHERE p.status = '1' AND p.price_usd > '0' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p.date_available <= '" . $this->db->escape(date('Y-m-d')) . "'";
    }
    
    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
    } else {
    	$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
    }
       
    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    /*if ($product_sql && $product_sql->where) {
    	$sql .= $product_sql->where;
    }*/

    $query = $this->db->query($sql);
        
    if ($query->num_rows && $query->row['min'] > 0) {
    	$price_from[] = $query->row['min'];

      $price_to[] = $query->row['max'];
    }

    if ($price_from) {
			$product_price_data = array(
				'min' => min($price_from),
				'max' => max($price_to),
			);
    }

    $this->cache->set($cache_key, $product_price_data);

    return $product_price_data;
  }

  public function getSearchSQL($params = array()) {
    if (!is_array($params)) {
      $params = decodeParamsFromString($params, $this->config);
    }

    $join = "";
    $where = "";

    foreach ($params as $option_id => $values) {
      // Filter by price
      if ($option_id == 'p') {
        $range = getRangeParts(array_shift($values));

        if (isset($range['from']) && isset($range['to'])) {
          //$price_from = floor((float)$range['from'] / $this->currency->getValue($this->session->data['currency']));
          //$price_to = ceil((float)$range['to'] / $this->currency->getValue($this->session->data['currency']));
					
					$price_from = (float)$range['from'];
					$price_to = (float)$range['to'];
					
					if($price_from >= 0 || $price_to > 0) {
							$this->load->model('localisation/currency');
							$currencies = $this->model_localisation_currency->getCurrencies();
					}
						
					$code = $this->cache->get('valute');
	
					if($price_from >= 0) {
						$price_sql = array();
						foreach ($currencies as $currency) {
								if ($code == 'RUB') {
										$price_sql[] = "(p.price_rub >=" . (float)$price_from . " AND currency_id = '".((int)$currency['currency_id'])."')";
								} else {
										$price_sql[] = "(p.price_usd >=" . (float)$price_from . " AND currency_id = '".((int)$currency['currency_id'])."')";
								}
						}
						$where .= " AND ((".implode(" OR ", $price_sql).")";
					}
						
					if($price_to > 0) {
						$price_sql = array();
						foreach ($currencies as $currency) {
								if ($code == 'RUB') {
										$price_sql[] = "(p.price_rub <=" . (float)$price_to . " AND currency_id = '".((int)$currency['currency_id'])."')";
								} else {
										$price_sql[] = "(p.price_usd <=" . (float)$price_to . " AND currency_id = '".((int)$currency['currency_id'])."')";
								}
						}
						$where .= " AND (".implode(" OR ", $price_sql).")";
					}

          $where .= ")";
        }

        unset($params[$option_id]);

      // Filter by manufacturer
      } else if ($option_id == 'm') {
        $implode = array();

        foreach ($values as $value_id) {
          $implode[] = "p.manufacturer_id = '" . (int)$value_id . "'";
        }

        if ($implode) {
          $where .= " AND (" . implode(" OR ", $implode) . ")";
        }

        unset($params[$option_id]);

      // Filter by stock status
      } else if ($option_id == 's') {
        $implode = array();

        if ($this->config->get('ocfilter_stock_status_method') == 'stock_status_id') {
          foreach ($values as $value_id) {
            $implode[] = "p.stock_status_id = '" . (int)$value_id . "'";
          }

          if ($implode) {
            $where .= " AND (" . implode(" OR ", $implode) . ")";
          }
        } else {
          $stock_status = array_shift($values);

          if ($stock_status == 'in') {
          	$where .= " AND p.quantity > '0'";
          } else {
          	$where .= " AND p.quantity < '1'";
          }
        }

        unset($params[$option_id]);

      // Remove other any special filters
      } else if (!isID($option_id) || !$values) {
        unset($params[$option_id]);
      }
    }

    // Find by option -> values
    if ($params) {
      $implode_where = array();
      $implode_join = array();

      $i = 1;

      foreach ($params as $option_id => $values) {
        $or = array();

        if (isRange($values[0])) {
          $range = getRangeParts($values[0]);

          if (isset($range['from']) && isset($range['to'])) {
        	  $or[] = "oov2p" . (int)$i . ".slide_value_min BETWEEN '" . (float)$range['from'] . "' AND '" . (float)$range['to'] . "' AND oov2p" . (int)$i . ".slide_value_max BETWEEN '" . (float)$range['from'] . "' AND '" . (float)$range['to'] . "'";
          } else {
            continue;
          }
        } else {
          foreach ($values as $value_id) {
          	$or[] = "oov2p" . (int)$i . ".value_id = '" . $this->db->escape($value_id) . "'";
          }
        }

        if ($or) {
          $implode_where[] = "oov2p" . (int)$i . ".option_id = '" . (int)$option_id . "' AND (" . implode(" OR ", $or) . ")";
        }

        if ($i > 1) {
          $implode_join[] = "ocfilter_option_value_to_product oov2p" . (int)$i . " ON (oov2p1.product_id = oov2p" . (int)$i . ".product_id)";
        }

        $i++;
      }

      if ($implode_where) {
        $join .= " LEFT JOIN " . DB_PREFIX . "ocfilter_option_value_to_product oov2p1 ON (p.product_id = oov2p1.product_id)";

        if ($implode_join) {
          $join .= " LEFT JOIN " . DB_PREFIX . implode(" LEFT JOIN " . DB_PREFIX, $implode_join);
        }

        $where .= " AND " . implode(" AND ", $implode_where);
      }
    }

    $sql = new stdClass();

    $sql->join = $join;
    $sql->where = $where;

    return $sql;
  }

	public function getCounters($data = array()) {
		$cache_key = 'product.ocfilter.counter.' . (int)$this->config->get('ocfilter_sub_category') . '.' . md5(serialize($data));

		$ocfilter_counter_data = $this->cache->get($cache_key);

		if (false !== $ocfilter_counter_data) {
			return $ocfilter_counter_data;
		}

    $ocfilter_counter_data = array();

    $union = array();

    // Manufacturers
    $union[] = $this->getManufacturersCounterSQL($data);

    // Stock Status
    if ($this->config->get('ocfilter_stock_status_method') == 'stock_status_id') {
      $union[] = $this->getStockStatusCounterSQL($data);
    } else {
      $union[] = $this->getQuantityCounterSQL($data);
    }

    // Option Values
    $union = $union + $this->getOptionValuesCounterSQL($data);

    if ($union) {
      foreach ($union as $sql) {
        $query = $this->db->query($sql);

        foreach ($query->rows as $result) {
        	$ocfilter_counter_data[$result['option_id'] . $result['value_id']] = $result['total'];

          if (isset($ocfilter_counter_data[$result['option_id'] . 'all'])) {
          	$ocfilter_counter_data[$result['option_id'] . 'all'] += $result['total'];
          } else {
          	$ocfilter_counter_data[$result['option_id'] . 'all'] = $result['total'];
          }
        }
      }

      $cached = true;

      // Not cache price and sliders
      if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
        $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

        if (isset($params['p'])) {
          $cached = false;
        } else {
          foreach ($params as $option_id => $values) {
            if (isRange(array_shift($values))) {
              $cached = false;

              break;
            }
          }
        }
      }

      if ($cached) {
        $this->cache->set($cache_key, $ocfilter_counter_data);
      }
    }

		return $ocfilter_counter_data;
	}

  private function getManufacturersCounterSQL($data) {
    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

      if (isset($params['m'])) {
        unset($params['m']);
      }

    	$product_sql = $this->getSearchSQL($params);
    } else {
    	$product_sql = false;
    }

    $sql = "SELECT p.manufacturer_id AS value_id, 'm' AS option_id, COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    if ($product_sql && $product_sql->join) {
    	$sql .= $product_sql->join;
    }

    $sql .= " WHERE p.status = '1'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
    } else {
    	$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
    }

    if ($product_sql && $product_sql->where) {
    	$sql .= $product_sql->where;
    }

    $sql .= " GROUP BY p.manufacturer_id";

    return $sql;
  }

  private function getStockStatusCounterSQL($data) {
    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

      if (isset($params['s'])) {
        unset($params['s']);
      }

    	$product_sql = $this->getSearchSQL($params);
    } else {
    	$product_sql = false;
    }

    $sql = "SELECT p.stock_status_id AS value_id, 's' AS option_id, COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    if ($product_sql && $product_sql->join) {
    	$sql .= $product_sql->join;
    }

    $sql .= " WHERE p.status = '1'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
    } else {
    	$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
    }

    if ($product_sql && $product_sql->where) {
    	$sql .= $product_sql->where;
    }

    $sql .= " GROUP BY p.stock_status_id";

    return $sql;
  }

  private function getQuantityCounterSQL($data) {
    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

      if (isset($params['s'])) {
        unset($params['s']);
      }

    	$product_sql = $this->getSearchSQL($params);
    } else {
    	$product_sql = false;
    }

    $sql = "SELECT IF(p.quantity > '0', 'in', 'out') AS value_id, 's' AS option_id, COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    if ($product_sql && $product_sql->join) {
    	$sql .= $product_sql->join;
    }

    $sql .= " WHERE p.status = '1'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$sql .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
    } else {
    	$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
    }

    if ($product_sql && $product_sql->where) {
    	$sql .= $product_sql->where;
    }

    $sql .= " GROUP BY value_id";

    return $sql;
  }

  private function getOptionValuesCounterSQL($data) {
    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);
    } else {
      $params = array();
    }

    if ($params) {
    	$product_sql = $this->getSearchSQL($params);
    } else {
    	$product_sql = false;
    }

    $union = array();

    // All Options and values
    $union['main'] = "SELECT oov2p.value_id, oov2p.option_id, COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "ocfilter_option_value_to_product oov2p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (oov2p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product p ON (oov2p.product_id = p.product_id)";

    if ($this->config->get('ocfilter_sub_category')) {
    	$union['main'] .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
    }

    if ($product_sql && $product_sql->join) {
    	$union['main'] .= $product_sql->join;
    }

    $union['main'] .= " WHERE p.status = '1' AND oov2p.value_id > '0'";

    if ($this->config->get('ocfilter_sub_category')) {
    	$union['main'] .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
    } else {
    	$union['main'] .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
    }

    if ($product_sql && $product_sql->where) {
    	$union['main'] .= $product_sql->where;
    }

    $union['main'] .= " GROUP BY oov2p.option_id, oov2p.value_id";

    // Selecteds
    if ($params) {
      $added = array();

      foreach ($params as $option_id => $values) {
        if ($option_id == 'p' || $option_id == 'm' || $option_id == 's' || isRange($values[0])) {
        	continue;
        }

        $_params = $params;

        if (!in_array($option_id, $added)) {
          unset($_params[$option_id]);

          $added[] = $option_id;
        }

       	$product_sql = $this->getSearchSQL($_params);

        $union[$option_id] = "SELECT oov2p.value_id, oov2p.option_id, COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "ocfilter_option_value_to_product oov2p ON (p.product_id = oov2p.product_id)";

        if ($this->config->get('ocfilter_sub_category')) {
        	$union[$option_id] .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (p2c.category_id = cp.category_id)";
        }

        if ($product_sql && $product_sql->join) {
        	$union[$option_id] .= $product_sql->join;
        }

        $union[$option_id] .= " WHERE p.status = '1' AND oov2p.option_id = '" . (int)$option_id . "'";

        if ($this->config->get('ocfilter_sub_category')) {
        	$union[$option_id] .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
        } else {
        	$union[$option_id] .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
        }

        if ($product_sql && $product_sql->where) {
        	$union[$option_id] .= $product_sql->where;
        }

        $union[$option_id] .= " GROUP BY oov2p.option_id, oov2p.value_id";
      }
    }

    return $union;
  }

	public function getPage($category_id, $params = '') {
    if (!$params) {
    	return false;
    }

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_page op LEFT JOIN " . DB_PREFIX . "ocfilter_page_description opd ON (op.ocfilter_page_id = opd.ocfilter_page_id) WHERE op.status = '1' AND op.category_id = '" . (int)$category_id . "' AND opd.language_id = '" . $this->config->get('config_language_id') . "' AND op.params = '" . $this->db->escape($params) . "' LIMIT 1");

		return $query->row;
	}

	public function decodePage($category_id, $keyword) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_page op LEFT JOIN " . DB_PREFIX . "ocfilter_page_description opd ON (op.ocfilter_page_id = opd.ocfilter_page_id) WHERE op.status = '1' AND opd.language_id = '" . $this->config->get('config_language_id') . "' AND op.category_id = '" . (int)$category_id . "' AND op.keyword = '" . $this->db->escape($keyword) . "' LIMIT 1");

		return $query->row;
	}

	public function getPages() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_page op LEFT JOIN " . DB_PREFIX . "ocfilter_page_description opd ON (op.ocfilter_page_id = opd.ocfilter_page_id) WHERE op.status = '1' AND opd.language_id = '" . $this->config->get('config_language_id') . "'");

		return $query->rows;
	}
  
	public function getCurrency(){
		$query = $this->db->query("SELECT DISTINCT c.title, c.code, c.symbol_right FROM " . DB_PREFIX . "currency as c JOIN " . DB_PREFIX . "product as p ON (c.currency_id = p.currency_id) AND c.status = '1'");

		return $query->rows;
	}
	
	public function applyCurrency(){
		$code = $this->cache->get('valute');
		
		$query = $this->db->query("SELECT currency_id FROM " . DB_PREFIX . "currency WHERE code = '" . $code . "' AND status = '1'");
		
		return $query->row;
	}
	
	public function getValueOptionsByProduct($product_id){
		$query = $this->db->query("SELECT DISTINCT ood.name AS name,oovd.name AS value, ood.postfix AS postfix FROM " . DB_PREFIX . "ocfilter_option_description ood JOIN " . DB_PREFIX . "ocfilter_option oo ON (ood.option_id = oo.option_id) AND (ood.language_id = '" . (int)$this->config->get('config_language_id') . "')
															JOIN " . DB_PREFIX . "ocfilter_option_to_store oots ON (oots.option_id = oo.option_id) AND (oots.store_id = '" . (int)$this->config->get('config_store_id') . "') AND (oo.status = '1')
															JOIN " . DB_PREFIX . "ocfilter_option_value oov ON (oov.option_id = oo.option_id)
															JOIN " . DB_PREFIX . "ocfilter_option_value_description oovd ON (oovd.value_id = oov.value_id) AND (oovd.option_id = oov.option_id) AND (oovd.language_id = '" . (int)$this->config->get('config_language_id') . "')
															JOIN " . DB_PREFIX . "ocfilter_option_value_to_product oovtp ON (oovtp.option_id = oo.option_id) AND (oovd.value_id = oovtp.value_id) AND (oovtp.product_id = '" . (int)$product_id . "') ORDER BY oo.sort_order");
	
		return $query->rows;
	}
  
  public function getValueOptionsSliderRangeByProduct($product_id){
		$query = $this->db->query("SELECT ood.name AS name, ROUND(oovtp.slide_value_max, 0) AS value, ood.postfix AS postfix FROM " . DB_PREFIX . "ocfilter_option AS oo
                              JOIN " . DB_PREFIX . "ocfilter_option_description AS ood ON (oo.option_id = ood.option_id) 
                              JOIN " . DB_PREFIX . "ocfilter_option_to_store AS oots ON (oo.option_id = oots.option_id)
                              JOIN " . DB_PREFIX . "ocfilter_option_value_to_product AS oovtp ON (oo.option_id = oovtp.option_id) 
                              AND (oovtp.product_id = '" . (int)$product_id . "') AND (ood.language_id = '" . (int)$this->config->get('config_language_id') . "') AND (oots.store_id = '" . (int)$this->config->get('config_store_id') . "') AND (oo.status = '1') AND (oovtp.value_id = '0') AND (oovtp.slide_value_min <> '0') AND (oovtp.slide_value_max <> '0') ORDER BY oo.sort_order");
	
		return $query->rows;
	}
	
  public function getData($option_id){
		$query = $this->db->query("SELECT DISTINCT ood.name AS name,oovd.name AS value, ood.postfix AS postfix, oov.value_id AS value_id FROM " . DB_PREFIX . "ocfilter_option_description ood JOIN " . DB_PREFIX . "ocfilter_option oo ON (ood.option_id = oo.option_id) AND (ood.language_id = '" . (int)$this->config->get('config_language_id') . "')
															JOIN " . DB_PREFIX . "ocfilter_option_to_store oots ON (oots.option_id = oo.option_id) AND (oots.store_id = '" . (int)$this->config->get('config_store_id') . "') AND (oo.status = '1')
															JOIN " . DB_PREFIX . "ocfilter_option_value oov ON (oov.option_id = oo.option_id)
															JOIN " . DB_PREFIX . "ocfilter_option_value_description oovd ON (oovd.value_id = oov.value_id) AND (oovd.option_id = oov.option_id) AND (oovd.language_id = '" . (int)$this->config->get('config_language_id') . "')
															JOIN " . DB_PREFIX . "ocfilter_option_value_to_product oovtp ON (oovtp.option_id = oo.option_id) AND (oovd.value_id = oovtp.value_id) AND ( oo.option_id = '" . (int)$option_id . "')");
	
		return $query->rows;
	}
}

?>