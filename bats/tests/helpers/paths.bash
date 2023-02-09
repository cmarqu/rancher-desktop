if is_macos; then
    PATH_APP_HOME="$HOME/Library/Application Support/rancher-desktop"
    PATH_CONFIG="$HOME/Library/Preferences/rancher-desktop"
    PATH_CACHE="$HOME/Library/Caches/rancher-desktop"
    PATH_LOGS="$HOME/Library/Logs/rancher-desktop"
    PATH_EXECUTABLE="/Applications/Rancher Desktop.app/Contents/MacOS/Rancher Desktop"
    PATH_RESOURCES="/Applications/Rancher Desktop.app/Contents/Resources/resources"
    LIMA_HOME="$PATH_APP_HOME/lima"
fi

if is_linux; then
    PATH_APP_HOME="$HOME/.config/rancher-desktop"
    PATH_CONFIG="$HOME/.config/rancher-desktop"
    PATH_CACHE="$HOME/.local/cache/rancher-desktop"
    PATH_DATA="$HOME/.local/share/rancher-desktop"
    PATH_LOGS="$PATH_DATA/logs"
    PATH_EXECUTABLE="" # TODO
    PATH_RESOURCES="/opt/rancher-desktop/resources/resources"
    LIMA_HOME="$PATH_DATA/lima"
fi

win32env() {
    # The cmd.exe _sometimes_ returns an empty string when invoked in a subshell
    # wslpath "$(cmd.exe /c "echo %$1%" 2>/dev/null)" | tr -d "\r"
    # Let's see if powershell.exe avoids this issue
    wslpath "$(powershell.exe -Command "Write-Output \${Env:$1}")"  | tr -d "\r"
}

if is_windows; then
    APPDATA="$(win32env APPDATA)"
    LOCALAPPDATA="$(win32env LOCALAPPDATA)"
    PROGRAMFILES="$(win32env ProgramFiles)"

    PATH_APP_HOME="$APPDATA/rancher-desktop"
    PATH_CONFIG="$APPDATA/rancher-desktop"
    PATH_DATA="$LOCALAPPDATA/rancher-desktop"
    PATH_CACHE="$PATH_DATA/cache"
    PATH_LOGS="$PATH_DATA/logs"
    PATH_EXECUTABLE="$PROGRAMFILES/Rancher Desktop/Rancher Desktop.exe"
    PATH_RESOURCES="$PROGRAMFILES/Rancher Desktop/resources/resources"
fi

PATH_CONFIG_FILE="$PATH_CONFIG/settings.json"