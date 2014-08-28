package com.loma.game.background
{
	import flash.display.Sprite;
	
	/**
	 * 
	 * @long  Aug 28, 2014
	 * 
	 */	
	public class GameBackground extends Sprite
	{
		private var m_unitWidth:Number = 700;
		
		private var m_moveSpeed:Number = 6;
		
		public function GameBackground()
		{
			super();
			
			var a:RoadNormal = new RoadNormal();
			var b:RoadNormal = new RoadNormal(); 
			var c:RoadNormal = new RoadNormal();
			
			
			this.addChild(a);
			this.addChild(b);
			this.addChild(c);
			
			b.x += m_unitWidth;
			c.x += m_unitWidth*2;
		}
		
		
		
		public function update():void
		{
			this.x -= m_moveSpeed;
		}

		public function get moveSpeed():Number
		{
			return m_moveSpeed;
		}

		public function set moveSpeed(value:Number):void
		{
			m_moveSpeed = value;
		}

	}
}