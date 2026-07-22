$iconSizes = @(72, 96, 128, 144, 152, 192, 384, 512)

foreach ($size in $iconSizes) {
    $outputPath = "icon-${size}x${size}.png"
    
    Add-Type -AssemblyName System.Drawing
    
    $bitmap = New-Object System.Drawing.Bitmap($size, $size)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    
    $gradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        [System.Drawing.Point]::Empty,
        [System.Drawing.Point]::new($size, $size),
        [System.Drawing.Color]::FromArgb(0, 210, 255),
        [System.Drawing.Color]::FromArgb(58, 123, 213)
    )
    
    $graphics.FillRectangle($gradient, 0, 0, $size, $size)
    
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 3)
    $centerX = $size / 2
    $centerY = $size / 2
    $radius = [Math]::Min($size, $size) * 0.35
    $graphics.DrawEllipse($pen, $centerX - $radius, $centerY - $radius, $radius * 2, $radius * 2)
    
    $smallRadius = $radius * 0.5
    $graphics.FillEllipse([System.Drawing.Brushes]::White, $centerX - $smallRadius, $centerY - $smallRadius, $smallRadius * 2, $smallRadius * 2)
    
    $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $graphics.Dispose()
    $bitmap.Dispose()
    $gradient.Dispose()
    $pen.Dispose()
    
    Write-Host "Created: $outputPath"
}

Write-Host "`n✅ 所有图标生成完成！"