<?php
class ControllerExtensionModuleBanner extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');
<<<<<<< HEAD
=======
		$this->load->model('localisation/currency');
>>>>>>> 587e356511f34c417f633a2b1ed30c596080fc5c

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);
		
		foreach ($results as $result) {
<<<<<<< HEAD
=======
			$banner_currencys = $this->model_localisation_currency->getCurrencyByCurrency_id($result['currency_id']);
			
			$price = $this->currency->format($this->tax->calculate($result['price'], '', $this->config->get('config_tax')), $this->config->get('config_currency'), 1, $format= true); 
			
			$currencys = $this->model_localisation_currency->getCurrencyByCode($this->config->get('config_currency'));
			
			$convert_price = $this->currency->convert($result['price'], $this->config->get('config_currency'), $banner_currencys['code']);

			$format_price = $this->currency->format($this->tax->calculate($convert_price, '', $this->config->get('config_tax')), $banner_currencys['code'], 1, $format= true);
	
>>>>>>> 587e356511f34c417f633a2b1ed30c596080fc5c
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'], 'product_banner'),
<<<<<<< HEAD
					'price' => $result['price'],
=======
					'price' => $price,
					'format_price'	=> $format_price
>>>>>>> 587e356511f34c417f633a2b1ed30c596080fc5c
				);
			}
		}

		$data['module'] = $module++;

		return $this->load->view('extension/module/banner', $data);
	}
}