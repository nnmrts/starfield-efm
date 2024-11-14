# Get the user configuration settings.
$settingsPath = [IO.Path]::Combine($(Get-Location), "settings.psd1")
if (-not (Test-Path -Path $settingsPath)) {
	Write-Warning "Missing your user defined configuration file at '$settingsPath'."
	Write-Warning "Read the 'settings.default.psd1' file for more information."
	return
}
$global:AppConfig = Import-PowerShellDataFile -Path $settingsPath

# Test the parameter arguments.
if (-not (Test-Path -Path $AppConfig.WatchDirectory))
{
	Write-Warning "Cannot watch the '$($AppConfig.WatchDirectory)' directory, does not exist."
	return
}
elseif (-not (Test-Path -Path $AppConfig.DeployDirectory))
{
	Write-Warning "Cannot deploy the '$($AppConfig.DeployDirectory)' directory, does not exist."
	return
}
else
{
	Write-Host
	Write-Host "FILE WATCHER - Extended Favorites Menu (EFM)"
	Write-Host "======================================================================"
	Write-Host "- Watching directory: $($AppConfig.WatchDirectory)"
	Write-Host "- Deployment directory: $($AppConfig.DeployDirectory)"
	Write-Host
	Write-Host "Press CTRL+C or exit your shell to terminate this watch process."
	Write-Host "[$(Get-Date)] Beginning file watch now :)"
	Write-Host
}

# Create a file watcher instance
# https://stackoverflow.com/questions/1764809/filesystemwatcher-changed-event-is-raised-twice
# https://learn.microsoft.com/en-us/dotnet/api/system.io.notifyfilters?view=net-8.0
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $AppConfig.WatchDirectory
$watcher.EnableRaisingEvents = $true
$watcher.IncludeSubdirectories = $true
$watcher.NotifyFilter = [IO.NotifyFilters]::FileName -bor [System.IO.NotifyFilters]::Size

# Define the watcher action
$action = {
	$path = $event.SourceEventArgs.FullPath
	$name = $event.SourceEventArgs.Name
	$changetype = $event.SourceEventArgs.ChangeType
	$timeStamp = Get-Date
	$message = "[$timeStamp] Copying $changeType file '$name' to '$($global:AppConfig.DeployDirectory)'"
	try
	{
		$destination = [IO.Path]::Combine($global:AppConfig.DeployDirectory, $name)
		$folder = [IO.Path]::GetDirectoryName($destination)
		if (-not (Test-Path -Path $folder -PathType Container)) {
			New-Item -Path $folder -ItemType Directory
		}
		Copy-Item -Path $path -Destination $destination -Container -Force -ErrorAction Stop
		$message += " | Copy Success"
		Write-Host $message
	}
	catch
	{
		$message += " | Copy Failed: '$path': $_"
		Write-Error $message
	}
}

# Register the event handlers
$changedEvent = Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $action
$createdEvent = Register-ObjectEvent -InputObject $watcher -EventName Created -Action $action
$renamedEvent = Register-ObjectEvent -InputObject $watcher -EventName Renamed -Action $action

# Main loop to capture termination.
# - Polls every 3 seconds and says hello to user every 60th poll (every 3 minutes).
$counter = 0
try
{
	do
	{
		Start-Sleep -Seconds 3
		if ($counter -ge 60)
		{
			$counter = 0
			Write-Host "[$(Get-Date)] Still listening for file changes... (Press CTRL+C to terminate this watch process.)"
		}
		else
		{
			$counter++
		}
	}
	while ($true)
}
finally
{
	Write-Host
	Write-Host "[$(Get-Date)] Unregistering events and exiting..."
	Unregister-Event -SourceIdentifier $changedEvent.Name
	Unregister-Event -SourceIdentifier $createdEvent.Name
	Unregister-Event -SourceIdentifier $renamedEvent.Name
	$watcher.EnableRaisingEvents = $false
	$watcher.Dispose()
}
