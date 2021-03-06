<?php
class ControllerExtensionModuleNews extends Controller {

	public function index($setting) {
	
		$this->load->language('extension/module/news');
	
		$this->load->model('localisation/language');
	
		$languages = $this->model_localisation_language->getLanguages();
	
		if($setting['show_title']){
      		$data['heading_title'] = $this->language->get('heading_title');
		}else{
      		$data['heading_title'] = '';
		}

		if($setting['show_icon']){
      		$data['show_icon'] = true;
		}else{
      		$data['show_icon'] = false;
		}
	
		$this->load->model('catalog/news');
	
		$data['text_more'] = $this->language->get('text_more');

		$data['text_date_added'] = $this->language->get('text_date_added');
			
		$data['button_list'] = $this->language->get('button_list');
	
		$data['news_list'] = $this->url->link('information/news');
		
		$data['news'] = array();

		$data['show_title'] = $setting['show_title'];
		
		$data['show_icon']  = $setting['show_icon'];
		
		$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
		
		$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

		$results = $this->model_catalog_news->getNewsShorts($setting['limit']);
		
		$this->load->model('tool/image');
	
		foreach ($results as $result) {
			if ($result['image']) {
 				$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
 			} else {
 				$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
 			}
			
			$data['news'][] = array(
				'title'        		=> $result['title'],
				'thumb' 			=> $image,
				'viewed' 			=> sprintf($this->language->get('text_viewed'), $result['viewed']),
				'description'  		=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['desc_limit']) . '...',
				'href'         		=> $this->url->link('information/news/info', 'news_id=' . $result['news_id']),
				'posted'   			=> date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}
	
		if ($data['news']) {
			return $this->load->view('extension/module/news', $data);
		}
	}
}
