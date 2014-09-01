package com.loma.game.ui
{
	public class FirstQuestionDialog extends Quest1
	{
		public function FirstQuestionDialog()
		{
			super();
		}
		
		public function removeSelf():void
		{
			if(this.parent != null)
			{
				this.parent.removeChild(this);
			}
		}
			
	}
}