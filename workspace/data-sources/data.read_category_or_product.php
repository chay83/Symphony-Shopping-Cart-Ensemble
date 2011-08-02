<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceread_category_or_product extends Datasource{

		public $dsParamROOTELEMENT = 'read-category-or-product';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		

		

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Read: Category or Product',
				'author' => array(
					'name' => 'Chay Palmer',
					'website' => 'http://chay.sites.randb.com.au/wired',
					'email' => 'chay@randb.com.au'),
				'version' => '1.0',
				'release-date' => '2011-06-03T03:47:03+00:00'
			);
		}

		public function getSource(){
			return '3';
		}

		public function allowEditorToParse(){
			return true;
		}

		public function grab(&$param_pool=NULL){
			$page = Frontend::Page();
			$domain = explode('/',DOMAIN);
			$uri = explode('/',$_SERVER['REQUEST_URI']);
			
			$paras = $page->_param;
			
			for ($i = 1; $i <= 10; $i++) {
				if($paras['level-' . $i] != null){
			    	$levels[] = $paras['level-' . $i];
			    }
			}
			
			$current_page = end($levels);
			
			$sym = Symphony::ExtensionManager()->getInstance('SymQuery');
			
			
			$product_id = SymRead('products')
				->get(SymQuery::SYSTEM_ID)
				->where('title', $current_page)
				->readDataIterator();
				
			$product_id = $product_id->current();	
			
			if(!empty($product_id)){
				$pagemode = 'product';
				$param_pool["product-id"] = $product_id["system:id"];
			}else{
				$category_id = SymRead('categories')
					->get(SymQuery::SYSTEM_ID)
					->where('name', $current_page)
					->readDataIterator();
					
				$category_id = $category_id->current();
				
				if(!empty($category_id)){
					$pagemode = 'category';
				}else{
					$error = '404';				
				}								
			}
			
			if($pagemode == 'category'){
				/* Get Sub Categories */
				$subcategories = SymRead('categories')
					->get(SymQuery::SYSTEM_ID)
					->where('parent', $category_id)
					->readDataIterator();
				
				if($subcategories->valid()) foreach($subcategories as $subcategory) {
					$subcategory_ids[] = $subcategory['system:id'];
				}
					
					
				if(!empty($subcategory_ids)){
					$scexists = true;
					$templist = $subcategory_ids;
					while ($scexists) {
						$subcategories = SymRead('categories')
							->get(SymQuery::SYSTEM_ID)
							->where('parent', array_pop($templist))
							->readDataIterator();
						
						if($subcategories->valid()){ 
							foreach($subcategories as $subcategory) {
								$subcategory_ids[] = $subcategory['system:id'];
								$templist[] = $subcategory['system:id'];
							}
						}else if(empty($templist)){
							$scexists = false;
						}
										
					}
				}
				$subcategory_ids = implode(',', $subcategory_ids);
				$param_pool['category-ids'] = $category_id["system:id"] . ',' . $subcategory_ids;
				$param_pool['current-category'] = $category_id["system:id"];
			}			
			
			$param_pool['mode'] = $pagemode;
			
			return;
			
		}

	}
