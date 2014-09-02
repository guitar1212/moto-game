package com.loma.game.car
{
	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class Coupe extends Car
	{
		private var m_speed:Number = 0;
		public function Coupe()
		{
			super();
		}

		public function get speed():Number
		{
			return m_speed;
		}

		public function set speed(value:Number):void
		{
			m_speed = value;
		}

	}
}