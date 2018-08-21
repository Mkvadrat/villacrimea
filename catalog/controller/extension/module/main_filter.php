<?php
// *	@copyright	OPENCART.PRO 2011 - 2017.
// *	@forum	http://forum.opencart.pro
// *	@source		See SOURCE.txt for source and other copyright.
// *	@license	GNU General Public License version 3; see LICENSE.txt

class ControllerExtensionModuleMainFilter extends Controller {
	public function index($setting) {
		if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			
			//Menu
			$this->load->model('catalog/category');
			
			$data['categories'] = array();
			
			$categories = $this->model_catalog_category->getCategories(0);
	
			foreach ($categories as $category) {
				if ($category['top']) {
					// Level 1
					$data['categories'][] = array(
						'name'     => $category['name'],
						'column'   => $category['column'] ? $category['column'] : 1,
						'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
					);
				}
			}
			
			$data['filter_categories'] = array();
			
			$filter_categories = $this->model_catalog_category->getCategories(0);
	
			foreach ($filter_categories as $category) {
				if ($category['top']) {
					// Level 1
					$data['filter_categories'][] = array(
						'name'     => $category['name'],
						'column'   => $category['column'] ? $category['column'] : 1,
						'href'     => $category['category_id']
					);
				}
			}
			
			$this->load->model('catalog/ocfilter');
			
			$data['regions'] = array();
			
			if($setting['region']){
				$regions = $this->model_catalog_ocfilter->getData($setting['region']);
				
				foreach($regions as $region){
					$data['regions'][] = array(
						'name' => $region['value'],
						'href' => $setting['region'].':'.$region['value_id']
					);
				}
			}
			
			//rub
			$data['price_from_rub'] = array();
			
			if($setting['price_from_rub']){
				$explode = explode(';', $setting['price_from_rub']);

				foreach($explode as $value){
					$data['price_from_rub'][] = array(
						'price' => $value,
					);
				}
			}
			
			$data['price_to_rub'] = array();
			
			if($setting['price_to_rub']){
				$explode = explode(';', $setting['price_to_rub']);

				foreach($explode as $value){
					$data['price_to_rub'][] = array(
						'price' => $value,
					);
				}
			}
			
			//usd
			$data['price_from_usd'] = array();
			
			if($setting['price_from_usd']){
				$explode = explode(';', $setting['price_from_usd']);

				foreach($explode as $value){
					$data['price_from_usd'][] = array(
						'price' => $value,
					);
				}
			}
			
			$data['price_to_usd'] = array();
			
			if($setting['price_to_usd']){
				$explode = explode(';', $setting['price_to_usd']);

				foreach($explode as $value){
					$data['price_to_usd'][] = array(
						'price' => $value,
					);
				}
			}
			
			return $this->load->view('extension/module/main_filter', $data);
		}
	}
	
	public function getFilter(){
		$json = array();
		
		if (isset($this->request->post['filter_categories'])) {
			$json['category_id'] = $this->request->post['filter_categories'];
		}else{
			$json['category_id'] = 0;
		}
		
		if (isset($this->request->post['regions'])) {
			$json['regions'] = $this->request->post['regions'];
		}else{
			$json['regions'] = 0;
		}
		
		if (isset($this->request->post['price_from'])) {
			$json['price_from'] = $this->request->post['price_from'];
		}else{
			$json['price_from'] = 0;
		}
		
		if (isset($this->request->post['price_to'])) {
			$json['price_to'] = $this->request->post['price_to'];
		}else{
			$json['price_to'] = 0;
		}
		
		if (isset($this->request->post['currency'])) {
			$json['currency'] = $this->request->post['currency'];
		}else{
			$json['currency'] = 'RUB';
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}