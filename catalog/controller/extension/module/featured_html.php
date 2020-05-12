<?php
class ControllerExtensionModuleFeaturedHtml extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/featured_html');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');
		
		$this->load->model('catalog/ocfilter');

		$this->load->model('tool/image');

		$data['products'] = array();
		
		$data['i'] = '';

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}
		
		$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

		if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}
					
					$this->load->model('localisation/currency');
	
					$currencys = $this->model_localisation_currency->getCurrency($product_info['currency_id']);
	
					foreach($currencys as $currency){
						if ($product_info['currency_id'] != 5) {
							$price_rub = $this->currency->convert($product_info['price'], $currency['code'], 'RUB');
							$rub = $this->currency->format($this->tax->calculate($price_rub, $product_info['tax_class_id'], $this->config->get('config_tax')), 'RUB', 1, $format= true);
						} else {
							$rub = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), 'RUB', 1, $format= true);
						}
	
					   if ($product_info['currency_id'] != 2) {
							$price_dollar = $this->currency->convert($product_info['price'], $currency['code'], 'USD');
							$price = $this->currency->format($this->tax->calculate($price_dollar, $product_info['tax_class_id'], $this->config->get('config_tax')), 'USD', 1, $format= true);
						} else {
							$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), 'USD', 1, $format= true);
						}
					}
	
					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), 'USD', $format= true);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}
					
					$stickers = $this->getStickers($product_info['product_id']);

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'model'       => $product_info['model'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'rub'		  => $rub,
						'special'     => $special,
						'tax'         => $tax,
						'sticker'     => $stickers,
						'options'     => $this->model_catalog_product->getProductOptions($product_info['product_id']),//options
						'filter_options' => $this->model_catalog_ocfilter->getValueOptionsByProduct($product_info['product_id']),//options
						'uniq_options' => $product_info['uniq_options'] = 1 ? $product_info['uniq_options'] : 0,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

		if ($data['products']) {
			return $this->load->view('extension/module/featured_html', $data);
		}
	}
	
	private function getStickers($product_id) {
		
		$stickers = $this->model_catalog_product->getProductStickerbyProductId($product_id) ;	
		
		if (!$stickers) {
			return;
		}
				
		foreach ($stickers as $sticker) {
			$stick[] = array(
				'position' => $sticker['position'],
				'image'    => HTTPS_SERVER . 'image/' . $sticker['image']
			);		
		}
		
		return $stick;
	
	}
	
	public function callMeView(){
		$json = array();
		
		$json = array(
			'status' => 0,
			'message' => ''
		);
		
		$site_url = $_SERVER['SERVER_NAME'];
	
		if (isset($this->request->post['name'])) {$name = $this->request->post['name']; if ($name == '') {unset($name);}}
		if (isset($this->request->post['tel'])) {$tel = $this->request->post['tel']; if ($tel == '') {unset($tel);}}
		if (isset($this->request->post['email'])) {$email = $this->request->post['email'];}
		if (isset($this->request->post['datetime'])) {$datetime = $this->request->post['datetime'];}
		if (isset($this->request->post['message'])) {$message = $this->request->post['message'];}
	
		if (isset($name) && isset($tel)){
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($site_url);
			$mail->setSender(html_entity_decode($this->request->post['name'], ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode(sprintf($this->language->get($site_url), $this->request->post['name']), ENT_QUOTES, 'UTF-8'));
			
			$mail->setHtml(html_entity_decode(sprintf('Имя: ' . $name . '<br>' . 'Телефон: ' . $tel . '<br>' . 'Email: ' . $email . '<br>' . 'Время записи: ' . $datetime . '<br>' . 'Сообщение: ' . $message), ENT_QUOTES, 'UTF-8'));
			$send = $mail->send();
						
			if ($mail){
				$json = array(
					'status' => 1,
					'message' => 'Ваше сообщение отправлено'
				);
			}else{
				$json = array(
					'status' => 1,
					'message' => 'Ошибка, сообщение не отправлено!'
				);
			}
		}
	
		if (isset($this->request->post['name']) && isset($this->request->post['tel'])){
			$name = $this->request->post['name'];
			$tel = $this->request->post['tel'];
	
			if ($name == '' || $tel == '') {
				unset($name);
				unset($tel);
				
				$json = array(
					'status' => 1,
					'message' => 'Ошибка, сообщение не отправлено! Заполните все поля!'
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}	
}