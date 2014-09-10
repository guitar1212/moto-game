package com.loma.game
{
	import com.loma.util.TimerManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @long  Sep 10, 2014
	 * 
	 */	
	public class TrafficLight extends Sprite
	{		
		private var m_mc:TrafficLightItem;
		private var m_light:String;
		
		
		public function TrafficLight()
		{
			super();
			
			create();
		}
		
		private function create():void
		{
			// TODO Auto Generated method stub
			m_mc = new TrafficLightItem();
			this.addChild(m_mc);
		}
		
		public function start():void
		{
			TimerManager.instance.register(onTimeUp, 3000, 30);
		}
		
		private function onTimeUp():void
		{
			if(light == "green")
				light = "red";
			else if(light == "red")
				light = "green";
		}
		
		public function set light(value:String):void
		{
			m_light = value;
			if(value == "red")
				m_mc.gotoAndStop(1);
			else if(value == "yellow")
				m_mc.gotoAndStop(2);
			else if(value == "green")
				m_mc.gotoAndStop(3);
		}
		
		public function get light():String
		{
			return m_light;
		}
		
		public function release():void
		{
			// TODO Auto Generated method stub
			this.removeChild(m_mc);
		}
	}
}