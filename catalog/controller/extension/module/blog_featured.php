<?php
// *	@copyright	OPENCART.PRO 2011 - 2017.
// *	@forum	http://forum.opencart.pro
// *	@source		See SOURCE.txt for source and other copyright.
// *	@license	GNU General Public License version 3; see LICENSE.txt

class ControllerExtensionModuleBlogFeatured extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/blog_featured');

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['configblog_html_h1'] = $this->language->get('text_sub_title');
		
		$data['text_descr'] = $this->language->get('text_descr');
		$data['text_views'] = $this->language->get('text_views');
		$data['button_more'] = $this->language->get('button_more');
		$data['button_article'] = $this->language->get('button_article');
		
		$data['all_blog'] = $this->url->link('blog/latest', '');
		
		$this->load->model('blog/article');
		
		$this->load->model('blog/category');

		$this->load->model('tool/image');

		$data['articles'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}
		
		$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
		
		$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

		if (!empty($setting['article'])) {
			$articles = array_slice($setting['article'], 0, (int)$setting['limit']);

			foreach ($articles as $article_id) {
				$article_info = $this->model_blog_article->getArticle($article_id);
				
				if ($article_info) {
					if ($article_info['image']) {
						$image = $this->model_tool_image->resize($article_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}
					
					$data['configblog_review_status'] = $this->config->get('configblog_review_status');

					if ($this->config->get('configblog_review_status')) {
						$rating = $article_info['rating'];
					} else {
						$rating = false;
					}
					
					$agent_info = $this->model_blog_category->getCategoryByArticleId($article_info['article_id']);

					if (!empty($agent_info[0]['image'])) {
						$image_agent = $this->model_tool_image->resize($agent_info[0]['image'], $setting['width'], $setting['height']);
					} else {
						$image_agent = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}
													
					$data['articles'][] = array(
						'article_id'  => $article_info['article_id'],
						'thumb'       => $image,
						'name'        => $article_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('configblog_article_description_length')) . '..',
						'short_description' => html_entity_decode($article_info['short_description'], ENT_QUOTES, 'UTF-8'), 0, 100 . '..',
						'date_added'  => date($this->language->get('date_format_short'), strtotime($article_info['date_added'])),
						'href'        => $this->url->link('blog/article', 'article_id=' . $article_info['article_id']),
						'agent'       => isset($agent_info[0]['name']) ? $agent_info[0]['name'] : '',
						'image_agent' => $image_agent
					);
				}
			}
		}
		
		$data['view_all_featured_cases'] =$this->url->link('blog/category', 'blog_category_id=3');

		if ($data['articles']) {
			return $this->load->view('extension/module/blog_featured', $data);
		}
	}
}