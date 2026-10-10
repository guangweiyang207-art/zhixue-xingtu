# 生成学生端 tabBar 图标(覆盖损坏的占位文件)
# 普通 #9E9E9E / 选中 #6B5AED,81x81 透明底 PNG
# 文件名用 tab-xxx 前缀:旧文件名(home/book/ai/mine*.png)被开发者工具按路径缓存过裂图,换名强制失效
Add-Type -AssemblyName System.Drawing

$outDir = 'c:\Users\lenovo\Desktop\0521\zhixue-xingtu\zhixue-xingtu\zhixue-student-ui\static\images\tabbar'

function New-Icon {
    param([string]$Kind, [string]$ColorHex, [string]$File)

    $bmp = New-Object System.Drawing.Bitmap 81, 81
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)

    $brush = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml($ColorHex))

    switch ($Kind) {
        'home' {
            # 屋顶
            $pts = @([System.Drawing.PointF]::new(40, 8), [System.Drawing.PointF]::new(6, 38), [System.Drawing.PointF]::new(74, 38))
            $g.FillPolygon($brush, $pts)
            # 房体
            $g.FillRectangle($brush, 14, 38, 52, 34)
            # 挖出门(透出透明底)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
            $g.FillRectangle([System.Drawing.Brushes]::Transparent, 32, 50, 17, 22)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
        }
        'book' {
            # 左右两页
            $g.FillRectangle($brush, 12, 16, 26, 48)
            $g.FillRectangle($brush, 43, 16, 26, 48)
            # 中缝
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
            $g.FillRectangle([System.Drawing.Brushes]::Transparent, 38, 12, 5, 56)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
        }
        'ai' {
            # 对话气泡
            $g.FillEllipse($brush, 8, 12, 65, 46)
            # 气泡尾巴
            $tail = @([System.Drawing.PointF]::new(22, 52), [System.Drawing.PointF]::new(40, 52), [System.Drawing.PointF]::new(18, 72))
            $g.FillPolygon($brush, $tail)
            # 两个眼睛(挖空)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
            $g.FillEllipse([System.Drawing.Brushes]::Transparent, 26, 29, 10, 10)
            $g.FillEllipse([System.Drawing.Brushes]::Transparent, 45, 29, 10, 10)
            $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
        }
        'mine' {
            # 头
            $g.FillEllipse($brush, 27, 8, 27, 27)
            # 肩身
            $g.FillEllipse($brush, 12, 42, 57, 50)
        }
    }

    $bmp.Save((Join-Path $outDir $File), [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Host "generated $File"
}

$gray = '#9E9E9E'
$active = '#6B5AED'
foreach ($k in @('home','book','ai','mine')) {
    New-Icon -Kind $k -ColorHex $gray   -File "tab-$k.png"
    New-Icon -Kind $k -ColorHex $active -File "tab-$k`_on.png"
}
Write-Host 'ALL DONE'
