<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceread_category_information extends Datasource{

		public $dsParamROOTELEMENT = 'read-category-information';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamREQUIREDPARAM = '$current-category';
		public $dsParamPARAMOUTPUT = 'parent';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'id' => '{$current-category}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'name: formatted',
				'parent',
				'description: formatted'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-read-category-or-product');
		}

		public function about(){
			return array(
				'name' => 'Read: Category Information',
				'author' => array(
					'name' => 'Chay Palmer',
					'website' => 'http://chay.sites.randb.com.au/wired',
					'email' => 'chay@randb.com.au'),
				'version' => '1.0',
				'release-date' => '2011-06-06T04:13:30+00:00'
			);
		}

		public function getSource(){
			return '4';
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
