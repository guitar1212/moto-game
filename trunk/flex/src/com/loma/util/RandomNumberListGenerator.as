package com.loma.util
{
	/**
	 * 
	 * @long  Sep 15, 2014
	 * 
	 */
	public function RandomNumberListGenerator(totalNumbers:int):Array
	{
		var tempArr:Array = [];
		for(var i:int = 0; i < totalNumbers; i++)
			tempArr.push(i);
		
		var arr:Array = [];
		for(i = 0; i < totalNumbers; i++)
		{
			var ri:int = ~~(Math.random()*(tempArr.length - 1) + 0.5);
			arr.push(tempArr.splice(ri, 1));
		}
		return arr;
	}
}