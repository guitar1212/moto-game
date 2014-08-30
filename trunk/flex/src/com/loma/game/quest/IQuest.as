package com.loma.game.quest
{
	public interface IQuest
	{
		function set game(g:MotoGame):void
		function get game():MotoGame
			
		function set type(t:int):void
		function get type():int
			
		function set state(s:int):void
		function get state():int
	}
}