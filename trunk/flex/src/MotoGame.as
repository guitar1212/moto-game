package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * 
	 * @long  Aug 26, 2014
	 * 
	 */	
	[SWF(backgroundColor="#aa0000", frameRate="30", width="700", height="500")]
	public class MotoGame extends Sprite
	{
		public function MotoGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
			
			
		}
		
		protected function onUpdate(event:Event):void
		{
			
			
		}
	}
}