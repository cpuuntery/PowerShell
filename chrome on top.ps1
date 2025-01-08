# Check if chrome is running
$Process_runing = Get-Process -Name chrome -ErrorAction SilentlyContinue
if (-not $Process_runing) {
    & "C:\Users\Yousif\AppData\Local\Chromium\Application\chrome.exe"
	Start-Sleep -Seconds 1
	$User32 = Add-Type -Debug:$False -MemberDefinition '
[DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X,int Y, int cx, int cy, uint uFlags);
[DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
[DllImport("user32.dll")] public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
[DllImport("user32.dll")] public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
[DllImport("user32.dll")] public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
' -Name "User32Functions" -namespace User32Functions -PassThru

$Handle = (Get-Process -Name chrome | Where-Object { $_.MainWindowTitle -ne "" }).MainWindowHandle

# Constants
$SWP_NOMOVE = 0x0002
$SWP_NOSIZE = 0x0001
$SWP_SHOWWINDOW = 0x0040
$HWND_TOPMOST = -1
$HWND_NOTOPMOST = -2
$GWL_EXSTYLE = -20
$WS_EX_TOPMOST = 0x00000008

# Get the current extended window style
$currentStyle = $User32::GetWindowLong($Handle, $GWL_EXSTYLE)

# Determine new style based on the current state
if ($currentStyle -band $WS_EX_TOPMOST) {
# Remove "always on top"
$User32::SetWindowPos($Handle, $HWND_NOTOPMOST, 0, 0, 0, 0, $SWP_NOMOVE -bor $SWP_NOSIZE)
} else {
# Set "always on top"
$User32::SetWindowPos($Handle, $HWND_TOPMOST, 0, 0, 0, 0, $SWP_NOMOVE -bor $SWP_NOSIZE -bor $SWP_SHOWWINDOW)
}

}
else {
$User32 = Add-Type -Debug:$False -MemberDefinition '
[DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X,int Y, int cx, int cy, uint uFlags);
[DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
[DllImport("user32.dll")] public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
[DllImport("user32.dll")] public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
[DllImport("user32.dll")] public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
' -Name "User32Functions" -namespace User32Functions -PassThru

$Handle = (Get-Process -Name chrome | Where-Object { $_.MainWindowTitle -ne "" }).MainWindowHandle

# Constants
$SWP_NOMOVE = 0x0002
$SWP_NOSIZE = 0x0001
$SWP_SHOWWINDOW = 0x0040
$HWND_TOPMOST = -1
$HWND_NOTOPMOST = -2
$GWL_EXSTYLE = -20
$WS_EX_TOPMOST = 0x00000008

# Get the current extended window style
$currentStyle = $User32::GetWindowLong($Handle, $GWL_EXSTYLE)

# Determine new style based on the current state
if ($currentStyle -band $WS_EX_TOPMOST) {
# Remove "always on top"
$User32::SetWindowPos($Handle, $HWND_NOTOPMOST, 0, 0, 0, 0, $SWP_NOMOVE -bor $SWP_NOSIZE)
} else {
# Set "always on top"
$User32::SetWindowPos($Handle, $HWND_TOPMOST, 0, 0, 0, 0, $SWP_NOMOVE -bor $SWP_NOSIZE -bor $SWP_SHOWWINDOW)
}

}
