component {

	public void function configure( required struct config ) {
		var conf     = arguments.config;
		var settings = conf.settings ?: {};

		_setupFeatures( settings );
		_setupPermissionsAndRoles( settings );
		_setupInterceptors( conf );
		_configureAdminTheme( settings );
		_setupNavigation( settings );
		_setupDerivatives( settings );
	}


	private void function _setupFeatures( settings ) {
		settings.features.siteSwitcher.enabled = false;
	}

	private void function _setupPermissionsAndRoles( settings ) {
		settings.adminPermissions.notifications = settings.adminPermissions.notifications ?: [];
		settings.adminPermissions.notifications.append( "view" );

		settings.adminRoles.viewNotifications = [ "notifications.view" ];
	}

	private void function _setupInterceptors( conf ) {
		conf.interceptorSettings.customInterceptionPoints.append( "preRenderAdminLayout" );
		conf.interceptorSettings.customInterceptionPoints.append( "preRenderAdminLoginLayout" );
	}

	private void function _configureAdminTheme( settings ) {
		settings.admin = {
			  topNavItems     = []
			, topNavMenuIcons = true
			, favicon         = "/preside/system/assets/images/logos/favicon.png"
			, adminAvatarSize = 56
			, customCss       = []
		};
	}

	private void function _setupNavigation( settings ) {
		settings.admin.topNavItems = [
			  "cms"
			, "emailcenter"
		];

		settings.adminMenuItems.cms = {
			subMenuItems = [
				  "sitetree"
				, "assetmanager"
				, "datamanager"
				, "websiteusers"
				, "formbuilder"
				, "-"
				, "sitemanager"
			]
		};

		settings.adminMenuItems.siteManager = {
			  buildLinkArgs = { linkto="sites.manage" }
			, activeChecks  = { handlerPatterns="^admin\.sites\." }
			, title         = "cms:sitenav.managesites"
			, icon          = "fa-globe"
		};
	}

	private void function _setupDerivatives( settings ) {
		settings.assetManager.derivatives.customHeaderImg75px = {
			  permissions     = "inherit"
			, transformations = [ { method="Resize", args={ width=75, height=75, maintainAspectRatio=true, useCropHint=true } } ]
		};
	}

}
