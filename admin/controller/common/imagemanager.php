<?php
class ControllerCommonImageManager extends Controller {
	public function index() {
		
		$this->load->language('common/imagemanager');
		
		$this->document->setTitle($this->language->get('text_imagemanager'));
			
		$data['heading_title'] = $this->language->get('text_imagemanager');
				
		$string = $this->request->server['HTTP_REFERER'];
		
		if(stristr($string, 'banner_id')){
			$data['separator'] = true;
		}else{
			$data['separator'] = false;
		}
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
				
		if (isset($this->request->get['thumb'])) {
            $data['thumb'] = $this->request->get['thumb'];
        } else {
            $data['thumb'] = '';
        }
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			   $catalog_protocol = HTTPS_CATALOG;
		} else {
			  $catalog_protocol = HTTP_CATALOG;
		}
	
		$data['sound_path'] = $catalog_protocol . 'sounds/';
								
		if (isset($this->request->get['target'])) {
            $data['target'] = $this->request->get['target'];
        } else {
            $data['target'] = '';
        }
											
		$this->response->setOutput($this->load->view('common/imagemanager.tpl', $data));
	}
	
	public function getTmb(){
		
		if (isset($this->request->get['thumb'])) {
			$str_link = str_replace('\\','/', $this->request->get['thumb']);
			$link = urldecode($str_link);
		}
				
		$this->load->model('tool/image');
		
		$data['thumb'] = $this->model_tool_image->resize($link, 100, 100);
		
		$data['link'] = $link;
		
		$this->response->setOutput(json_encode($data));
	}
		
	public function init(){
				
		include_once DIR_SYSTEM . 'library/imagemanager/autoload.php';
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			   $catalog_protocol = HTTPS_CATALOG;
		} else {
			  $catalog_protocol = HTTP_CATALOG;
		}

		$opts = array(
			'debug' => true,

			'roots' => array(
				array(
					'driver'        => 'LocalFileSystem',   // driver for accessing file system (REQUIRED)
					'path'          => DIR_IMAGE . 'catalog/',         // path to files (REQUIRED)
					'URL'           => $catalog_protocol . 'image/catalog/', // URL to files (REQUIRED)
					'trashHash'     => 't1_Lw',                     // elFinder's hash of trash folder
					'winHashFix'    => DIRECTORY_SEPARATOR !== '/', // to make hash same to Linux one on windows too
					'accessControl' => 'access' ,            // disable and hide dot starting files (OPTIONAL)
					'defaults' => array('read' => true, 'write' => true),
					'uploadMaxSize'=>'200M',
					'uploadAllow' => array(
						'image/jpeg',
						'image/pjpeg',
						'image/png',
						'image/x-png',
						'image/gif',
						'application/x-shockwave-flash'
					),
					'uploadOverwrite'=>true,
					'uploadOrder'=> array( 'allow', 'deny' ),
					'attributes' => array(
						array(
							'pattern' => '~/\.~',
							'read' => true,
							'write' => true,
							'hidden' => true,
							'locked' => false
						)
					)
				),
				// Trash volume
				array(
					'id'            => '1',
					'driver'        => 'Trash',
					'path'          => DIR_IMAGE . 'files/.trash/',
					'tmbURL'        => $catalog_protocol . 'files/.trash/.tmb/',
					'winHashFix'    => DIRECTORY_SEPARATOR !== '/', // to make hash same to Linux one on windows too
					'uploadMaxSize'=>'200M',
					'defaults' => array('read' => true, 'write' => true),
					'uploadAllow' => array(
						'image/jpeg',
						'image/pjpeg',
						'image/png',
						'image/x-png',
						'image/gif',
						'application/x-shockwave-flash'
					),
					'uploadOrder'=> array( 'allow', 'deny' ),     // Same as above
					'accessControl' => 'access',                    // Same as above
					'attributes' => array(
						array(
							'pattern' => '~/\.~',
							'read' => true,
							'write' => true,
							'hidden' => true,
							'locked' => false
						)
					)
				)
			)
		);

		// run elFinder
		$connector = new elFinderConnector(new elFinder($opts));
		$connector->run();
		
	}	
}
