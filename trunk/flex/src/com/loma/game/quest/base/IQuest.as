package com.loma.game.quest.base
{
	public interface IQuest
	{
		function set game(g:MotoGame):void
		function get game():MotoGame
			
		function set type(t:int):void
		function get type():int
			
		function set state(s:int):void
		function get state():int
			
		function set excuteTimes(e:int):void
		function get excuteTimes():int
			
		function set pause(b:Boolean):void
		function get pause():Boolean
	}
}