prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_release=>'18.2.0.00.12'
,p_default_workspace_id=>1549777203957536
,p_default_application_id=>142
,p_default_owner=>'APEX_UTILS'
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/com_apexutils_theme42
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(28891096487744720782)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.APEXUTILS.THEME42'
,p_display_name=>'APEX Utils - Theme 42'
,p_category=>'MISC'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*-------------------------------------',
' * APEX Utils - Theme 42',
' * Version: 0.1 (6 Jan 2019)',
' * Author:  Stefan Dobre',
' *-------------------------------------',
'*/',
'function render',
'    ( p_dynamic_action in apex_plugin.t_dynamic_action',
'    , p_plugin         in apex_plugin.t_plugin',
'    )',
'return apex_plugin.t_dynamic_action_render_result',
'is',
'',
'    -- plugin attributes',
'    l_result              apex_plugin.t_dynamic_action_render_result;',
'    l_perform_action      varchar2(100)  := p_dynamic_action.attribute_01;',
'    l_scrollto_speed      varchar2(100)  := p_dynamic_action.attribute_02;',
'    l_scrollto_duration   varchar2(100)  := p_dynamic_action.attribute_03;',
'    l_success_duration    varchar2(100)  := p_dynamic_action.attribute_04;',
'',
'    -- variables',
'    l_duration            number;',
'',
'begin',
'    -- debug',
'    apex_plugin_util.debug_dynamic_action',
'        ( p_plugin         => p_plugin',
'        , p_dynamic_action => p_dynamic_action',
'        );',
'',
'    apex_javascript.add_library( p_name           => ''script#MIN#''',
'                               , p_directory      => p_plugin.file_prefix',
'                               , p_version        => null',
'                               , p_skip_extension => false',
'                               );',
'                               ',
'    if l_perform_action = ''scrollto'' then',
'        l_duration := case when l_scrollto_speed != ''custom'' ',
'                        then p_dynamic_action.attribute_02 ',
'                        else p_dynamic_action.attribute_03 ',
'                      end;',
'    elsif l_perform_action = ''configuresuccessnotifduration'' then',
'        l_duration := l_success_duration;',
'    end if;',
'',
'    l_result.javascript_function := ''apexUtils.theme42.exec'';',
'    l_result.attribute_01        := l_perform_action;',
'    ',
'    --For action "Scroll To" or "Configure Success Notification Duration"',
'    l_result.attribute_02        := l_duration;',
'',
'    return l_result;',
'',
'end render;'))
,p_api_version=>2
,p_render_function=>'render'
,p_standard_attributes=>'ITEM:BUTTON:REGION:JQUERY_SELECTOR'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.1'
,p_about_url=>'https://www.apexutils.com'
,p_files_version=>17
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(28893184394458850126)
,p_plugin_id=>wwv_flow_api.id(28891096487744720782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Action'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'collapsenavmenu'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_attribute_comment=>'Choose which action related to the Universal Theme will be performed.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28893364317141855548)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>10
,p_display_value=>'Collapse Navigation Menu'
,p_return_value=>'collapsenavmenu'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28893638994912857781)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>20
,p_display_value=>'Expand Navigation Menu'
,p_return_value=>'expandnavmenu'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28898818191961228978)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>30
,p_display_value=>'Collapse Navigation Menu Nodes'
,p_return_value=>'collapsenavmenunodes'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28898830248179234238)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>40
,p_display_value=>'Expand Navigation Menu Nodes'
,p_return_value=>'expandnavmenunodes'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28901015716178249002)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>50
,p_display_value=>'Collapse Collapsible Region'
,p_return_value=>'collapsecollapsibleregion'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28901025486336250898)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>60
,p_display_value=>'Expand Collapsible Region'
,p_return_value=>'expandcollapsibleregion'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28901073369022257824)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>70
,p_display_value=>'Configure Success Notification Duration'
,p_return_value=>'configuresuccessnotificationduration'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28901154438425263566)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>80
,p_display_value=>'Scroll To'
,p_return_value=>'scrollto'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(30503671868666454113)
,p_plugin_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_display_sequence=>90
,p_display_value=>'Change Loading Indicator'
,p_return_value=>'changeloadingindicator'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(28923479961146267456)
,p_plugin_id=>wwv_flow_api.id(28891096487744720782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Speed'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'400'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'scrollto'
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28923487196060267015)
,p_plugin_attribute_id=>wwv_flow_api.id(28923479961146267456)
,p_display_sequence=>10
,p_display_value=>'Instant'
,p_return_value=>'0'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28923502770475268265)
,p_plugin_attribute_id=>wwv_flow_api.id(28923479961146267456)
,p_display_sequence=>20
,p_display_value=>'Slow'
,p_return_value=>'600'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28923508070706269162)
,p_plugin_attribute_id=>wwv_flow_api.id(28923479961146267456)
,p_display_sequence=>30
,p_display_value=>'Default'
,p_return_value=>'400'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28923510547781269998)
,p_plugin_attribute_id=>wwv_flow_api.id(28923479961146267456)
,p_display_sequence=>40
,p_display_value=>'Fast'
,p_return_value=>'200'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(28923530129319271040)
,p_plugin_attribute_id=>wwv_flow_api.id(28923479961146267456)
,p_display_sequence=>50
,p_display_value=>'Custom'
,p_return_value=>'custom'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(28923901970017287760)
,p_plugin_id=>wwv_flow_api.id(28891096487744720782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Duration'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'400'
,p_unit=>'milliseconds'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(28923479961146267456)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'custom'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(28925460731734411111)
,p_plugin_id=>wwv_flow_api.id(28891096487744720782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Duration'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'3000'
,p_unit=>'milliseconds'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(28893184394458850126)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'configuresuccessnotificationduration'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2775736520737472696374273B0A77696E646F772E617065785574696C73203D2077696E646F772E617065785574696C73207C7C207B7D3B0A77696E646F772E617065785574696C732E7468656D653432203D2066756E6374696F6E28297B0A0A7D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(27409679072460287)
,p_plugin_id=>wwv_flow_api.id(28891096487744720782)
,p_file_name=>'script.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
