package com.loma.game.car
{
	import flash.display.Sprite;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class Coupe extends Car
	{
		private var m_speed:Number = 0;
		private var m_probe:Sprite = new Sprite();
		
		private var m_curSpeed:Number = 0;
		
		public function Coupe()
		{
			super();
			
			m_probe.graphics.beginFill(0x111111);
			m_probe.graphics.drawRect(0, 0, 150, 10);
			m_probe.graphics.endFill();
			m_probe.x = 0;
			m_probe.visible = false;
			this.addChild(m_probe);
		}

		public function get speed():Number
		{
			return m_speed;
		}

		public function set speed(value:Number):void
		{
			m_speed = value;
			m_curSpeed = value;
		}
		
		public function update():void
		{
			var ds:Number = this.speed - m_curSpeed;
			if(ds > 3)
				ds = 3;
			
			m_curSpeed = m_curSpeed + ds;
			
			if(m_curSpeed > speed)
				m_curSpeed = speed;
			
			this.x += m_curSpeed;
		}
		
		public function stopMove():void
		{
			m_curSpeed = 0;
		}
		
		public function get probe():Sprite
		{
			return m_probe;
		}

		public function slowDown(value:int):void
		{
			m_curSpeed -= value;
			if(m_curSpeed < 0)
				m_curSpeed = 0;
		}
	}
}