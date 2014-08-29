package com.loma.game.quest
{
	public interface IQuest
	{
		function set type(t:int):void
		function get type():int
			
		function start():void
		
		function onUpdate():void
			
		function end():void
	}
}