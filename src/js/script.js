window.apexUtils = window.apexUtils || {};
window.apexUtils.universalTheme = {
	collapseNavMenu: function(){
		/* the toggleWidgets object is not exposed in 19.1 anymore
		 * apex.theme42.toggleWidgets.collapseWidget('nav');
		 * maybe they bring it back at some point.
		 * Using a workaround instead
		 */
	    if($('#t_Button_navControl').hasClass('is-active')){
		    $('#t_Button_navControl').click().blur();
	    }
	},
	expandNavMenu: function(){
		/* the toggleWidgets object is not exposed in 19.1 anymore
		 * apex.theme42.toggleWidgets.expandWidget('nav');
		 * maybe they bring it back at some point.
		 * Using a workaround instead
		 */
	    if(!$('#t_Button_navControl').hasClass('is-active')){
		    $('#t_Button_navControl').click().blur();
	    }
	},
	setNavMenuNodesAutoCollapse: function(on){
		$('#t_TreeNav').treeView("option", "autoCollapse", on);
	},
	collapseNavMenuNodes: function(){
		$('#t_TreeNav').treeView('collapseAll');
	},
	expandNavMenuNodes: function(){
		$('#t_TreeNav').treeView('expandAll');
	},
	collapseCollapsibleRegion: function(selector){
		var $region = $(selector);
		// See widget.ToggleCore.js and widget.collapsible.js
		// This unfortunately remains the best option
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
	maximizeMaximizableRegion: function(selector){
		var $btn = $('.js-maximizeButtonContainer > button', selector).first();
		if($btn.attr('aria-expanded') == 'false'){
			$btn.click().blur();
		}
	},
	restoreMaximizableRegion: function(selector){
		var $btn = $('.js-maximizeButtonContainer > button', selector).first();
		if($btn.attr('aria-expanded') == 'true'){
			$btn.click().blur();
		}
	},
	configureSuccessNotificationDuration: function(duration){
		//>=19.1
		if(apex.theme42.util.configAPEXMsgs){
			apex.theme42.util.configAPEXMsgs({
		    	autoDismiss: true,
		    	duration: parseInt(duration)
		  	});
		//<19.1
		} else {
			apex.message.setThemeHooks({
				beforeShow: function(pMsgType, pElement$){
					if (pMsgType=='success'){ 
						setTimeout(function(){
							$('.t-Alert').fadeOut('slow');
						}, parseInt(duration));
					}
				}
			});
		}
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
		var daThis 		  = this;
		var performAction = daThis.action.attribute01;
		var duration 	  = daThis.action.attribute02;

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
			case 'setnavmenunodesautocollapse':
				apexUtils.universalTheme.setNavMenuNodesAutoCollapse(daThis.action.attribute03 == 'Y');
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
			case 'maximizableregionmaximize':
				if(daThis.action.affectedElementsType != 'REGION'){
					apex.debug.error('A region needs to be selected for ' + daThis.action.action);
				} else {
					apexUtils.universalTheme.maximizeMaximizableRegion(daThis.affectedElements);
				}
				break;
			case 'maximizableregionrestore':
				if(daThis.action.affectedElementsType != 'REGION'){
					apex.debug.error('A region needs to be selected for ' + daThis.action.action);
				} else {
					apexUtils.universalTheme.restoreMaximizableRegion(daThis.affectedElements);
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

apex.jQuery(window).on('apexwindowresized', function() {
	$('body').trigger('au-ut-apexwindowresized');
});

apex.jQuery(window).on('theme42ready', function() {
	$('body').trigger('au-ut-theme42ready');
});

apex.jQuery('#t_TreeNav').on('theme42layoutchanged', function(event, obj) {
	if(obj.action == 'expand'){
		$('body').trigger('au-ut-theme42navmenuexpanded');
	} else if (obj.action == 'collapse'){
		$('body').trigger('au-ut-theme42navmenucollapsed');
	}
});
