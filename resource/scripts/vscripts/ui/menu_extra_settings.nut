
global function InitExtrasMenu

struct
{
	var menu
	table<var,string> buttonDescriptions
	var classicMusicSwitch
} file

void function InitExtrasMenu()
{
	var menu = GetMenu( "ExtrasMenu" )
	file.menu = menu

	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, OnOpenExtrasMenu )
	AddMenuEventHandler( menu, eUIEvent.MENU_CLOSE, OnCloseExtrasMenu )

	var button

	SetupButton( Hud_GetChild( menu, "SwchEnableDemos" ), "Enable Demos", "Enable recording demos (must be set true before loading a map)." )
	SetupButton( Hud_GetChild( menu, "SwchDemosWrite" ), "Save Demos", "Demos write to a local file when recording a demo." )
	SetupButton( Hud_GetChild( menu, "SwchDemosInterpolate" ), "Interpolate Playback", "Do view interpolation during dem playback." )
	SetupButton( Hud_GetChild( menu, "SwchDemosUpdateRateSp" ), "Demo record rate Single Player", "Change the tick recording rate in Single Player." )
	SetupButton( Hud_GetChild( menu, "SwchDemosUpdateRateMp" ), "Demo record rate Multiplayer", "Change the tick recording rate in Multiplayer." )
	SetupButton( Hud_GetChild( menu, "SwchDemosAutorecord" ), "Auto Record", "Automatically record multiplayer matches as demos." )
	SetupButton( Hud_GetChild( menu, "SwchThirdpersonFix" ), "Auto Record", "Fix the interpretation when using the thirdperson camera." )

	button = Hud_GetChild( menu, "BtnMouseKeyboardBindings" )
	SetupButton( button, "#KEY_BINDINGS", "#MOUSE_KEYBOARD_MENU_CONTROLS_DESC" )
	AddButtonEventHandler( button, UIE_CLICK, AdvanceMenuEventHandler( GetMenu( "MouseKeyboardBindingsMenu" ) ) )

	SetupButton( Hud_GetChild( menu, "SwchEnableWallrunning" ), "Enable Wallrunning", "Enables wall running." )
	SetupButton( Hud_GetChild( menu, "SwchEnableMantle" ), "Enable Automantle", "Enables the auto mantle animation." )
	SetupButton( Hud_GetChild( menu, "SwchEnableVerticalDodge" ), "Enable Vertical Dodge", "Enables vertical dodge in Titans." )
	SetupButton( Hud_GetChild( Hud_GetChild( menu, "SldPlayerDebounce" ), "BtnDropButton" ), "Player Control Debounce", "How long after respawning will certain player inputs be debounced for." )
	SetupButton( Hud_GetChild( Hud_GetChild( menu, "SldCommandQue" ), "BtnDropButton" ), "Command Que", "Amount of commands that can be sent per tick." )
	SetupButton( Hud_GetChild( menu, "SwchEnableSpeedometer" ), "Speedometer", "Enables a speedometer in single player." )
	SetupButton( Hud_GetChild( menu, "SwchEnableCommunities" ), "Communities", "Enables community networks." )
	// Force turn off communities
	// Re-enable if communities break
	// SetConVarBool( "communities_enabled", false )
	AddEventHandlerToButtonClass( menu, "RuiFooterButtonClass", UIE_GET_FOCUS, FooterButton_Focused )

	AddMenuFooterOption( menu, BUTTON_A, "#A_BUTTON_SELECT" )
	AddMenuFooterOption( menu, BUTTON_B, "#B_BUTTON_BACK", "#BACK" )
}

void function OnOpenExtrasMenu()
{
	UI_SetPresentationType( ePresentationType.NO_MODELS )

}

void function OnCloseExtrasMenu()
{
	SavePlayerSettings()
}

void function SetupButton( var button, string buttonText, string description )
{
	SetButtonRuiText( button, buttonText )
	file.buttonDescriptions[ button ] <- description
	AddButtonEventHandler( button, UIE_GET_FOCUS, Button_Focused )
}

void function Button_Focused( var button )
{
	string description = file.buttonDescriptions[ button ]
	SetElementsTextByClassname( file.menu, "MenuItemDescriptionClass", description )
}

void function FooterButton_Focused( var button )
{
	SetElementsTextByClassname( file.menu, "MenuItemDescriptionClass", "" )
}
