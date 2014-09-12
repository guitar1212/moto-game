package com.loma.util
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * 
	 * @long  Sep 12, 2014
	 * 
	 */	
	public function SimpleButtonSetter(btn:SimpleButton, text:String):void
	{
		var upState:Sprite = btn.upState as Sprite;
		var upTextField:TextField = upState.getChildAt(1) as TextField;
		upTextField.text = text;
		
		var downState:Sprite = btn.downState as Sprite;
		var downTextField:TextField = downState.getChildAt(1) as TextField;
		downTextField.text = text;
		
		var overState:Sprite = btn.overState as Sprite;
		var overTextField:TextField = overState.getChildAt(1) as TextField;
		overTextField.text = text;
	}
}