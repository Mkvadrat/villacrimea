<?php
class ControllerExtensionModulePresentation extends Controller {
	public function index($setting) {
		if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			
			$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');
			
			if ($setting['image']) {
				$data['image'] = $this->model_tool_image->resize($setting['image'], 953, 586);
			} else {
				$data['image'] = '';
			}
			
			$this->load->model('account/download');
			
			$data['main_download_presentation'] = array();
			
			if(!empty($setting['main_download_presentation'])){
				$download_main_ids = $setting['main_download_presentation'];
				
				$download_data = array();
				
				if($download_main_ids){
					foreach($download_main_ids as $download_id){
						$results = $this->model_account_download->getDownloadData($download_id);
						
						$download_data = array(
							'download_id' => $results['download_id'],
							'filename'    => $results['filename'],
							'name'        => $results['name'],
						);
			
						if (file_exists(DIR_DOWNLOAD . $download_data['filename'])) {
							$size = filesize(DIR_DOWNLOAD . $download_data['filename']);
								
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
			
							while (($size / 1024) > 1) {
								$size = $size / 1024;
								$i++;
							}
			
							$data['main_download_presentation'][] = array(
								'name'       => $download_data['name'],
								'href'       => $this->url->link('extension/module/presentation/download', 'download_id=' . $download_data['download_id'], true)
							);
						
						}
					}
				}
			}
			
			$data['second_download_presentation'] = array();
			
			if(!empty($setting['second_download_presentation'])){
				$download_second_ids = $setting['second_download_presentation'];
				
				if($download_second_ids){
					foreach($download_second_ids as $download_id){
						$results = $this->model_account_download->getDownloadData($download_id);
						
						$download_data = array(
							'download_id' => $results['download_id'],
							'filename'    => $results['filename'],
							'name'        => $results['name'],
						);
			
						if (file_exists(DIR_DOWNLOAD . $download_data['filename'])) {
							$size = filesize(DIR_DOWNLOAD . $download_data['filename']);
								
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
			
							while (($size / 1024) > 1) {
								$size = $size / 1024;
								$i++;
							}
			
							$data['second_download_presentation'][] = array(
								'name'       => $download_data['name'],
								'href'       => $this->url->link('extension/module/presentation/download', 'download_id=' . $download_data['download_id'], true)
							);
						
						}
					}
				}
			}
			

			return $this->load->view('extension/module/presentation', $data);
		}
	}
	
	public function download() {
		$this->load->model('account/download');

		if (isset($this->request->get['download_id'])) {
			$download_id = $this->request->get['download_id'];
		} else {
			$download_id = 0;
		}

		$download_info = $this->model_account_download->getDownloadData($download_id);
		
		if ($download_info) {
			$file = DIR_DOWNLOAD . $download_info['filename'];
			$mask = basename($download_info['mask']);

			if (!headers_sent()) {
				if (file_exists($file)) {
					header('Content-Type: application/octet-stream');
					header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
					header('Expires: 0');
					header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
					header('Pragma: public');
					header('Content-Length: ' . filesize($file));

					if (ob_get_level()) {
						ob_end_clean();
					}

					readfile($file, 'rb');

					exit();
				} else {
					exit('Error: Could not find file ' . $file . '!');
				}
			} else {
				exit('Error: Headers already sent out!');
			}
		} else {
			$this->response->redirect($this->url->link('common/home', '', true));
		}
	}
}