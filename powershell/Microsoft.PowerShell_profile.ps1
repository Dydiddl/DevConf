# Oh My Posh
# oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\theme.omp.json" | Invoke-Expression

# 파일 및 폴더 표시 색상
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.BrightCyan
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.BrightMagenta
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.BrightGreen

# 현재 폴더명을 Windows Terminal 탭 제목으로 표시
$global:__omp_custom_prompt = $function:prompt

function global:prompt
{
    $folderName = Split-Path -Leaf (Get-Location).Path

    if ([string]::IsNullOrWhiteSpace($folderName))
    {
        $folderName = (Get-Location).Path
    }

    $Host.UI.RawUI.WindowTitle = $folderName

    & $global:__omp_custom_prompt
}
