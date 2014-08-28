package com.loma.game.player
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @long  Aug 27, 2014
	 * 
	 */	
	public class Rider extends Sprite
	{
		public static const STATE_START:int = 1;
		public static const STATE_STOP:int = 2;
		public static const STATE_MOVE:int = 3;
		
		public static const MOVE_NONE:String = "no";
		public static const MOVE_UP:String = "up";
		public static const MOVE_DOWN:String = "down";
		
		private var m_mc:Role;
		
		private var m_moveDir:String;
		
		public function Rider()
		{
			super();
			
			m_mc = new Role();
			
			this.addChild(m_mc);
			
			this.state = Rider.STATE_MOVE;
		}
		
		public function set state(_state:int):void
		{
			m_mc.gotoAndStop(_state);
		}
		
		public function set moveDirection(dir:String):void
		{
			m_moveDir = dir;
		}
		
		public function get moveDirection():String
		{			
			return m_moveDir;
		}
		
	}
}