window.apexUtils = window.apexUtils || {};
window.apexUtils.universalTheme = {
	collapseNavMenu: function(){
		apex.theme42.toggleWidgets.collapseWidget('nav');
	},
	expandNavMenu: function(){
		apex.theme42.toggleWidgets.expandWidget('nav');
	},
	collapseNavMenuNodes: function(){
		$(apex.theme42.TREE_NAV).treeView('collapseAll');
	},
	expandNavMenuNodes: function(){
		$(apex.theme42.TREE_NAV).treeView('expandAll');
	},
	collapseCollapsibleRegion: function(selector){
		var $region = $(selector);
		// See widget.ToggleCore.js and widget.collapsible.js
		// This unfortunately remains the best option
		// todo. check that this is actually a collapsible region
		//if ($region.hasClass('is-expanded')) {
		//	$region.find('button.t-Button--hideShow').first().click().blur();
		//}
		if($region.collapsible().length==0){
			apex.debug.error('Region is not collapsible');
			return;
		}
		$region.collapsible('instance').core.collapse();
		$region.collapsible('instance').core.setUserPreference(false);
	},
	expandCollapsibleRegion: function(selector){
		var $region = $(selector);
		if($region.collapsible().length==0){
			apex.debug.error('Region is not collapsible');
			return;
		}
		$region.collapsible('instance').core.expand();
		$region.collapsible('instance').core.setUserPreference(true);
	},
	configureSuccessNotificationDuration: function(duration){
		apex.theme42.configureSuccessMessages({
			autoDismiss: true,
			duration: duration
		});
	},
	scrollTo: function(selector, duration){
		//apex.theme42.util.scrollTo(id);
		//changed the default scrollTo function to not only handle id-s,
		//but any jQuery selector or jQuery object
        var elem$,
            elemOffset;

        if(typeof(duration) != "number"){
        	duration = 400;
        }

        elem$ = $( selector );
        if ( elem$[0] ) {
            elemOffset = elem$.offset().top - apex.theme.defaultStickyTop();
            $( 'html, body', apex.gPageContext$ ).animate({
                scrollTop: elemOffset
            }, duration);
        }
	},
	exec: function(){
		var daThis = this;
		var performAction = daThis.action.attribute01;
		var duration = daThis.action.attribute02;

		var spinnerHTML = daThis.action.attribute03;
		var spinnerCSS = daThis.action.attribute04;

		switch(performAction){
			case 'collapsenavmenu':
				apexUtils.universalTheme.collapseNavMenu();
				break;
			case 'expandnavmenu':
				apexUtils.universalTheme.expandNavMenu();
				break;
			case 'collapsenavmenunodes':
				apexUtils.universalTheme.collapseNavMenuNodes();
				break;
			case 'expandnavmenunodes':
				apexUtils.universalTheme.expandNavMenuNodes();
				break;
			case 'collapsecollapsibleregion':
				if(daThis.action.affectedElementsType != 'REGION'){
					apex.debug.error('A region needs to be selected for ' + daThis.action.action);
				} else {
					apexUtils.universalTheme.collapseCollapsibleRegion(daThis.affectedElements);
				}
				break;
			case 'expandcollapsibleregion':
				if(daThis.action.affectedElementsType != 'REGION'){
					apex.debug.error('A region needs to be selected for ' + daThis.action.action);
				} else {
					apexUtils.universalTheme.expandCollapsibleRegion(daThis.affectedElements);
				}
				break;
			case 'scrollto':
				//if no Affected Element was selected, daThis.affectedElements will (for some reason) be the document object
				//so we check the affectedElementsType which will be null
				//daThis.affectedElements.length will be 0 if the provided selector returns no objects
				if(!daThis.action.affectedElementsType || daThis.affectedElements.length == 0){
					apex.debug.error('No Affected Element found for ' + daThis.action.action);
				} else {
					apexUtils.universalTheme.scrollTo(daThis.affectedElements.eq(0), parseInt(duration));
				}
				break;
			case 'configuresuccessnotificationduration':
				apexUtils.universalTheme.configureSuccessNotificationDuration(parseInt(duration));
				break;
			default:
				apex.debug.error('Action "' + performAction + '" for ' + daThis.action.action + ' not handled');
		}
	}
};