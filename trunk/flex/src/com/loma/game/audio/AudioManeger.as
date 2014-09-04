/**
 * 音樂及音效管理
 * 
 * 想要在任何功能添加音效的話，請呼叫：
 * AudioManeger.instance.playSound(track);
 * → track 是音效的曲目，使用例子：
 * AudioManeger.instance.playSound("So0019");	→ 播放 So0019「清理垃圾」音效檔
 * 音效檔編號請參照企劃的文檔定義
 * 
 * 如要更換背景音樂,請如下執行
 * switchMusic();						//先關掉目前音樂
 * setNowPlayingMusic("Mu001");			//設定要換上的音樂檔編號
 * switchMusic();						//開始播放
 * */
 package com.loma.game.audio
{	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.Dictionary;
	
	public class AudioManeger 
	{
		public static const MAX_PLAY_SOUNDS:int = 2;
		
		private static var m_instance:AudioManeger = null;
		//private var m_Music:Object = {};
		private var m_MusicArr:Array = [];
		private var m_SoundArr:Array = [];
		private var m_SoundIdx:Array = [];
		private var m_SoundChannelArr:Array = [];
		private var m_MusicChannelArr:Array = [];
		//private var m_MusicChannel:SoundChannel = new SoundChannel();
		//private var m_SoundChennel:SoundChannel = new SoundChannel();  
		private var m_Music_Req:URLRequest = new URLRequest();
		private var m_Sound_Req:URLRequest = new URLRequest();
		private var m_totalMusicCount:int = 0;
		private var m_totalSoundCount:int = 0;
		private var m_totalMusicCapacity:int = 0;
		private var m_totalSoundCapacity:int = 0;
		private var m_able_to_play_music:Boolean = true;
		private var m_able_to_play_sound:Boolean = true;
		private var m_now_playing:String;
		
		private var m_soundCounter:Dictionary = new Dictionary();
		
		public function AudioManeger()
		{
			super();
		}
		
		public static function get instance():AudioManeger
		{
			if(m_instance == null)
				m_instance = new AudioManeger();
				
			return m_instance;
		}
		
		public function Init():void
		{						
		}
		
		//設定下載音效檔 (目前未使用此方法  所以用 PUBLISH::DEBUG!)
		PUBLISH::DEBUG
		public function setSoundBox():Array
		{
			var allSound:Array = [];
			//var s:Sound;
			
			allSound = SoundSetting.instance.getAllSoundFile();
			
			for(var i:int = 0; i < SoundSetting.instance.getAllSoundFile().length; i++)
			{
				//allSound = 
				m_Sound_Req.url = (UrlAddress.instance.SOUND_URL + getSoundFile(i));
				//m_SoundArr[i] = new SoundChannel;
				//m_SoundArr[i].sound = new Sound;
				//m_SoundArr[i].addEventListener(Event.COMPLETE, loadSound);
				
				var sound:Sound = new Sound();
				sound.addEventListener(Event.COMPLETE, loadSound);
				sound.load(m_Sound_Req);
				
				m_SoundArr[i] = sound;
			}
			
			if(allSound.length > 0)
				return allSound;
			else
				return null;			
		}
		
		//下載音效檔
		private function loadSound(event:Event):void
		{
			var tempSound:Sound = event.target as Sound;
			var soundVolume:SoundTransform = new SoundTransform(0);
			
			var idx:int = m_SoundArr.indexOf(tempSound);
			
			m_SoundChannelArr[idx] = tempSound.play(0, 1000, soundVolume);
			m_SoundChannelArr[idx].stop();	
			
			m_totalSoundCount++;
			m_totalSoundCapacity += tempSound.bytesTotal;
			if(m_totalSoundCount == m_SoundArr.length)
			{
				trace("下載完成 " + m_totalSoundCount + " 首音效檔");
				trace("總容量 = " + (m_totalSoundCapacity/1024) + "KB");
			}			
		}		
		
		//按音效編號尋找需要播放的檔案
		public function searchSound(track:String):int
		{
			//var i:int = 0, len:int = m_SoundChannelArr.length;
			var i:int = 0, len:int = m_SoundIdx.length;
			for(i = 0; i < len; i++)
			{
				if(track == m_SoundIdx[i])
				{
					return i;
				}
			} 
			return -1;
		}
		
		//播放音效
		public function playSound(track:String, vol:Number = 0.1):void
		{
			if(!m_able_to_play_sound)
				return;
				
			var i:int = searchSound(track);
			if(i < 0)
				return;
			
			if(!m_soundCounter.hasOwnProperty(track))
			{
				var data:Object = {};
				data.counts = 0;
				data.channels =[];
				m_soundCounter[track] = data;
			}
					
			var soundData:Object = m_soundCounter[track]; 
			if(soundData.counts >= MAX_PLAY_SOUNDS)
			{
				soundData.counts -= 1;
				var channel:SoundChannel =  (soundData.channels as Array).shift() as SoundChannel;
				if(channel)
				{
					channel.stop();
					channel = null;
				}  
				//return;
			}
			
			//if(m_SoundChannelArr[(i)] == null)
			//	return; 
			var soundVolume:SoundTransform = new SoundTransform(vol);
			var sound:Sound = m_SoundArr[i];
			m_SoundChannelArr[i] = null;
			var soundChannel:SoundChannel = sound.play(0, 1, soundVolume);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true); 
			m_SoundChannelArr[i] = soundChannel;
			
			m_soundCounter[track].counts += 1;
			m_soundCounter[track].channels.push(soundChannel);
		}
		
		//停止播放音效
		public function stopSound(track:String):void
		{
			if(!m_able_to_play_sound)
				return;
				
			var i:int = searchSound(track);
			if(m_SoundChannelArr[(i)] == null)
				return; 
			m_SoundChannelArr[(i)].stop();
			
			var soundData:Object = m_soundCounter[track]; 
			soundData.counts -= 1;
			var channel:SoundChannel =  (soundData.channels as Array).shift() as SoundChannel;
			if(channel)
			{
				channel.stop();
				channel = null;
			} 
			
		}

		//設定下載音樂檔
		public function setMusicBox():Array
		{
			var allMusic:Array = [];
			//var s:Sound;
			
			allMusic = MusicSetting.instance.getAllMusicFile();
			var i:int = 0, len:int = allMusic.length;
			for(i = 0; i < len; i++)
			{				 
				m_Music_Req.url = (UrlAddress.instance.MUSIC_URL + getMusicFile(i));
							
				m_MusicArr[i] = new Sound();
				m_MusicArr[i].addEventListener(Event.COMPLETE, loadMusic);
				m_MusicArr[i].load(m_Music_Req);
			}
			
			if(allMusic.length > 0)
				return allMusic;
			else
				return null;			
		}
		
		//按音樂編號尋找需要播放的檔案
		public function searchMusic(track:String):int
		{
			for(var i:int = 0; i < m_MusicChannelArr.length; i++)
			{
				if(track == getMusicFileLabel(i))
				{
					return i;
				}				
			}
			return -1;
		}
		
		//設定背景音樂曲目
		public function setNowPlayingMusic(track:String):void
		{
			m_now_playing = track;
		}
		
		//播放音樂
		public function playMusic(track:String):void
		{
			/*if(m_able_to_play_music == false)
				return;
				
			m_Music_Req.url = (UrlAddress.MUSIC_URL + getMusicFile(track));
			
			if(m_Music.sound != null)
				delete m_Music.sound; 
				
			m_Music.sound = new Sound();
			
			m_Music.sound.addEventListener(Event.COMPLETE, loadMusic);
			*/
			var i:int = searchMusic(track);
						
			if(i != -1 && m_MusicChannelArr[(i)] == null)
				return; 
			if(!m_able_to_play_music)
			{
				m_MusicChannelArr[(i)].stop();
				return;
			}
			var soundVolume:SoundTransform = new SoundTransform(0.5);
			m_MusicChannelArr[(i)] = m_MusicArr[i].play(0,1000,soundVolume);						
		}
		
		//下載音樂檔
		public function loadMusic(event:Event):void
		{
			var tempMusic:Sound = event.target as Sound;
			var soundVolume:SoundTransform = new SoundTransform(0);
			var idx:int = m_MusicArr.indexOf(tempMusic);
			
			m_MusicChannelArr[idx] = tempMusic.play(0, 1000, soundVolume);
			m_MusicChannelArr[idx].stop();
			m_totalMusicCount++;
			m_totalMusicCapacity += tempMusic.bytesTotal;
			
			if(m_totalMusicCount == m_MusicArr.length)
			{
				trace("下載完成 " + m_totalMusicCount + " 首音樂檔");
				trace("總容量 = " + (m_totalMusicCapacity/1024) + "KB");
				playMusic(m_now_playing);
			}		
		}
				
		//開啟或關閉音樂
		public function switchMusic():void
		{							
			//(m_able_to_play_music==true)? false:true;
			m_able_to_play_music = !m_able_to_play_music; 
			playMusic(m_now_playing);
		}
		
		//開啟或關閉音效
		public function switchSound():void
		{
			//(m_able_to_play_sound==true)? false:true;
			m_able_to_play_sound = !m_able_to_play_sound;
		}
		
		public function get musicEnabled():Boolean
		{
			return m_able_to_play_music;
		}
		
		public function get soundEnabled():Boolean
		{
			return m_able_to_play_sound;
		}
		
		public function set musicEnabled(turn:Boolean):void
		{
			m_able_to_play_music = turn;
		}
		
		public function set soundEnabled(turn:Boolean):void
		{
			m_able_to_play_sound = turn;
		}
		
		
		
		//======================================================
		//	Load Sound.swf
		//======================================================
		public function loadSoundAsset(asset:String):void
		{
			var loader:Loader = new Loader();
			var url:URLRequest = new URLRequest(UrlAddress.instance.SOUND_URL + asset + ".swf");
			loader.load(url,new LoaderContext(false, null, SecurityDomain.currentDomain));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadSoundComplete);
			loader = null;
		}
		
		private function onLoadSoundComplete(e:Event):void
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadSoundComplete);
			
			var soundArray:Array = SoundSetting.instance.getAllSoundFile();
			var i:int = 0, len:int = soundArray.length;
			var fileName:String;
			var classType:Class;
			for(i; i < len; i++)
			{
				fileName = getSoundFile(i).split(".")[0];
				if(loaderInfo.applicationDomain.hasDefinition(fileName))
				{
					classType = loaderInfo.applicationDomain.getDefinition(fileName) as Class;
					var sound:Sound = new classType() as Sound;; 
					m_SoundArr[i] = sound;
					m_SoundIdx[i] = fileName;
					//m_SoundChannelArr[i] = m_SoundArr[i].play(0, 1000);
					//m_SoundChannelArr[i].stop();	
					//delete loaderInfo.content.classType;
				}
			}
			loaderInfo.loader.unloadAndStop();			
		}		
		
		private function onSoundComplete(e:Event):void
		{
			for each(var data:Object in m_soundCounter)
			{
				var channelArray:Array = data.channels;
				for(var i:int = 0; i < channelArray.length; i++)
				{
					var channel:SoundChannel = channelArray[i];
					if(e.target.valueOf() == channel)
					{
						data.counts--;						
						channelArray.splice(i, 1);
					}
				}
			}
			trace(e.target.valueOf());
			trace(e.target + ". onSoundComplete");
		}
	}
}