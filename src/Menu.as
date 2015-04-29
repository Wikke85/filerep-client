
		

		
	
	public var mnuTray:NativeMenuXT;
	public var mnuMain:NativeMenuXT;
	
	public var allMenuItems:String = 
			'NewUser,NewProject,NewDeliverable,' + 
			'DashboardCommand,ManageProjectCommand,ManagePhasesCommand,' + 
			'ManageUsersCommand,ProfileCommand,SettingsCommand,' + 
			'ShowAuditCommand,MyDeliverablesCommand,MyMailsCommand,' + 
			'Separator,' + 
			'AboutCommand'
	;
	
	public function onMenuSelect(event:Event = null, _action:String = '', extraData:Object = null):void {
		var action:String;
		if(event != null)	action = event.target.data != null ? event.target.data.action : null;
		else				action = _action;
		
		if(action == null)							setStatus('Menu action is not declared! ("'+event.target.label+'")');
		else if(action.split(' ').join('') == '')	setStatus('Menu action is empty! ("'+event.target.label+'")');
		else 
		{
			action = action.toLowerCase();
			switch(action){
				case 'exit':	closeApp();	break;
				case 'dock':	dock();		break;
				case 'undock':	undock();	break;
				//case 'newuser':	editUser();	break;
				case 'maximize':maximize();	break;
				case 'minimize':minimize();	break;
				
				case 'overview':
					//vsMain.selectedChild = vwKasOverzicht;
					//vwKasOverzicht.load();
					break;
				
				case 'do_order':
					//vsMain.selectedChild = vwEnterOrder;
					//vwEnterOrder.load();
					break;
				
				case 'do_editorder':
					//vsMain.selectedChild = vwEditOrder;
					//vwEditOrder.load();
					break;
				
				/*case 'do_deposit':
					vsMain.selectedChild = vwDeposit;
					vwDeposit.load();
					break;*/
				
				/*case 'showdashboard':	showDashboard();	break;
				case 'myprofile':		editUser(user);		break;
				case 'logout':			logout();undock();	break;
				case 'change_password':	changePassword(false);	break;
				
				case 'changemenu':		showChangeMenuDialog();					break;
				case 'manageusers':		vsMain.selectedChild = vwUserOverview;	break;
				case 'showwsfaults':	vsMain.selectedChild = vwFaults;		break;
				case 'showauditing':	vsMain.selectedChild = vwAudit;			break;
				case 'mydeliverables':	showDeliverables(user);					break;
				case 'mailssendtome':	showMaislSend(user.id_resource);		break;
				case 'management':		vsMain.selectedChild = vwManage;		break;
				case 'mytasks':			showTasks(user);						break;
				
				case 'projectsactivephases':	vsMain.selectedChild = vwProjectsActivePhases;	break;
				case 'managedeliverables':		vsMain.selectedChild = vwManageDeliverables;	break;
				case 'manageuseraccess':		vsMain.selectedChild = vwUserAccess;			break;
				case 'showdebugscreen':			vsMain.selectedChild = vwDebug;					break;
				
				case 'newproject':
				case 'manageproject':
				case 'manageproject_docs':
					if(dlgProject == null){
						dlgProject = new Project;
						dlgProject.open(true);
						dlgProject.nativeWindow.x = (width  - dlgProject.width )/2;
						dlgProject.nativeWindow.y = (height - dlgProject.height)/2;
						dlgProject.addEventListener('saveClick', onProjectSaveClick, false, 0, true);
						dlgProject.addEventListener(FlexEvent.HIDE, onProjectCloseClick, false, 0, true);
					}
					
					var tmpProj:TProject = new TProject;
					
					if(action == 'manageproject' || action == 'manageproject_docs'){
						if(extraData == null){
							tmpProj = vwProjectDetail.project;
						}
						else if(extraData is TProject) {
							tmpProj = extraData as TProject;
						}
						else {
							tmpProj.assign(extraData);
						}
					}
					else {
						tmpProj = new TProject;
						tmpProj.date_inserted = new Date;
						tmpProj.projectleader1_email = user.email;
						tmpProj.projectleader1_firstname = user.firstname;
						tmpProj.projectleader1_lastname = user.lastname;
						tmpProj.id_projectleader = user.id_resource;
						tmpProj.id_projectclassification = extraData != null ? int(extraData) : -1;
					}
					
					dlgProject.project = tmpProj;
					
					if(action == 'manageproject_docs'){
						dlgProject.load(true);//documentMode
					}
					else {
						dlgProject.load();
					}
					break;
				
				case 'newdeliverable':
				case 'managedeliverable':
					if(dlgDeliverable == null){
						dlgDeliverable = new Deliverable;
						dlgDeliverable.open(true);
						dlgDeliverable.nativeWindow.x = (width  - dlgDeliverable.width )/2;
						dlgDeliverable.nativeWindow.y = (height - dlgDeliverable.height)/2;
						dlgDeliverable.addEventListener('saveClick', onDeliverableSaveClick, false, 0, true);
					}
					
					dlgDeliverable.deliverable = new TDeliverable;
					if(action == 'managedeliverable'){
						dlgDeliverable.deliverable.assign(extraData);
					}
					else {
						dlgDeliverable.deliverable.id_projecttype = Number(extraData);
					}
					dlgDeliverable.load();
					break;
				
				case 'projectphasecomments':
					if(dlgProjectPhaseComments == null){
						dlgProjectPhaseComments = new ProjectPhaseComments;
						dlgProjectPhaseComments.open(true);
						dlgProjectPhaseComments.nativeWindow.x = (width  - dlgProjectPhaseComments.width )/2;
						dlgProjectPhaseComments.nativeWindow.y = (height - dlgProjectPhaseComments.height)/2;
					}
					dlgProjectPhaseComments.id_project_phase = int(extraData);
					dlgProjectPhaseComments.load();
					break;
				
				case 'projectphasetasks':
					if(dlgProjectPhaseTasks == null){
						dlgProjectPhaseTasks = new ProjectPhaseTasks;
						dlgProjectPhaseTasks.open(true);
						dlgProjectPhaseTasks.nativeWindow.x = (width  - dlgProjectPhaseTasks.width )/2;
						dlgProjectPhaseTasks.nativeWindow.y = (height - dlgProjectPhaseTasks.height)/2;
					}
					dlgProjectPhaseTasks.id_project_phase = int(extraData.id_project_phase);
					dlgProjectPhaseTasks.id_project = int(extraData.id_project);
					dlgProjectPhaseTasks.load();
					break;
				*/
				
				case 'mysettings':
				case 'changesettings':
					if(dlgSettings == null){
						dlgSettings = new Settings;
						dlgSettings.open(true);
						dlgSettings.nativeWindow.x = (width  - dlgSettings.width )/2;
						dlgSettings.nativeWindow.y = (height - dlgSettings.height)/2;
						dlgSettings.addEventListener('saveClick', onSettingsSaveClick, false, 0, true);
					}
					
					if(action == 'changesettings') dlgSettings.load( /*int(extraData)*/ );
					else dlgSettings.load();
					
					break;
				/*
				case 'managesecurity':
					if(dlgSecurity == null){
						dlgSecurity = new Securities;
						dlgSecurity.open(true);
						dlgSecurity.nativeWindow.x = (width  - dlgSecurity.width )/2;
						dlgSecurity.nativeWindow.y = (height - dlgSecurity.height)/2;
					}
					
					dlgSecurity.id_resource = int(extraData);
					dlgSecurity.load();
					break;
				
				case 'manage_phases':
					if(dlgPhases == null){
						dlgPhases = new Phases;
						dlgPhases.open(true);
							
						dlgPhases.nativeWindow.x = (width  - dlgPhases.width )/2;
						dlgPhases.nativeWindow.y = (height - dlgPhases.height)/2;
					}
					
					dlgPhases.stage.nativeWindow.orderToFront();
					callLater(dlgPhases.load);
					break;
				
				case 'manageusertypes':
					if(dlgRoles == null){
						dlgRoles = new Roles;
						dlgRoles.open(true);
							
						dlgRoles.nativeWindow.x = (width  - dlgRoles.width )/2;
						dlgRoles.nativeWindow.y = (height - dlgRoles.height)/2;
					}
					
					dlgRoles.stage.nativeWindow.orderToFront();
					callLater(dlgRoles.load);
					break;
				*/
				case 'about':
					if(dlgAbout == null){
						dlgAbout = new About;
						dlgAbout.open(true);
						dlgAbout.nativeWindow.x = (width  - dlgAbout.width )/2;
						dlgAbout.nativeWindow.y = (height - dlgAbout.height)/2;
					}
					dlgAbout.load();
					break;
				/*
				case 'newclassification':
					Factory.MsgInput(Factory.Text.key('prompt_new_name_for_classification'), 'New classification', addNewClassification);
					break;
				*/
				case 'setsize1024x768':
				case 'setsize800x600':
				case 'setsize1280x1024':
					restore();
					this.width	= int(action.split('setsize').join('').split('x')[0]);
					this.height	= int(action.split('setsize').join('').split('x')[1]);
					break;
				
				case 'reloadmenu':	buildMenu()			break;
				case 'reloadicons':	buildMenuItems();	break;
				
				default:
					setStatus('Menu action is not implemented: ' + action + ' ("'+event.target.label+'")');
			}
		}
	}
	
	public function buildMenu():void {
		//Setting a window menu:
		mnuMain = new TMenu( readXmlFile('data/main_menu.xml') );
		/*if(user.debugger || runningLocal){
			mnuMain.addChildren( readXmlFile('data/main_menu_debug.xml') );
		}*/
		
		nativeWindow.menu = mnuMain;
		//nativeWindow.menu.addEventListener(Event.DISPLAYING, onMenuDisplaying, false, 0, true);//Event.DISPLAYING is not dispatched
		nativeWindow.menu.addEventListener(Event.SELECT, onMenuSelect, false, 0, true);
		
		buildMenuItems();
		
		
		//Setting a context menu
		//interactiveObject.contextMenu = root;
		
		
		//Setting a dock icon menu
		//DockIcon(NativeApplication.nativeApplication.icon).menu = root;
		
		//Setting a system tray icon menu
		//SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = root;
	}			
					
	
	public function updateMenuItems():void {
		trace('updateMenuItems');
		
		if(mnuMain != null && mnuMain.getMenuItemByName('LogoutCommand') != null) mnuMain.getMenuItemByName('LogoutCommand').enabled = user.id_host > 0;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('EnterDepositCommand') != null) mnuMain.getMenuItemByName('EnterDepositCommand').enabled = true;//user.allow_editdeposits;
		if(mnuMain != null && mnuMain.getMenuItemByName('EditOrderCommand') != null) mnuMain.getMenuItemByName('EditOrderCommand').enabled = true;//user.allow_editorders;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('KassaOverviewCommand') != null) mnuMain.getMenuItemByName('KassaOverviewCommand').enabled = true;//user.allow_overview;
		if(mnuMain != null && mnuMain.getMenuItemByName('EnterOrderCommand') != null) mnuMain.getMenuItemByName('EnterOrderCommand').enabled = true;//user.allow_order;
		
		
		/*
		if(mnuMain != null && mnuMain.getMenuItemByName('NewUser') != null) mnuMain.getMenuItemByName('NewUser').enabled = Factory.Security.make_user;
		if(mnuTray != null && mnuTray.getMenuItemByName('NewUser') != null) mnuTray.getMenuItemByName('NewUser').enabled = Factory.Security.make_user;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('NewProject') != null) mnuMain.getMenuItemByName('NewProject').enabled = Factory.Security.make_project;
		if(mnuTray != null && mnuTray.getMenuItemByName('NewProject') != null) mnuTray.getMenuItemByName('NewProject').enabled = Factory.Security.make_project;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('NewDeliverable') != null) mnuMain.getMenuItemByName('NewDeliverable').enabled = Factory.Security.make_deliverable;
		if(mnuTray != null && mnuTray.getMenuItemByName('NewDeliverable') != null) mnuTray.getMenuItemByName('NewDeliverable').enabled = Factory.Security.make_deliverable;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('NewClassification') != null) mnuMain.getMenuItemByName('NewClassification').enabled = Factory.Security.make_classification;
		if(mnuTray != null && mnuTray.getMenuItemByName('NewClassification') != null) mnuTray.getMenuItemByName('NewClassification').enabled = Factory.Security.make_classification;
		
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManagePhasesCommand') != null) mnuMain.getMenuItemByName('ManagePhasesCommand').enabled = Factory.Security.manage_phases;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ManagePhasesCommand') != null) mnuTray.getMenuItemByName('ManagePhasesCommand').enabled = Factory.Security.manage_phases;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManageProjectCommand') != null) mnuMain.getMenuItemByName('ManageProjectCommand').enabled = Factory.Security.edit_projects && vsMain.selectedChild == vwProjectDetail;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ManageProjectCommand') != null) mnuTray.getMenuItemByName('ManageProjectCommand').enabled = Factory.Security.edit_projects;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManageDeliverablesCommand') != null) mnuMain.getMenuItemByName('ManageDeliverablesCommand').enabled = Factory.Security.manage_deliverables;
		if(mnuTray != null && mnuTray.getMenuItemByName('ManageDeliverablesCommand') != null) mnuTray.getMenuItemByName('ManageDeliverablesCommand').enabled = Factory.Security.manage_deliverables;
		
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManageUsersCommand') != null) mnuMain.getMenuItemByName('ManageUsersCommand').enabled = Factory.Security.manage_users;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ManageUsersCommand') != null) mnuTray.getMenuItemByName('ManageUsersCommand').enabled = Factory.Security.manage_users;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManageUserAccessCommand') != null) mnuMain.getMenuItemByName('ManageUserAccessCommand').enabled = Factory.Security.manage_user_access;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ManageUserAccessCommand') != null) mnuTray.getMenuItemByName('ManageUserAccessCommand').enabled = Factory.Security.manage_user_access;
		
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ProfileCommand') != null) mnuMain.getMenuItemByName('ProfileCommand').enabled = Factory.Security.change_profile;
		if(mnuTray != null && mnuTray.getMenuItemByName('ProfileCommand') != null) mnuTray.getMenuItemByName('ProfileCommand').enabled = Factory.Security.change_profile;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('SettingsCommand') != null) mnuMain.getMenuItemByName('SettingsCommand').enabled = Factory.Security.change_settings;
		if(mnuTray != null && mnuTray.getMenuItemByName('SettingsCommand') != null) mnuTray.getMenuItemByName('SettingsCommand').enabled = Factory.Security.change_settings;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ChangeMenuCommand') != null) mnuMain.getMenuItemByName('ChangeMenuCommand').enabled = Factory.Security.change_menu;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ChangeMenuCommand') != null) mnuTray.getMenuItemByName('ChangeMenuCommand').enabled = Factory.Security.change_menu;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ShowAuditCommand') != null) mnuMain.getMenuItemByName('ShowAuditCommand').enabled = Factory.Security.view_auditing;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ShowAuditCommand') != null) mnuTray.getMenuItemByName('ShowAuditCommand').enabled = Factory.Security.view_auditing;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManageDataCommand') != null) mnuMain.getMenuItemByName('ManageDataCommand').enabled = Factory.Security.manage_data;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ProjectsActiveCommand') != null) mnuMain.getMenuItemByName('ProjectsActiveCommand').enabled = Factory.Security.view_projects_active_phases;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ChangePWCommand') != null) mnuMain.getMenuItemByName('ChangePWCommand').enabled = loggedIn;
		//if(mnuTray != null && mnuTray.getMenuItemByName('ChangePWCommand') != null) mnuTray.getMenuItemByName('ChangePWCommand').enabled = loggedIn;
		
		if(mnuMain != null && mnuMain.getMenuItemByName('ManageUserTypesCommand') != null) mnuMain.getMenuItemByName('ManageUserTypesCommand').enabled = Factory.Security.change_roles;
		*/
	}
	
	private function buildMenuItems():void {
		trace('buildMenuItems');
		
		/*boxIcons.removeAllChildren();
		var customMenuIcon:MenuButton;
		for(var i:int=0; i<user.menu_items.length; i++){
			
			// if menu item from user exists, e.g. if it is in 'allMenuItems'
			if( String( ',' + allMenuItems + ',' ).indexOf( ',' + user.menu_items[i] + ',' ) != -1 ){
			
				customMenuIcon = new MenuButton;
				if(user.menu_items[i] != 'Separator')
					customMenuIcon.menuName = user.menu_items[i];
				else
					customMenuIcon.isSeparator = true;
				boxIcons.addChild( customMenuIcon );
			}
		}*/
		updateMenuItems();
	}
	
	
	