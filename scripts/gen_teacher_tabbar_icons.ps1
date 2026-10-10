# Teacher tabBar icons: 81x81 ARGB, new tab-* filenames to bust devtools path cache
# Usage: powershell -File scripts\gen_teacher_tabbar_icons.ps1
Add-Type -AssemblyName System.Drawing

$dir = Join-Path $PSScriptRoot "..\zhixue-teacher-ui\static\images\tabbar"
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

$gray = [System.Drawing.Color]::FromArgb(255,156,163,175)   # #9CA3AF
$blue = [System.Drawing.Color]::FromArgb(255,59,130,246)    # #3B82F6

function New-Icon([string]$file, [System.Drawing.Color]$color, [string]$kind) {
    $bmp = New-Object System.Drawing.Bitmap 81, 81
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)
    $b = New-Object System.Drawing.SolidBrush $color

    switch ($kind) {
        "home" {
            # house: triangle roof + body, punch a transparent door
            $pts = @(
                (New-Object System.Drawing.PointF 40,8),
                (New-Object System.Drawing.PointF 8,36),
                (New-Object System.Drawing.PointF 72,36)
            )
            $g.FillPolygon($b, $pts)
            $g.FillRectangle($b, 18, 36, 44, 34)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
            $g.FillRectangle([System.Drawing.Brushes]::Transparent, 33, 48, 15, 22)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
        }
        "work" {
            # tasks: 2x2 grid
            foreach($p in @(@(12,12),@(44,12),@(12,44),@(44,44))){
                $r = New-Object System.Drawing.Rectangle $p[0], $p[1], 25, 25
                $g.FillRectangle($b, $r)
            }
        }
        "student" {
            # two people: heads + shoulders
            $g.FillEllipse($b, 14, 18, 20, 20)
            $g.FillEllipse($b, 44, 18, 20, 20)
            $body1 = New-Object System.Drawing.Drawing2D.GraphicsPath
            $body1.AddArc(6, 42, 36, 30, 180, 180)
            $g.FillPath($b, $body1)
            $body2 = New-Object System.Drawing.Drawing2D.GraphicsPath
            $body2.AddArc(38, 42, 36, 30, 180, 180)
            $g.FillPath($b, $body2)
        }
        "mine" {
            # single person: head + shoulders
            $g.FillEllipse($b, 27, 10, 26, 26)
            $body = New-Object System.Drawing.Drawing2D.GraphicsPath
            $body.AddArc(14, 42, 52, 40, 180, 180)
            $g.FillPath($b, $body)
        }
    }
    $g.Dispose()
    $bmp.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

$items = @(
    @{n="tab-home";    k="home"},
    @{n="tab-work";    k="work"},
    @{n="tab-student"; k="student"},
    @{n="tab-mine";    k="mine"}
)
foreach($it in $items){
    New-Icon (Join-Path $dir ($it.n + ".png"))    $gray  $it.k
    New-Icon (Join-Path $dir ($it.n + "_on.png")) $blue  $it.k
    Write-Host ("OK " + $it.n + ".png / " + $it.n + "_on.png")
}
