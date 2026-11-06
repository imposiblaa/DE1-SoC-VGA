set_global_assignment -entity "CLOCK74_PLL" -library "lib_CLOCK74_PLL" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "CLOCK74_PLL" -library "lib_CLOCK74_PLL" -name IP_TOOL_VERSION "17.0"
set_global_assignment -entity "CLOCK74_PLL" -library "lib_CLOCK74_PLL" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_CLOCK74_PLL" -name SPD_FILE [file join $::quartus(sip_path) "CLOCK74_PLL.spd"]

set_global_assignment -library "lib_CLOCK74_PLL" -name MISC_FILE [file join $::quartus(sip_path) "CLOCK74_PLL_sim/CLOCK74_PLL.vo"]
