package com.loma.game.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * 
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class GameOverDialog extends Sprite
	{
		public function GameOverDialog()
		{
			super();
			
			onCreate();
		}
		
		protected function onCreate():void
		{
			var tf:TextFormat = new TextFormat();
			tf.size = 48;
			tf.color = 0xff2233;
			tf.bold = true;
			tf.italic = true;
			
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.CENTER;
			t.defaultTextFormat = tf;
			t.text = "Game Over!\nPress 'ESC' to restart";
			t.x = (700 - t.width)/2;
			t.y = (500 - t.height)/2;
			
			this.addChild(t);
		}
	}
}