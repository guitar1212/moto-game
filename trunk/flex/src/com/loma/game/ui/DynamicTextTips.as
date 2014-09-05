package com.xpec.c4.tips
{
	import com.xpec.jade.util.TimerManager;
	import com.xpec.uitools.UIUtility;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;

	/**
	 * 
	 * @author long
	 * 
	 */	
	public class DynamicTextTips
	{
		private static var m_instance:DynamicTextTips = null;
		
		private var m_dict:Dictionary = new Dictionary();
		private var m_index:int = 0;
			
		private var m_container:DisplayObjectContainer = null;
		
		public static var PLAYER_ATTRIBUTE_COLOR:String = "ff7d00";
		public static var PLAYER_ATTRIBUTE_DURATION:Number = 1500;
		public static var PLAYER_ATTRIBUTE_SIZE:int = 16;
		public static var PLAYER_ATTRIBUTE_SPEED:int = 1;
		
		public function DynamicTextTips()
		{
			TimerManager.instance.register(onTimer, 1/60*1000, -1, TimerManager.RETURN_DELTA_TIME);
		}
		
		public static function get instance():DynamicTextTips
		{
			if(m_instance == null)
				m_instance = new DynamicTextTips();
			
			return m_instance;
		}
		
		public function set container(_containcer:DisplayObjectContainer):void
		{
			m_container = _containcer;
		}
		
		private function register(dyObj:DynamicTipObject, style:int, duration:Number, speed:int):void
		{
			var data:Object = {};
			data["key"] = m_index;
			if(style == 1)
				data["style"] = jumpBehavier;
			else
				data["style"] = defaultBehavier;
			
			data["duration"] = duration;
			data["content"] = dyObj;
			data["speed"] = speed;
			if(m_container)
				m_container.addChild(dyObj);
			
			m_dict[m_index] = data;
			
			m_index++;
		}
		
		public function createDisplayObject(obj:DisplayObject, start:Point, style:int = 0, duration:Number = 1000, speed:int = 1):void
		{
			var dyObj:DynamicTipObject = new DynamicTipObject();
			if(start == null)
				dyObj.startPoint = new Point(m_container.stage.stageWidth*0.473, m_container.stage.stageHeight*0.53);
			else
				dyObj.startPoint = start;
			
			dyObj.addChild(obj);
			
			register(dyObj, style, duration, speed);
			
			
		}
		
		public function create(content:String, color:String, start:Point, size:int = 14, style:int = 0, duration:Number = 1000, speed:int = 1):void
		{
			var dyObj:DynamicTipObject = new DynamicTipObject();
			if(start == null)
				dyObj.startPoint = new Point(m_container.stage.stageWidth*0.473, m_container.stage.stageHeight*0.53);
			else
				dyObj.startPoint = start;
			
			var text:TextField = new TextField();
			text.autoSize = TextFieldAutoSize.LEFT;
			text.selectable = false;
			text.mouseEnabled = false;
			text.filters = UIUtility.instance.textBlackFilters;
			text.htmlText = "<font color='#" + color + "' size='" + size + "'><b>" + content + "</b></font>";			
			dyObj.addChild(text);
			
			register(dyObj, style, duration, speed);
		}
		
		private function onTimer(dt:Number):void
		{			
			for each(var data:Object in m_dict)
			{
				data["duration"] -= dt;
				if(data["duration"] < 0)
				{		
					this.remove(data["key"]);
					continue;
				}
				
				var f:Function = data["style"];
				if(f != null)
					f(data["content"], data["speed"]);
				
			}
		}
		
		
		private function remove(key:int):void
		{
			if(this.m_dict[key] == null) return;
			
			var data:Object = m_dict[key];
			
			var content:DynamicTipObject = data["content"] as DynamicTipObject;
			if(content.parent)
				content.parent.removeChild(content);
			content.release();
			content = null;
			
			data["content"] = null;
			delete data["content"];
			
			data["style"] = null;			
			delete data["style"];
			
			this.m_dict[key] = null;
			delete this.m_dict[key];
			
			data = null;
		}
		
		public function removeAll():void
		{
			for each(var data:Object in m_dict)
			{
				remove(data["key"]);
			}
		}
		
		/**
		 *	預設的動態行為 
		 * @param text
		 * 
		 */		
		private function defaultBehavier(obj:DynamicTipObject, speed:int):void
		{
			obj.y -= speed;
			obj.alpha -= 0.02;
		}
		
		
		private var jump_height:int = 80;
		private var offset_x:int = 90;
		private var jump_dir_x:int = -2;
		private var jump_delta_y:int = 4;
		private function jumpBehavier(obj:DynamicTipObject, speed:int):void
		{
			if(obj.absDeltaX < offset_x)
				obj.x += jump_dir_x;
			
			if(obj.y <= obj.startPoint.y)
				obj.y -= (obj.direction.y*jump_delta_y);
			
			if(obj.absDeltaY > jump_height && obj.direction.y == 1)
				obj.direction.y = -1; // 反方向
			
			obj.alpha -= 0.01;
		}
	}
}
import flash.display.Sprite;
import flash.geom.Point;


internal class DynamicTipObject extends Sprite
{
	private var m_oriPoint:Point = new Point();
	private var m_direction:Point = new Point(1, 1);
	
	public function DynamicTipObject()
	{
		super();
	}
	
	public function get startPoint():Point
	{
		return m_oriPoint;
	}
	
	public function set startPoint(point:Point):void
	{
		m_oriPoint = point;
		
		this.x = point.x;
		this.y = point.y;
	}
	
	public function get direction():Point
	{
		return m_direction;
	}
	
	public function get deltaY():Number
	{
		return this.y - m_oriPoint.y;
	}
	
	public function get deltaX():Number
	{
		return this.x - m_oriPoint.x;
	}
	
	public function get absDeltaX():Number
	{
		var dx:Number = deltaX;
		return (dx > 0)?dx:-dx;
	}
	
	public function get absDeltaY():Number
	{
		var dy:Number = deltaY;
		return (dy > 0)?dy:-dy;
	}
	
	public function release():void
	{
		this.removeChildren();
	}
}