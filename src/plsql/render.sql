/*------------------------------------------------------------------------------
 * Author       Stefan Dobre
 * Created      01.06.2019
 *
 * Description  A set of dynamic actions related to the Universal Theme &
 *               user interaction
 *
 * License      MIT 
 *------------------------------------------------------------------------------
 * Modification History
 *
 * 27.06.2019   v1.0.1   fixed success notif duration issue
 * 24.06.2019   v1.0     initial release
 */-----------------------------------------------------------------------------
function render
    ( p_dynamic_action in apex_plugin.t_dynamic_action
    , p_plugin         in apex_plugin.t_plugin
    )
return apex_plugin.t_dynamic_action_render_result
is

    -- plugin attributes
    l_result              apex_plugin.t_dynamic_action_render_result;
    l_perform_action      varchar2(100) := p_dynamic_action.attribute_01;
    l_scrollto_speed      varchar2(100) := p_dynamic_action.attribute_02;
    l_scrollto_duration   varchar2(100) := p_dynamic_action.attribute_03;
    l_success_duration    varchar2(100) := p_dynamic_action.attribute_04;
    l_autoCollapse        varchar2(100) := p_dynamic_action.attribute_05;

    -- variables
    l_duration            number;

begin
    -- debug
    apex_plugin_util.debug_dynamic_action
        ( p_plugin         => p_plugin
        , p_dynamic_action => p_dynamic_action
        );

    apex_javascript.add_library
        ( p_name       => 'script#MIN#'
        , p_directory  => nvl(:G_APEX_NITRO_UNIVERSAL_THEME, p_plugin.file_prefix) || 'js/'
        );

    if l_perform_action = 'scrollto' then
        l_duration := case when l_scrollto_speed != 'custom' 
                        then p_dynamic_action.attribute_02 
                        else p_dynamic_action.attribute_03 
                      end;
    elsif l_perform_action = 'configuresuccessnotificationduration' then
        l_duration := l_success_duration;
    end if;

    l_result.javascript_function := 'apexUtils.universalTheme.exec';
    l_result.attribute_01        := l_perform_action;
    
    --For action "Scroll To" or "Configure Success Notification Duration"
    l_result.attribute_02        := l_duration;
    
    -- autoCollapse Y/N
    l_result.attribute_03        := l_autoCollapse;

    return l_result;

end render;