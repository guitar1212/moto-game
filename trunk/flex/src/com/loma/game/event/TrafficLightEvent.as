package com.loma.game.event
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 
	 * @long  Sep 12, 2014
	 * 
	 */	
	public class TrafficLightEvent extends Event
	{
		public static const RED:String = "red";
		public static const GREEN:String = "green";
		
		public function TrafficLightEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var hitArea:Sprite;
	}
}