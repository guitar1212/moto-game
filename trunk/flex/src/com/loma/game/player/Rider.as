package com.loma.game.player
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
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
		
		public static const MAX_X:int = 270;
		public static const MIN_X:int = 60;
		
		private var m_mc:Role;
		
		private var m_moveDir:String;
		
		public function Rider()
		{
			super();
			
			m_mc = new Role();
			
			this.addChild(m_mc);
			
			this.state = Rider.STATE_MOVE;
			
			isBreak = false;
			
			//m_mc.transform.colorTransform = new ColorTransform(0, 1, 1, 1, 0.5);
		}
		
		public function set state(_state:int):void
		{
			m_mc.gotoAndStop(_state);
		}
		
		public function get state():int
		{
			return m_mc.currentFrame;
		}
		
		public function set moveDirection(dir:String):void
		{
			m_moveDir = dir;
		}
		
		public function get moveDirection():String
		{			
			return m_moveDir;
		}
		
		public function set isBreak(b:Boolean):void
		{
			if(b)
			{
				m_mc.light_mc.gotoAndStop(1);
			}
			else
			{
				m_mc.light_mc.gotoAndStop(2);
			}
		}
		
	}
}