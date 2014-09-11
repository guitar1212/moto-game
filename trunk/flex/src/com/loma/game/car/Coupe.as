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
		
		public function Coupe()
		{
			super();
			
			m_probe.graphics.beginFill(0x111111);
			m_probe.graphics.drawRect(0, 0, 10, 10);
			m_probe.graphics.endFill();
			m_probe.x = 100;
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
		}
		
		public function update():void
		{
			this.x += this.speed;
		}

	}
}