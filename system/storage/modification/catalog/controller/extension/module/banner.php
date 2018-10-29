<?php
class ControllerExtensionModuleBanner extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');
		$this->load->model('localisation/currency');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);
		
		foreach ($results as $result) {
			$banner_currencys = $this->model_localisation_currency->getCurrencyByCurrency_id($result['currency_id']);
			
			$price = $this->currency->format($this->tax->calculate($result['price'], '', $this->config->get('config_tax')), $this->config->get('config_currency'), 1, $format= true); 
			
			$currencys = $this->model_localisation_currency->getCurrencyByCode($this->config->get('config_currency'));
			
			$convert_price = $this->currency->convert($result['price'], $this->config->get('config_currency'), $banner_currencys['code']);

			$format_price = $this->currency->format($this->tax->calculate($convert_price, '', $this->config->get('config_tax')), $banner_currencys['code'], 1, $format= true);
	
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'], 'product_banner'),
					'price' => $price,
					'format_price'	=> $format_price
				);
			}
		}

		$data['module'] = $module++;

		return $this->load->view('extension/module/banner', $data);
	}
}