package com.loma.util
{
	/**
	 * 
	 * @long  Aug 26, 2014
	 * 
	 */	
	public class StageManager
	{
		static private var m_instance:StageManager = null;
		
		public function StageManager()
		{
		}
		
		
		public static function instance():StageManager
		{
			if(m_instance == null)
				m_instance = new StageManager();
			
			return m_instance;
		}
		
		public static function 
	}
}