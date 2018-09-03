<?php
// *	@copyright	OPENCART.PRO 2011 - 2017.
// *	@forum	http://forum.opencart.pro
// *	@source		See SOURCE.txt for source and other copyright.
// *	@license	GNU General Public License version 3; see LICENSE.txt

class ControllerBlogArticle extends Controller {
	private $error = array(); 
	
	public function index() { 
		$this->load->language('blog/article');
	
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),			
			'separator' => false
		);
		
		$configblog_name = $this->config->get('configblog_name');
		
		if (!empty($configblog_name)) {
			$name = $this->config->get('configblog_name');
		} else {
			$name = $this->language->get('text_blog');
		}
		
		$data['breadcrumbs'][] = array(
			'text' => $name,
			'href' => $this->url->link('blog/latest')
		);
		
		$this->load->model('blog/category');	
		
		
		if (isset($this->request->get['blog_category_id'])) {
			$blog_category_id = '';
				
			foreach (explode('_', $this->request->get['blog_category_id']) as $path_id) {
				if (!$blog_category_id) {
					$blog_category_id = $path_id;
				} else {
					$blog_category_id .= '_' . $path_id;
				}
				
				$category_info = $this->model_blog_category->getCategory($path_id);
				
				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text'      => $category_info['name'],
						'href'      => $this->url->link('blog/category', 'blog_category_id=' . $blog_category_id)
					);
				}
			}
		}

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_tag'])) {
			$url = '';
			
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
						
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
						
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}
			
			if (isset($this->request->get['filter_news_id'])) {
				$url .= '&filter_news_id=' . $this->request->get['filter_news_id'];
			}	
						
		}
		
		if (isset($this->request->get['article_id'])) {
			$article_id = (int)$this->request->get['article_id'];
		} else {
			$article_id = 0;
		}
		
		$this->load->model('blog/article');
		
		$article_info = $this->model_blog_article->getArticle($article_id);
		
		if ($article_info) {
			$url = '';
			
			if (isset($this->request->get['blog_category_id'])) {
				$url .= '&blog_category_id=' . $this->request->get['blog_category_id'];
			}	

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
						
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
			
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}	
						
			if (isset($this->request->get['filter_news_id'])) {
				$url .= '&filter_news_id=' . $this->request->get['filter_news_id'];
			}
			
			$data['breadcrumbs'][] = array(
				'text' => $article_info['name'],
				'href' => $this->url->link('blog/article', 'article_id=' . $this->request->get['article_id'])
			);
			
			if ($article_info['meta_title']) {
				$this->document->setTitle($article_info['meta_title']);
			} else {
				$this->document->setTitle($article_info['name']);
			}
			
			if ($article_info['noindex'] <= 0) {
				$this->document->setRobots('noindex,follow');
			}

			$this->document->setDescription($article_info['meta_description']);
			$this->document->setKeywords($article_info['meta_keyword']);
			$this->document->addLink($this->url->link('blog/article', 'article_id=' . $this->request->get['article_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			if ($article_info['meta_h1']) {	
				$data['heading_title'] = $article_info['meta_h1'];
			} else {
				$data['heading_title'] = $article_info['name'];
			}
			
			$data['text_select'] = $this->language->get('text_select');
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_loading'] = $this->language->get('text_loading');
			$data['text_note'] = $this->language->get('text_note');
			$data['text_share'] = $this->language->get('text_share');
			$data['text_wait'] = $this->language->get('text_wait');
			$data['text_next'] = $this->language->get('text_next');
			$data['text_prev'] = $this->language->get('text_prev');
			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');
			$data['entry_captcha'] = $this->language->get('entry_captcha');
			
			$data['button_continue'] = $this->language->get('button_continue');

			$data['text_related'] = $this->language->get('text_related');
			$data['text_related_product'] = $this->language->get('text_related_product');
			
			$data['article_id'] = $this->request->get['article_id'];

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}
			
			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status')) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}
			
			$data['gstatus'] = (int)$article_info['gstatus'];
			$data['description'] = html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8');
			$data['detail'] = html_entity_decode($article_info['detail'], ENT_QUOTES, 'UTF-8');
			$data['sub_name'] = $article_info['sub_name'];
			
			$prevs = $this->model_blog_article->getPreviusArticles($this->request->get['article_id']);
			
			$nexts = $this->model_blog_article->getNextArticles($this->request->get['article_id']);
			
			$data['prev'] = '';
			$data['next'] = '';
			
			foreach($prevs as $prev){
				$data['prev'] = $this->url->link('blog/article', 'article_id=' . $prev['previousid']);
			}
			
			foreach($nexts as $next){
				$data['next'] = $this->url->link('blog/article', 'article_id=' . $next['nextid']);
			}

			$data['articles'] = array();
			
			$data['button_more'] = $this->language->get('button_more');
			$data['text_views'] = $this->language->get('text_views');
			
			$this->load->model('tool/image');
			
			$this->load->model('user/user');
			
			$agent_id = $this->model_user_user->getAgentByProduct($article_info['product_case_id']);

			$agent_information = $this->model_user_user->getUser($agent_id);
									
			$data['agent_name'] = $agent_information['lastname'] . ' ' . $agent_information['firstname'];
			
			$data['specialization'] = $agent_information['specialization'];
			
			if ($agent_information['image']) {
				$data['image_agent'] = $this->model_tool_image->resize($agent_information['image'], 226, 226);
			} else {
				$data['image_agent'] = $this->model_tool_image->resize('placeholder.png', 226, 226);
			}
			
			$data['phone'] = $agent_information['phone'];
			
			$data['email'] = $agent_information['email'];
			
			$data['case_id'] = $agent_information['category_case_id'];
			
			$data['view_all_cases'] = $this->url->link('blog/category', '&blog_category_id=' . $agent_information['category_case_id']);
			
			$data['category_id_object'] = $agent_information['category_id'];
			
			$data['view_all_object'] = $this->url->link('product/category', 'path=' . $agent_information['category_id']);
			
			$this->load->model('tool/image');
			
			$this->load->model('catalog/product');
			
			$this->load->model('catalog/ocfilter');
			
			$product_case = $this->model_catalog_product->getProduct($article_info['product_case_id']);
			
			$data['product_case'] = false;

			if ($product_case) {
				$data['product_case'] = true;
				$data['i'] = '';
				$data['product_name'] = $product_case['name'];
				$data['product_model'] = $product_case['model'];
				$data['product_stickers'] = $this->getStickers($product_case['product_id']);
				$data['product_description'] = html_entity_decode($product_case['description'], ENT_QUOTES, 'UTF-8');
				$data['product_heading_description'] = html_entity_decode($product_case['heading_description'], ENT_QUOTES, 'UTF-8');
				$data['product_options'] = $this->model_catalog_product->getProductOptions($article_info['product_case_id']);
				$data['options'] = $this->model_catalog_product->getProductOptions($article_info['product_case_id']);
				$data['filter_options'] = $this->model_catalog_ocfilter->getValueOptionsByProduct($article_info['product_case_id']);
				$data['uniq_options'] = $product_case['uniq_options'] = 1 ? $product_case['uniq_options'] : 0;
				
				if ($product_case['image']) {
					$data['product_image'] = $this->model_tool_image->resize($product_case['image'], 387, 239);
				} else {
					$data['product_image'] = $this->model_tool_image->resize('placeholder.png', 387, 239);
				}
				
				$data['product_href'] = $this->url->link('product/product', 'product_id=' . $article_info['product_case_id']);
				
				$this->load->model('localisation/currency');
		
				$currencys = $this->model_localisation_currency->getCurrency($product_case['currency_id']);
		
				foreach($currencys as $currency){
					if ($product_case['currency_id'] != 5) {
						$price_rub = $this->currency->convert($product_case['price'], $currency['code'], 'RUB');
						$data['rub'] = $this->currency->format($this->tax->calculate($price_rub, $product_case['tax_class_id'], $this->config->get('config_tax')), 'RUB', 1, $format= true);
					} else {
						$data['rub'] = $this->currency->format($this->tax->calculate($product_case['price'], $product_case['tax_class_id'], $this->config->get('config_tax')), 'RUB', 1, $format= true);
					}
		
				   if ($product_case['currency_id'] != 2) {
						$price_dollar = $this->currency->convert($product_case['price'], $currency['code'], 'USD');
						$data['price'] = $this->currency->format($this->tax->calculate($price_dollar, $product_case['tax_class_id'], $this->config->get('config_tax')), 'USD', 1, $format= true);
					} else {
						$data['price'] = $this->currency->format($this->tax->calculate($product_case['price'], $product_case['tax_class_id'], $this->config->get('config_tax')), 'USD', 1, $format= true);
					}
				}
				
				if ((float)$product_case['special']) {
					$data['special'] = $this->currency->format($this->tax->calculate($product_case['special'], $product_case['tax_class_id'], $this->config->get('config_tax')), 'USD', $format= true);
				} else {
					$data['special'] = false;
				}
			}
			
			$results = $this->model_blog_article->getArticleRelated($this->request->get['article_id']);
			
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('configblog_image_related_width'), $this->config->get('configblog_image_related_height'));
				} else {
					$image = false;
				}
				
				$agent_info = $this->model_blog_category->getCategory($result['article_id']);
				
				if (!empty($agent_info['image'])) {
					$image_agent = $this->model_tool_image->resize($agent_info['image'], 226, 226);
				} else {
					$image_agent = $this->model_tool_image->resize('placeholder.png', 226, 226);
				}
							
				$data['articles'][] = array(
					'article_id' => $result['article_id'],
					'thumb'   	 => $image,
					'name'    	 => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('configblog_article_description_length')) . '..',
					'short_description' => utf8_substr(strip_tags(html_entity_decode($article_info['short_description'], ENT_QUOTES, 'UTF-8')), 0, 100 . '..'),
					'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'viewed'      => $result['viewed'],
					'href'    	  => $this->url->link('blog/article', 'article_id=' . $result['article_id']),
					'agent'       => isset($agent_info['name']) ? $agent_info['name'] : '',
					'image_agent' => $image_agent
				);
			}

			$this->load->model('tool/image');
			
			$data['products'] = array();
			
			$results = $this->model_blog_article->getArticleRelatedProduct($this->request->get['article_id']);
			
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('configblog_image_related_width'), $this->config->get('configblog_image_related_height'));
				} else {
					$image = false;
				}
				
				$this->load->model('localisation/currency');

				$currencys = $this->model_localisation_currency->getCurrency($result['currency_id']);

				foreach($currencys as $currency){
					if ($result['currency_id'] != 5) {
						$price_rub = $this->currency->convert($result['price'], $currency['code'], 'RUB');
						$rub = $this->currency->format($this->tax->calculate($price_rub, $result['tax_class_id'], $this->config->get('config_tax')), 'RUB', 1, $format= true);
					} else {
						$rub = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), 'RUB', 1, $format= true);
					}

				   if ($result['currency_id'] != 2) {
						$price_dollar = $this->currency->convert($result['price'], $currency['code'], 'USD');
						$price = $this->currency->format($this->tax->calculate($price_dollar, $result['tax_class_id'], $this->config->get('config_tax')), 'USD', 1, $format= true);
					} else {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), 'USD', 1, $format= true);
					}
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), 'USD', $format= true);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}
								
				$data['text_tax'] = $this->language->get('text_tax');
				
				$stickers = $this->getStickers($result['product_id']) ;
							
				$data['products'][] = array(
					'product_id' => $result['product_id'],
					'thumb'   	 => $image,
					'model'		 => $result['model'],
					'name'    	 => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('configblog_article_description_length')) . '..',
					'price'       => $price,
					'rub'		  => $rub,
					'special' 	 => $special,
					'tax'        => $tax,
					'sticker'     => $stickers,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					'options'     => $this->model_catalog_product->getProductOptions($result['product_id']),//options
					'filter_options' => $this->model_catalog_ocfilter->getValueOptionsByProduct($result['product_id']),//options
					'uniq_options' => $result['uniq_options'] = 1 ? $result['uniq_options'] : 0,
				);
			}	
			
			$data['download_status'] = $this->config->get('configblog_article_download');
			
			$data['downloads'] = array();
			
			$results = $this->model_blog_article->getDownloads($this->request->get['article_id']);
 
            foreach ($results as $result) {
                if (file_exists(DIR_DOWNLOAD . $result['filename'])) {
                    $size = filesize(DIR_DOWNLOAD . $result['filename']);
 
                    $i = 0;
 
                    $suffix = array(
                        'B',
                        'KB',
                        'MB',
                        'GB',
                        'TB',
                        'PB',
                        'EB',
                        'ZB',
                        'YB'
                    );
 
                    while (($size / 10024) > 1) {
                        $size = $size / 10024;
                        $i++;
                    }
 
                    $data['downloads'][] = array(
                        'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                        'name'       => $result['name'],
                        'size'       => round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i],
                        'href'       => $this->url->link('blog/article/download', '&article_id='. $this->request->get['article_id']. '&download_id=' . $result['download_id'])
                    );
                }
            } 
			
			$this->model_blog_article->updateViewed($this->request->get['article_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
			
			$this->response->setOutput($this->load->view('blog/article', $data));
		} else {
			$this->document->setTitle($this->language->get('error_page'));
			
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('blog/error_article', $data));
    	}
  	}
	
	public function download() {

		$this->load->model('blog/article');

		if (isset($this->request->get['download_id'])) {
			$download_id = $this->request->get['download_id'];
		} else {
			$download_id = 0;
		}

		if (isset($this->request->get['article_id'])) {
			$article_id = $this->request->get['article_id'];
		} else {
			$article_id = 0;
		}

		$download_info = $this->model_blog_article->getDownload($article_id, $download_id);
		
		

		if ($download_info) {
			$file = DIR_DOWNLOAD . $download_info['filename'];
			$mask = basename($download_info['mask']);

			if (!headers_sent()) {
				if (file_exists($file)) {
					header('Content-Description: File Transfer');
					header('Content-Type: application/octet-stream');
					header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
					header('Content-Transfer-Encoding: binary');
					header('Expires: 0');
					header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
					header('Pragma: public');
					header('Content-Length: ' . filesize($file));

					readfile($file, 'rb');

					

					exit;
				} else {
					exit('Error: Could not find file ' . $file . '!');
				}
			} else {
				exit('Error: Headers already sent out!');
			}
		} else {
			$this->redirect(HTTP_SERVER . 'index.php?route=account/download');
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
				'image'    => HTTP_SERVER . 'image/' . $sticker['image']
			);		
		}
		
		return $stick;
	}
	
}
?>