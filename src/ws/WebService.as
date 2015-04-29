package ws
{
	
	import by.blooddy.crypto.serialization.JSON;
	
	import com.Share;
	import com.events.WebserviceEvent;
	
	import flash.events.ErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.net.URLRequestDefaults;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import utils.FileUtils;
	import utils.FormatUtils;
	
	
	[Event(name="error", type="com.events.WebserviceEvent")]
	
	
	[Event(name="getSettings", type="com.events.WebserviceEvent")]
	[Event(name="setSetting", type="com.events.WebserviceEvent")]
	
	[Event(name="getHost", type="com.events.WebserviceEvent")]
	
	[Event(name="getShares", type="com.events.WebserviceEvent")]
	[Event(name="setShare", type="com.events.WebserviceEvent")]
	[Event(name="removeHostShare", type="com.events.WebserviceEvent")]
	[Event(name="getShareLog", type="com.events.WebserviceEvent")]
	
	[Event(name="getFileIndex", type="com.events.WebserviceEvent")]
	[Event(name="setFileIndex", type="com.events.WebserviceEvent")]
	
	[Event(name="downloadFile", type="com.events.WebserviceEvent")]
	[Event(name="uploadFile", type="com.events.WebserviceEvent")]
	[Event(name="setFile", type="com.events.WebserviceEvent")]
	
	public class WebService extends HTTPService
	{
		public function WebService(rootURL:String=null, destination:String=null)
		{
			super(rootURL, destination);
			resultFormat = "text";
			contentType = "application/json";
			
			addEventListener(ResultEvent.RESULT, result);
			addEventListener(FaultEvent.FAULT, fault);
			
			showBusyCursor = true;
		}
		
		private var getSettingsToken:AsyncToken;
		private var setSettingToken:AsyncToken;
		
		private var getHostToken:AsyncToken;
		
		private var getSharesToken:AsyncToken;
		private var setShareToken:AsyncToken;
		private var removeHostShareToken:AsyncToken;
		private var getShareLogToken:AsyncToken;
		
		private var getFileIndexToken:AsyncToken;
		private var setFileIndexToken:AsyncToken;
		
		private var downloadFileToken:AsyncToken;
		private var uploadFileToken:AsyncToken;
		private var setFileToken:AsyncToken;
		
		private function result(event:ResultEvent):void {
			var e:WebserviceEvent;
			
			var d:Object = {};
			try {
				d = by.blooddy.crypto.serialization.JSON.decode(event.result.toString());
				//d.raw = event.result.toString();
			}
			catch(e:SyntaxError){
				d.type = WebserviceEvent.TYPE_JSONERROR;
				d.message = e.message;
				d.data = event.result.toString();
				//d.raw = event.result.toString();
			}
			d.type		= d.hasOwnProperty('type') ? d.type : WebserviceEvent.TYPE_DATA;
			d.message	= d.hasOwnProperty('message') ? d.message : '';
			d.logging	= d.hasOwnProperty('logging') ? d.logging : '';
			d.data		= d.hasOwnProperty('data') ? d.data : null;
			
			switch(event.token){
				case getSettingsToken:
					e = new WebserviceEvent('getSettings', false, false, d.type, d.message, d.logging, d.data);
					break;
				case setSettingToken:
					e = new WebserviceEvent('setSetting', false, false, d.type, d.message, d.logging, d.data);
					break;
				
				case getHostToken:
					e = new WebserviceEvent('getHost', false, false, d.type, d.message, d.logging, d.data);
					break;
				
				case getSharesToken:
					e = new WebserviceEvent('getShares', false, false, d.type, d.message, d.logging, d.data);
					break;
				case setShareToken:
					e = new WebserviceEvent('setShare', false, false, d.type, d.message, d.logging, d.data);
					break;
				case removeHostShareToken:
					e = new WebserviceEvent('removeHostShare', false, false, d.type, d.message, d.logging, d.data);
					break;
				case getShareLogToken:
					e = new WebserviceEvent('getShareLog', false, false, d.type, d.message, d.logging, d.data);
					break;
				
				case getFileIndexToken:
					e = new WebserviceEvent('getFileIndex', false, false, d.type, d.message, d.logging, d.data);
					break;
				case setFileIndexToken:
					e = new WebserviceEvent('setFileIndex', false, false, d.type, d.message, d.logging, d.data);
					break;
				
				case downloadFileToken:
					e = new WebserviceEvent('downloadFile', false, false, d.type, d.message, d.logging, d.data);
					break;
				case uploadFileToken:
					e = new WebserviceEvent('uploadFile', false, false, d.type, d.message, d.logging, d.data);
					break;
				case setFileToken:
					e = new WebserviceEvent('setFile', false, false, d.type, d.message, d.logging, d.data);
					break;
				
			}
			
			if(e != null){
				dispatchEvent(e);
			}
		}
		
		private function fault(event:FaultEvent):void {
			var e:WebserviceEvent;
			
			e = new WebserviceEvent(WebserviceEvent.TYPE_ERROR, false, false, 'error', '', event.fault.faultDetail);
			
			switch(event.token){
				case getHostToken:
					
					break;
				
			}
			//var e:ResultEvent = new ResultEvent('getHost', false, false, JSON.decode(event.result.toString()));
			
			dispatchEvent(e);
			
		}
		
		
		private var _location:String;
		private var _locationFixed:String;
		
		[Bindable]
		public function set location(value:String):void {
			_location = value;
			_locationFixed = value + (value.indexOf('?') > 5 ? '&' : '?') + 'method=';
		}
		public function get location():String {
			return _location;
		}
		
		
		public function sendCall(method:String, params:Object, httpMethod:String = 'get'):AsyncToken {
			this.method = httpMethod;
			url = _locationFixed + method;
			if(httpMethod.toLowerCase() == 'post'){
				contentType = 'application/x-www-form-urlencoded';
			}
			else {
				contentType = "application/json";
			}
			URLRequestDefaults.idleTimeout = 60 * 15 * 1000; // in milliseconds
			return send(params);
		}
		
		/* === */
		/*
		
		public function (id_host:int, id_share:int):void {
			var params:Object = {
				id_host: id_host
				id_share: id_share
			};
			Token = sendCall('', params);
		}
		
		*/
		
		public function getSettings(id_host:int):void {
			var params:Object = {
				id_host: id_host
			};
			getSettingsToken = sendCall('getSettings', params);
		}
		
		public function setSetting(id_host:int, code:String, value:String):void {
			var params:Object = {
				id_host: id_host,
				code: code,
				value: value
			};
			setSettingToken = sendCall('setSetting', params);
		}
		
		
		public function getHost(hostName:String, os:String):void {
			var params:Object = {
				hostName: hostName,
				os: os
			};
			getHostToken = sendCall('getHost', params);
		}
		
		
		public function getShares(id_host:int):void {
			var params:Object = {
				id_host: id_host
			};
			getSharesToken = sendCall('getShares', params);
		}
		
		public function setShare(id_host:int, share:Share):void {
			var params:Object = {
				id_host: id_host,
				id_share: share.id_share,
				local_directory: share.local_directory,
				sharename: share.name,
				
				check_period: share.check_period,
				check_on_start: share.check_on_start ? 1 : 0,
				exclude_extensions: share.exclude_extensions,
				exclude_directory: share.exclude_directory,
				exclude_filename: share.exclude_filename,
				//compare_date_modified: share.compare_date_modified ? 1 : 0,
				//compare_checksum: share.compare_checksum ? 1 : 0,
				//cached_index: share.cached_index ? 1 : 0,
				max_download_speed: share.max_download_speed
				
			};
			setShareToken = sendCall('setShare', params);
		}
		
		public function removeHostShare(id_host:int, share:Share):void {
			var params:Object = {
				id_host: id_host,
				id_share: share.id_share
			};
			removeHostShareToken = sendCall('removeHostShare', params);
		}
		
		
		public function getShareLog(days:int):void {
			var params:Object = {
				days: days
			};
			getShareLogToken = sendCall('getShareLog', params);
		}
		
		
		/*
		public function downloadFile(id_file:int):void {
			var params:Object = {
				id_file: id_file
			};
			downloadFileToken = sendCall('downloadFile', params);
		}
		*/
		
		public function downloadFile(id_host:int, id_file:int):String {
			return _locationFixed + 'downloadFile&id_host=' + id_host + '&id_file=' + id_file;
		}
		
		public function uploadFile(id_host:int, share:Share, localFile:File, remoteFile:Object):String {
			var u:String = _locationFixed + 'uploadFile&id_host=' + id_host + '&id_share=' + share.id_share;
			
			var l:String = localFile.nativePath;
			l = l.replace(share.local_directory, '');
			l = l.split(File.separator).join('/');
			l = share.server_directory + l;
			u += "&path=" + l;
			
			u += "&modified=" + Math.floor(localFile.modificationDate.time / 1000);
			return u;
		}
		
		
		public function getFileIndex(id_host:int, id_share:int, date_last_replicated:Date, cached_index:Boolean):void {
			var params:Object = {
				id_host: id_host,
				id_share: id_share,
				date_last_replicated: date_last_replicated,
				cached_index: cached_index ? 1 : 0
			};
			getFileIndexToken = sendCall('getFileIndex', params);
		}
		
		public function setFileIndex(id_host:int, share:Share, files:ArrayCollection):ArrayCollection {
			var conflictedFiles:ArrayCollection = new ArrayCollection;
			var excludedFiles:ArrayCollection = new ArrayCollection;
			var fa:Array = [];
			var exclext:Array = share.exclude_extensions != null && share.exclude_extensions.replace(/ |,/g, '') != '' ? share.exclude_extensions.replace(/ /g, '').split(',') : [];
			var excldir:Array = share.exclude_directory != null && share.exclude_directory.replace(/ |\n|\r/g, '') != '' ? share.exclude_directory.replace(/\r\n/g, '\n').replace(/\r/g, '\n').split('\n') : [];
			var exclname:Array = share.exclude_filename != null && share.exclude_filename.replace(/ |\n|\r/g, '') != '' ? share.exclude_filename.replace(/\r\n/g, '\n').replace(/\r/g, '\n').split('\n') : [];
			
			for(var i:int=0; i<files.length; i++){
				var f:File = (files[i] as File);
				var exclude:int = 0, e:int;
				
				for(e=0; e<exclext.length; e++){
					if(exclext[e] != '' && f.extension != null && f.extension.toLowerCase() == exclext[e].toLowerCase()){
						exclude += 1;
						break;
					}
				}
				
				for(e=0; e<excldir.length; e++){
					if(excldir[e] != '' && f.nativePath.replace(f.name, '').indexOf(excldir[e]) > -1){
						exclude += 2;
						break;
					}
				}
				
				for(e=0; e<exclname.length; e++){
					if(exclname[e] != '' && f.name.indexOf(exclname[e]) > -1){
						exclude += 4;
						break;
					}
				}
				
				// exclude by exception (extension, filename, path)
				if(exclude > 0){
					excludedFiles.addItem(f);
				}
				// exclude deleted files
				//else
				if(f.extension != null && ('.' + f.extension.toLowerCase()).indexOf('.deleted') > -1){
					
				}
				// exclude temp. upload files
				else if(f.extension != null && ('.' + f.extension.toLowerCase()).indexOf('.filerep') > -1){
					
				}
				// exclude conflict files
				else if(f.extension != null && ('.' + f.extension.toLowerCase()).indexOf('.conflict') > -1){
					//conflictedFiles.addItem(f);
				}
				else {
					var path:String = f.nativePath;
					var name:String = f.name;
					var size:int = f.size;
					var dm:Date = f.modificationDate;
					var c:int = 0;
					
					path = path.replace(share.local_directory, '').replace(/\\/g, '/');
					var pt:Array = path.split('/');
					pt.pop();
					path = pt.join('/');
					
					// conflicted file - remove conflicted part and upload as well
					/*if(('.' + f.extension.toLowerCase()).indexOf('.conflict') > -1){
						var pathParts:Array = path.split('.');
						pathParts.pop();
						path = pathParts.join('.');
					}*/
					
					// if a conflicted version exists, upload that info instead
					var cf:File = new File(f.nativePath + '.conflict');
					if(cf.exists){
						conflictedFiles.addItem(f);
						// path = <the same>
						size = cf.size;
						dm = cf.modificationDate;
						c = 1;
					}
					
					fa.push({
						/*filename: (files[i] as File).name,
						relative_directory: f.nativePath.replace(share.local_directory, '').replace(/\\/g, '/'),
						size: f.size,
						date_last_modified: FormatUtils.formatDate(f.modificationDate, FormatUtils.DATABASE_DATE),
						checksum: '',
						notfound: 0*/
						n: name,	// filename
						p: path,	// path, relative_directory
						//s: size,
						m: FormatUtils.formatDate(dm, FormatUtils.DATABASE_DATE),	// date_last_modified
						c: c, // conflict
						//c: '',	// checksum
						//n: 0	// notfound
						e: exclude // excluded
					});
				}
			}
			var params:Object = {
				id_host: id_host,
				id_share: share.id_share,
				date_last_replicated: FormatUtils.formatDate(share.date_last_replicated, FormatUtils.DATABASE_DATE),
				files: by.blooddy.crypto.serialization.JSON.encode(fa)
			};
			setFileIndexToken = sendCall('setFileIndex', params, 'post');
			
			return conflictedFiles;
		}
		
		
		public function setFile(id_host:int, id_share:int):void {
			var params:Object = {
				id_host: id_host,
				id_share: id_share
			};
			setFileToken = sendCall('setFile', params);
		}
		
	}
}