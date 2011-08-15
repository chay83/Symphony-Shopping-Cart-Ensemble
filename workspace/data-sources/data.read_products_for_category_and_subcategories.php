<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceread_products_for_category_and_subcategories extends Datasource{

		public $dsParamROOTELEMENT = 'read-products-for-category-and-subcategories';
		public $dsParamORDER = 'asc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'order';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'13' => '{$category-ids}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'title: formatted',
				'image',
				'price: formatted',
				'featured',
				'categories',
				'tags',
				'order',
				'quick-description: formatted'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Read: Products for Category and Subcategories',
				'author' => array(
					'name' => 'Chay Palmer',
					'website' => 'http://chay.sites.randb.com.au/wired',
					'email' => 'chay@randb.com.au'),
				'version' => 'Symphony 2.2.2',
				'release-date' => '2011-08-02T02:07:40+00:00'
			);
		}

		public function getSource(){
			return '3';
		}

		public function allowEditorToParse(){
			return true;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			

			return $result;
		}

	}
