package com.loma.game.ui
{
	/**
	 * 
	 * @long  Aug 28, 2014
	 * 
	 */	
	public class GameUI extends UI
	{
		private var m_maxLife:int = 5;
		
		public function GameUI()
		{
			super();
			
			speed = 0;
			oil = 0;
			score = 0;
			
			m_maxLife = LifeBar_mc.totalFrames - 1;
			
			life = m_maxLife;			
		}
		
		public function set speed(value:int):void
		{
			speed_num.text = value.toString();
		}
		
		/**
		 * 
		 * @param value 0 - 100
		 * 
		 */		
		public function set oil(value:int):void
		{
			value = 100 - value;
			var maxFram:int = oil_num.totalFrames;
			var frame:int = value/100*(maxFram - 1) + 1;
			
			oil_num.gotoAndStop(frame);
		}
		
		public function set score(value:int):void
		{
			score_num.text = value.toString();
		}
		
		public function show(value:Boolean):void
		{
			this.visible = value;
		}
		
		/**
		 *	 
		 * @param value 1 - 6
		 * 
		 */		
		public function set life(value:int):void
		{
			if(value > m_maxLife)
				value = m_maxLife;
			else if(value < 0)
				value = 0;
			
			LifeBar_mc.gotoAndStop(m_maxLife - value + 1);
		}
	}
}