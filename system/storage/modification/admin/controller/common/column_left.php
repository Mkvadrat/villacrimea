<?php
class ControllerCommonColumnLeft extends Controller {
	public function index() {
		if (isset($this->request->get['token']) && isset($this->session->data['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
			$this->load->language('common/column_left');
	
			$this->load->model('user/user');
	
			$this->load->model('tool/image');
	
			$user_info = $this->model_user_user->getUser($this->user->getId());
	
			if ($user_info) {
				$data['firstname'] = $user_info['firstname'];
				$data['lastname'] = $user_info['lastname'];
				$data['username']  = $user_info['username'];
				$data['user_group'] = $user_info['user_group'];
	
				if (is_file(DIR_IMAGE . $user_info['image'])) {
					$data['image'] = $this->model_tool_image->resize($user_info['image'], 45, 45);
				} else {
					$data['image'] = '';
				}
			} else {
				$data['firstname'] = '';
				$data['lastname'] = '';
				$data['username'] = '';
				$data['user_group'] = '';
				$data['image'] = '';
			}			
		
			// Create a 3 level menu array
			// Level 2 can not have children
			
			// Menu
			$data['menus'][] = array(
				'id'       => 'menu-dashboard',
				'icon'	   => 'fa-dashboard',
				'name'	   => $this->language->get('text_dashboard'),
				'href'     => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
				'children' => array()
			);
			
			// BLOG
			$blog = array();

			if ($this->user->hasPermission('access', 'blog/article')) {		
				$blog[] = array(
					'name'	   => $this->language->get('text_blog_article'),
					'href'     => $this->url->link('blog/article', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);					
			}	
			
			if ($this->user->hasPermission('access', 'blog/category')) {		
				$blog[] = array(
					'name'	   => $this->language->get('text_blog_category'),
					'href'     => $this->url->link('blog/category', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}
								
			if ($this->user->hasPermission('access', 'blog/setting')) {
				$blog[] = array(
					'name'	   => $this->language->get('text_blog_setting'),
					'href'     => $this->url->link('blog/setting', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
					
			if ($blog) {					
				$data['menus'][] = array(
					'id'       => 'menu-blog',
					'icon'	   => 'fa-book', 
					'name'	   => $this->language->get('text_blog'),
					'href'     => '',
					'children' => $blog
				);		
			}
			
			// Catalog
			$catalog = array();
			
			if ($this->user->hasPermission('access', 'catalog/category')) {
				$catalog[] = array(
					'name'	   => $this->language->get('text_category'),
					'href'     => $this->url->link('catalog/category', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($this->user->hasPermission('access', 'catalog/product')) {
				$catalog[] = array(
					'name'	   => $this->language->get('text_product'),
					'href'     => $this->url->link('catalog/product', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
												
			if ($this->user->hasPermission('access', 'catalog/option')) {
				$catalog[] = array(
					'name'	   => $this->language->get('text_option'),
					'href'     => $this->url->link('catalog/option', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
						

      // OCFilter start
			$ocfilter = array();

			if ($this->user->hasPermission('access', 'catalog/ocfilter')) {
				$ocfilter[] = array(
					'name'     => $this->language->get('text_ocfilter_option'),
					'href'     => $this->url->link('catalog/ocfilter', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}

			if ($this->user->hasPermission('access', 'catalog/ocfilter_page')) {
				$ocfilter[] = array(
					'name'	   => $this->language->get('text_ocfilter_page'),
					'href'     => $this->url->link('catalog/ocfilter_page', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}

			if ($ocfilter) {
				$catalog[] = array(
					'name'	   => $this->language->get('text_ocfilter'),
					'href'     => '',
					'children' => $ocfilter
				);
			}
		  // OCFilter end
      
			if ($this->user->hasPermission('access', 'catalog/download')) {
				$catalog[] = array(
					'name'	   => $this->language->get('text_download'),
					'href'     => $this->url->link('catalog/download', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
						
			if ($this->user->hasPermission('access', 'catalog/information')) {		
				$catalog[] = array(
					'name'	   => $this->language->get('text_information'),
					'href'     => $this->url->link('catalog/information', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);					
			}
			
			if ($this->user->hasPermission('access', 'catalog/news')) {		
				$catalog[] = array(
					'name'	   => $this->language->get('text_news'),
					'href'     => $this->url->link('catalog/news', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);					
			}
			
			if ($this->user->hasPermission('access', 'catalog/news')) {		
				$catalog[] = array(
					'name'	   => $this->language->get('text_settings_news'),
					'href'     => $this->url->link('catalog/news/setting', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);					
			}
			
			
			if ($catalog) {
				$data['menus'][] = array(
					'id'       => 'menu-catalog',
					'icon'	   => 'fa-tags', 
					'name'	   => $this->language->get('text_catalog'),
					'href'     => '',
					'children' => $catalog
				);		
			}
			
	
			// Extension
			$extension = array();

			if ($this->user->hasPermission('access', 'extension/installer')) {		
				$extension[] = array(
					'name'	   => $this->language->get('text_installer'),
					'href'     => $this->url->link('extension/installer', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);					
			}	
			
			if ($this->user->hasPermission('access', 'extension/extension')) {		
				$extension[] = array(
					'name'	   => $this->language->get('text_extension'),
					'href'     => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}
					
			if ($this->user->hasPermission('access', 'extension/modification')) {
				$extension[] = array(
					'name'	   => $this->language->get('text_modification'),
					'href'     => $this->url->link('extension/modification', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($this->user->hasPermission('access', 'extension/event')) {
				$extension[] = array(
					'name'	   => $this->language->get('text_event'),
					'href'     => $this->url->link('extension/event', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
					
			if ($extension) {					
				$data['menus'][] = array(
					'id'       => 'menu-extension',
					'icon'	   => 'fa-puzzle-piece', 
					'name'	   => $this->language->get('text_extension'),
					'href'     => '',
					'children' => $extension
				);		
			}
			
			// Design
			$design = array();
			
			if ($this->user->hasPermission('access', 'design/layout')) {
				$design[] = array(
					'name'	   => $this->language->get('text_layout'),
					'href'     => $this->url->link('design/layout', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'design/custommenu')) {
				$design[] = array(
					'name'	   => $this->language->get('text_custommenu'),
					'href'     => $this->url->link('design/custommenu', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'design/custommenu_footer')) {
				$design[] = array(
					'name'	   => $this->language->get('text_custommenu_footer'),
					'href'     => $this->url->link('design/custommenu_footer', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'design/sticker')) {
				$design[] = array(
					'name'	   => $this->language->get('text_sticker'),
					'href'     => $this->url->link('design/sticker', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}

			if ($this->user->hasPermission('access', 'design/banner')) {
				$design[] = array(
					'name'	   => $this->language->get('text_banner'),
					'href'     => $this->url->link('design/banner', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($design) {
				$data['menus'][] = array(
					'id'       => 'menu-design',
					'icon'	   => 'fa-television', 
					'name'	   => $this->language->get('text_design'),
					'href'     => '',
					'children' => $design
				);	
			}
												
			// System
			$system = array();
			
			if ($this->user->hasPermission('access', 'setting/setting')) {
				$system[] = array(
					'name'	   => $this->language->get('text_setting'),
					'href'     => $this->url->link('setting/store', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
		
			// Users
			$user = array();
			
			if ($this->user->hasPermission('access', 'user/user')) {
				$user[] = array(
					'name'	   => $this->language->get('text_users'),
					'href'     => $this->url->link('user/user', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'user/user_permission')) {	
				$user[] = array(
					'name'	   => $this->language->get('text_user_group'),
					'href'     => $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'user/api')) {		
				$user[] = array(
					'name'	   => $this->language->get('text_api'),
					'href'     => $this->url->link('user/api', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($user) {
				$system[] = array(
					'name'	   => $this->language->get('text_users'),
					'href'     => '',
					'children' => $user		
				);
			}
			
			// Localisation
			$localisation = array();
			
			if ($this->user->hasPermission('access', 'localisation/location')) {
				$localisation[] = array(
					'name'	   => $this->language->get('text_location'),
					'href'     => $this->url->link('localisation/location', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'localisation/language')) {
				$localisation[] = array(
					'name'	   => $this->language->get('text_language'),
					'href'     => $this->url->link('localisation/language', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($this->user->hasPermission('access', 'localisation/currency')) {
				$localisation[] = array(
					'name'	   => $this->language->get('text_currency'),
					'href'     => $this->url->link('localisation/currency', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
																		
			if ($this->user->hasPermission('access', 'localisation/country')) {
				$localisation[] = array(
					'name'	   => $this->language->get('text_country'),
					'href'     => $this->url->link('localisation/country', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($this->user->hasPermission('access', 'localisation/zone')) {
				$localisation[] = array(
					'name'	   => $this->language->get('text_zone'),
					'href'     => $this->url->link('localisation/zone', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($this->user->hasPermission('access', 'localisation/geo_zone')) {
				$localisation[] = array(
					'name'	   => $this->language->get('text_geo_zone'),
					'href'     => $this->url->link('localisation/geo_zone', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}
			
			// Tax		
			$tax = array();
			
			if ($this->user->hasPermission('access', 'localisation/tax_class')) {
				$tax[] = array(
					'name'	   => $this->language->get('text_tax_class'),
					'href'     => $this->url->link('localisation/tax_class', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}
			
			if ($this->user->hasPermission('access', 'localisation/tax_rate')) {
				$tax[] = array(
					'name'	   => $this->language->get('text_tax_rate'),
					'href'     => $this->url->link('localisation/tax_rate', 'token=' . $this->session->data['token'], true),
					'children' => array()
				);
			}
			
			if ($tax) {	
				$localisation[] = array(
					'name'	   => $this->language->get('text_tax'),
					'href'     => '',
					'children' => $tax		
				);
			}
									
			if ($localisation) {																
				$system[] = array(
					'name'	   => $this->language->get('text_localisation'),
					'href'     => '',
					'children' => $localisation	
				);
			}
			
			// Tools	
			$tool = array();
			
			if ($this->user->hasPermission('access', 'tool/upload')) {
				$tool[] = array(
					'name'	   => $this->language->get('text_upload'),
					'href'     => $this->url->link('tool/upload', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);	
			}
			
			if ($this->user->hasPermission('access', 'tool/backup')) {
				$tool[] = array(
					'name'	   => $this->language->get('text_backup'),
					'href'     => $this->url->link('tool/backup', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}
			
			if ($this->user->hasPermission('access', 'tool/log')) {
				$tool[] = array(
					'name'	   => $this->language->get('text_log'),
					'href'     => $this->url->link('tool/log', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}

			/* octeam */
			if ($this->user->hasPermission('access', 'octeam/toolset')) {
				$tool[] = array(
					'name'	   => $this->language->get('text_octeam_toolset'),
					'href'     => $this->url->link('octeam/toolset', 'token=' . $this->session->data['token'], true),
					'children' => array()		
				);
			}

			if ($tool) {
				$system[] = array(
					'name'	   => $this->language->get('text_tools'),
					'href'     => '',
					'children' => $tool	
				);
			}
			
			if ($system) {
				$data['menus'][] = array(
					'id'       => 'menu-system',
					'icon'	   => 'fa-cog', 
					'name'	   => $this->language->get('text_system'),
					'href'     => '',
					'children' => $system
				);
			}
			
			// Stats
			$data['text_complete_status'] = $this->language->get('text_complete_status');
			$data['text_processing_status'] = $this->language->get('text_processing_status');
			$data['text_other_status'] = $this->language->get('text_other_status');
	
			$this->load->model('sale/order');
	
			$order_total = $this->model_sale_order->getTotalOrders();
	
			$complete_total = $this->model_sale_order->getTotalOrders(array('filter_order_status' => implode(',', $this->config->get('config_complete_status'))));
			
			if ($complete_total) {
				$data['complete_status'] = round(($complete_total / $order_total) * 100);
			} else {
				$data['complete_status'] = 0;
			}
	
			$processing_total = $this->model_sale_order->getTotalOrders(array('filter_order_status' => implode(',', $this->config->get('config_processing_status'))));
	
			if ($processing_total) {
				$data['processing_status'] = round(($processing_total / $order_total) * 100);
			} else {
				$data['processing_status'] = 0;
			}
	
			$this->load->model('localisation/order_status');
	
			$order_status_data = array();
	
			$results = $this->model_localisation_order_status->getOrderStatuses();
	
			foreach ($results as $result) {
				if (!in_array($result['order_status_id'], array_merge($this->config->get('config_complete_status'), $this->config->get('config_processing_status')))) {
					$order_status_data[] = $result['order_status_id'];
				}
			}
	
			$other_total = $this->model_sale_order->getTotalOrders(array('filter_order_status' => implode(',', $order_status_data)));
	
			if ($other_total) {
				$data['other_status'] = round(($other_total / $order_total) * 100);
			} else {
				$data['other_status'] = 0;
			}
			
			return $this->load->view('common/column_left', $data);
		}
	}
}