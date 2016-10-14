package com.bitheads.braincloud
{
    import com.bitheads.braincloud.*;
    import com.bitheads.braincloud.comms.*;
    import com.bitheads.braincloud.services.*;
    import com.bitheads.braincloud.types.Platform;
    import flash.system.*;
	
	
	public class BrainCloudClient
	{
		private static const BRAINCLOUD_VERSION:String = "3.1.0";
		private static const DEFAULT_SERVER_URL:String = "https://sharedprod.braincloudservers.com/dispatcherv2";
		
		private static var _instance:BrainCloudClient;
		
		private var _releasePlatform:Platform = Platform.Facebook;
		private var _version:String = "1.0.0";
		private var _gameId:String;
		private var _countryCode:String;
		private var _languageCode:String;
		private var _timeZoneOffset:Number;
		
		private var _comms:BrainCloudComms;
		private var _authenticationService:BrainCloudAuthentication;
		private var _entityService:BrainCloudEntity;
		private var _eventService:BrainCloudEvent;
		private var _gamificationService:BrainCloudGamification;
		private var _globalApp:BrainCloudGlobalApp;        
        private var _identityService:BrainCloudIdentity;
		private var _leaderboardService:BrainCloudLeaderboard;
		private var _playerStateService:BrainCloudPlayerState;
		private var _playerStatisticsService:BrainCloudPlayerStatistics;
		private var _playerStatisticsEventService:BrainCloudPlayerStatisticsEvent;
		private var _productService:BrainCloudProduct;
		private var _scriptService:BrainCloudScript;
		private var _timeService:BrainCloudTime;
		
		public function BrainCloudClient()
		{
			if (_instance != null)
			{
				throw new Error("BrainCloudClient is a singleton. Use BrainCloudClient.getInstance()");
			}
			else
			{
				_comms = new BrainCloudComms(this);
				
				_authenticationService = new BrainCloudAuthentication(this);
				_entityService = new BrainCloudEntity(this);
				_eventService = new BrainCloudEvent(this);
				_gamificationService = new BrainCloudGamification(this);
                _globalApp = new BrainCloudGlobalApp(this);
                _identityService = new BrainCloudIdentity(this);
				_leaderboardService = new BrainCloudLeaderboard(this);
				_playerStateService = new BrainCloudPlayerState(this);
				_playerStatisticsService = new BrainCloudPlayerStatistics(this);
                _playerStatisticsEventService = new BrainCloudPlayerStatisticsEvent(this);
				_productService = new BrainCloudProduct(this);
				_scriptService = new BrainCloudScript(this);
				_timeService = new BrainCloudTime(this);
				
				initLocale();
				
				_instance = this;
			}
		}
		
		public static function get instance():BrainCloudClient
		{
			if (!_instance)
			{
				new BrainCloudClient();
			}
			return _instance;
		}
		
		public function initialize(gameId:String, secret:String, version:String, serverUrl:String = DEFAULT_SERVER_URL):void
		{
			_gameId = gameId;
			_version = version;
			_comms.initialize(gameId, secret, serverUrl);
		}
		
		public function initializeIdentity(profileId:String, anonymousId:String):void
		{
			_authenticationService.initialize(profileId, anonymousId);
		}
		
		public function enableLogging(isEnabled:Boolean):void
		{
			_comms.setDebugOutputFunctions(trace, trace, true);
		}
		
		private function initLocale():void
		{
			_languageCode = Capabilities.language;
			
			var date:Date = new Date();
			var offset:Number = date.getTimezoneOffset();
			_timeZoneOffset = offset / 60;
		}
		
		//{ region  Getters
		
		public function get gameId():String
		{
			return _gameId;
		}
		
		public function get releasePlatform():Platform
		{
			return _releasePlatform;
		}
		
		public function get gameVersion():String
		{
			return _version;
		}
		
		public function get countryCode():String
		{
			return _countryCode;
		}
		
		public function get languageCode():String
		{
			return _languageCode;
		}
		
		public function get timeZoneOffset():Number
		{
			return _timeZoneOffset;
		}
		
		public function get clientLibVersion():String
		{
			return BRAINCLOUD_VERSION;
		}
		
		public function get isAuthenticated():Boolean
		{
			return _comms.isAuthenticated;
		}        
        
        public function getPacketTimeouts():Array
		{
			return _comms.packetTimeouts;
		}
		
		//} endregion 
		
		//{ region  Setters
		
		public function set releasePlatform(platform:Platform):void
		{
			_releasePlatform = platform;
		}
		
		public function set countryCode(countryCode:String):void
		{
			_countryCode = countryCode;
		}
		
		public function set languageCode(languageCode:String):void
		{
			_languageCode = languageCode;
		}
		
		public function set timeZoneOffset(offset:Number):void
		{
			_timeZoneOffset = offset;
		}
		
		public function setGlobalErrorCallback(callback:Function):void
		{
			_comms.setGlobalErrorCallback(callback);
		}
		
		public function setEventCallback(callback:Function):void
		{
			_comms.setEventCallback(callback);
		}
                
        public function setPacketTimeouts(timeouts:Array):void
		{
			_comms.packetTimeouts = timeouts;
		}
		
		//} endregion 
		
		//{ region  Services
		
		public function get authenticationService():BrainCloudAuthentication
		{
			return _authenticationService;
		}
		
		public function get entityService():BrainCloudEntity
		{
			return _entityService;
		}
		
		public function get eventService():BrainCloudEvent
		{
			return _eventService;
		}
		
		public function get gamificationService():BrainCloudGamification
		{
			return _gamificationService;
		}
		
		public function get globalAppService():BrainCloudGlobalApp
		{
			return _globalApp;
		}
        
        public function get identityService():BrainCloudIdentity
		{
			return _identityService;
		}
		
		public function get leaderboardService():BrainCloudLeaderboard
		{
			return _leaderboardService;
		}
		
		public function get playerStateService():BrainCloudPlayerState
		{
			return _playerStateService;
		}
		
		public function get playerStatisticsService():BrainCloudPlayerStatistics
		{
			return _playerStatisticsService;
		}
        
        public function get playerStatisticsEventService():BrainCloudPlayerStatisticsEvent
		{
			return _playerStatisticsEventService;
		}
		
		public function get productService():BrainCloudProduct
		{
			return _productService;
		}
		
		public function get scriptService():BrainCloudScript
		{
			return _scriptService;
		}
		
		public function get timeService():BrainCloudTime
		{
			return _timeService;
		}
		
		//} endregion 
		
		public function sendRequest(serviceMessage:ServerCall):void
		{
			_comms.sendRequest(serviceMessage);
		}
		
		public function runCallbacks():void
		{
			_comms.runCallbacks();
		}
		
		public function resetCommunications():void
		{
			_comms.resetCommunication();
		}
	}
}