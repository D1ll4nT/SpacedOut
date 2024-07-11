# This script restores the original keyboard mapping on the machine
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public class Keyboard {
    [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
    public static extern short GetKeyState(int virtualKeyCode);
    [DllImport("user32.dll")]
    public static extern int MapVirtualKey(int uCode, int uMapType);
}
'@

$VK = [System.Windows.Forms.Keys]
$originalMapping = @{
    '{ESC}'= 'ESC'
    '{TAB}'= 'TAB'
    '{CAPSLOCK}'= 'CAPSLOCK'
    '{SHIFT}'= 'SHIFT'
    '{CTRL}'= 'CTRL'
    '{ALT}'= 'ALT'
    '{BACKSPACE}'= 'BACKSPACE'
    '{ENTER}'= 'ENTER'
    '{LWIN}'= 'LWIN'
    '{RWIN}'= 'RWIN'
    '{MENU}'= 'MENU'
    '{LEFT}'= 'LEFT'
    '{RIGHT}'= 'RIGHT'
    '{UP}'= 'UP'
    '{DOWN}'= 'DOWN'
    '{HOME}'= 'HOME'
    '{END}'= 'END'
    '{PAGEUP}'= 'PAGEUP'
    '{PAGEDOWN}'= 'PAGEDOWN'
    '{INSERT}'= 'INSERT'
    '{DELETE}'= 'DELETE'
    '{NUMLOCK}'= 'NUMLOCK'
    '{SCROLLLOCK}'= 'SCROLLLOCK'
    '{PAUSE}'= 'PAUSE'
    '{F1}'= 'F1'
    '{F2}'= 'F2'
    '{F3}'= 'F3'
    '{F4}'= 'F4'
    '{F5}'= 'F5'
    '{F6}'= 'F6'
    '{F7}'= 'F7'
    '{F8}'= 'F8'
    '{F9}'= 'F9'
    '{F10}'= 'F10'
    '{F11}'= 'F11'
    '{F12}'= 'F12'
    '{OEM_1}'= 'OEM_1'  # ;:
    '{OEM_PLUS}'= 'OEM_PLUS'  # =+
    '{OEM_COMMA}'= 'OEM_COMMA'  # ,<
    '{OEM_MINUS}'= 'OEM_MINUS'  # -_
    '{OEM_PERIOD}'= 'OEM_PERIOD'  # .>
    '{OEM_2}'= 'OEM_2'  # /?
    '{OEM_3}'= 'OEM_3'  # `~
    '{OEM_4}'= 'OEM_4'  # [{
    '{OEM_5}'= 'OEM_5'  # \|
    '{OEM_6}'= 'OEM_6'  # ]}
    '{OEM_7}'= 'OEM_7'  # '"
}

foreach ($key in $originalMapping.Keys) {
    $scanCode = [int]::Parse($VK::$key)
    $newCode = [int]::Parse($VK::$originalMapping[$key])
    [Keyboard]::MapVirtualKey($scanCode, 0) = $newCode
}
