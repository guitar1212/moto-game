package com.loma.game.oil
{
	/**
	 * 
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class OilManager
	{
		private static var m_instance:OilManager = null;
		
		private var m_game:MotoGame;
		
		// in second
		private var m_totalPlayFrames:int;
	
		
		private var m_count:int = 0;
		
		public function OilManager()
		{
		}
		
		public static function get instance():OilManager
		{
			if(m_instance == null)
				m_instance = new OilManager();
			
			return m_instance;
		}
		
		public function initialize(g:MotoGame, playTime:int):void
		{
			m_game = g;
			m_totalPlayFrames = playTime*g.stage.frameRate;
			m_count = 0;
		}
		
		public function update():void
		{
			m_count++;		
			
			var useOil:int = ~~(m_count*100/m_totalPlayFrames);
			m_game.ui.oil = 100 - useOil;
		}
		
		public function isOilEmpty():Boolean
		{
			return m_count >= m_totalPlayFrames; 
		}
			
	}
}