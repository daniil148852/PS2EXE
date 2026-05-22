Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "SOULSTEALER v666"
$form.WindowState = "Maximized"
$form.FormBorderStyle = "None"
$form.BackColor = [System.Drawing.Color]::Black
$form.TopMost = $true
$form.Cursor = [System.Windows.Forms.Cursors]::No

# Основной текст
$label = New-Object System.Windows.Forms.Label
$label.ForeColor = [System.Drawing.Color]::Lime
$label.Font = New-Object System.Drawing.Font("Consolas", 52, [System.Drawing.FontStyle]::Bold)
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(200, 200)
$form.Controls.Add($label)

# Дополнительные мелкие надписи
$smallLabels = @()
for ($i = 0; $i -lt 8; $i++) {
    $sl = New-Object System.Windows.Forms.Label
    $sl.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 80)
    $sl.Font = New-Object System.Drawing.Font("Consolas", 18)
    $sl.AutoSize = $true
    $form.Controls.Add($sl)
    $smallLabels += $sl
}

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 45

$timer.Add_Tick({
    $creepyMessages = @(
        "YOUR SOUL IS MINE",
        "I SEE YOU",
        "THERE IS NO ESCAPE",
        "HE IS BEHIND YOU",
        "SWEET DREAMS...",
        "WHY ARE YOU RUNNING?",
        "SOULSTEALER v666",
        "01001000 01000101 01001100 01010000",
        "I AM INSIDE YOUR WALLS",
        "STOP LOOKING"
    )

    $label.Text = $creepyMessages | Get-Random
    $label.ForeColor = [System.Drawing.Color]::FromArgb((Get-Random -Max 80), (Get-Random -Max 255), (Get-Random -Max 100))
    
    # Случайное положение большого текста
    $label.Location = New-Object System.Drawing.Point(
        (Get-Random -Minimum 50 -Maximum ($form.Width - 600)),
        (Get-Random -Minimum 50 -Maximum ($form.Height - 300))
    )

    # Маленькие raining надписи
    foreach ($sl in $smallLabels) {
        $sl.Text = "☠︎ ☣︎ ⚠︎ ♰ ☾ ☽ Ψ" | Get-Random -Count 1
        $sl.ForeColor = [System.Drawing.Color]::FromArgb(0, (Get-Random -Max 255), 60)
        $sl.Location = New-Object System.Drawing.Point(
            (Get-Random -Maximum $form.Width),
            (Get-Random -Maximum $form.Height)
        )
    }

    # Красные вспышки ужаса
    if ((Get-Random -Maximum 100) -lt 12) {
        $form.BackColor = [System.Drawing.Color]::DarkRed
        Start-Sleep -Milliseconds (Get-Random -Minimum 60 -Maximum 160)
        $form.BackColor = [System.Drawing.Color]::Black
    }

    # Глаза
    if ((Get-Random -Maximum 100) -lt 9) {
        $eye = New-Object System.Windows.Forms.Label
        $eye.Text = "👁️"
        $eye.Font = New-Object System.Drawing.Font("Segoe UI", 80)
        $eye.ForeColor = [System.Drawing.Color]::Red
        $eye.AutoSize = $true
        $eye.Location = New-Object System.Drawing.Point((Get-Random -Maximum ($form.Width-100)), (Get-Random -Maximum ($form.Height-100)))
        $form.Controls.Add($eye)
        
        # Удаляем глаз через 1.2 секунды
        $removeTimer = New-Object System.Windows.Forms.Timer
        $removeTimer.Interval = 1200
        $removeTimer.Add_Tick({ $form.Controls.Remove($eye); $removeTimer.Stop() })
        $removeTimer.Start()
    }
})

$timer.Start()

# Выход по ESC
$form.Add_KeyDown({
    if ($_.KeyCode -eq "Escape") { 
        $form.Close() 
    }
})

# Запуск
[System.Windows.Forms.Application]::Run($form)
