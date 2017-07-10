param(
	[Parameter(ValueFromPipeline=$true)] [string] $tocLocation = ".",
	[string] $logFile = ""
)

function Write-Message {
	param (
		[Parameter(ValueFromPipeline=$true, Mandatory=$true)] [string] $message,
		[Parameter(Mandatory=$true)] [string] $file,
		[switch] $information,
		[switch] $warning,
		[switch] $error
	)

	if($error){
		$type = "ERROR:: "
		Write-Host ($type + $message) -foregroundcolor red
	}
	elseif($warning){
		$type = "WARNING:: "
		Write-Host ($type + $message) -foregroundcolor yellow
	}
	else {
		Write-Host $message
	}

	if(-Not [string]::IsNullOrEmpty($logFile))
	{
		Add-Content -path $logFile -value ($type + $message)
	}
}

Write-Message -message ("Starting Transition of Care counts...") -file $logFile
Write-Message -message ('Processing files at location "' + $tocLocation + '\*.xml" ...') -file $logFile
Write-Message -message (" ") -file $logFile

$files = (Get-ChildItem $tocLocation\*.xml)

$cmos = @{}

foreach ($file in $files) {

	if ($file -Is [System.IO.DirectoryInfo]) {
		continue
	}

	$fileContents = (Get-Content $file.FullName -raw).Trim()
	$fileContents = $fileContents -replace "\r\n",""

	$fileContents | Select-String "<TransitionOfCare.*</TransitionOfCare>" -AllMatches |
		Foreach-Object {$_.Matches} |
		Foreach-Object {$transitionOfCare = $_.Value}

	$tocDocument = [xml]($transitionOfCare)
	$XmlNamespace = @{ hl7 = 'urn:hl7-org:v3'; };

	$cmo = @{}
	$cmo.Name = (Select-Xml -Xml $tocDocument -XPath '/TransitionOfCare/Author/Name').ToString()
	$cmo.MedicaidId = (Select-Xml -Xml $tocDocument -XPath '/TransitionOfCare/Patient/MedicaidId').ToString()
	$transmissionType = (Select-Xml -Xml $tocDocument -XPath '/TransitionOfCare/@Type').ToString()
	$programType = $tocDocument.SelectNodes('/TransitionOfCare/CaseManagement/ProgramType').ToString()
	$problems = $tocDocument.SelectNodes('/TransitionOfCare/CaseManagement/CarePlan/Problems/Problem')

	if ([string]::IsNullOrEmpty($cmo.Name)) {
		Write-Message -message ($file.Name + " - Did not find an CMO.") -file $logFile
		continue
	}

	if (-Not $cmos.ContainsKey($cmo.Name)) {
		$cmos[$cmo.Name] = @{}
		$cmos[$cmo.Name].Name = $cmo.Name
		$cmos[$cmo.Name].MedicaidIds = @()
		$cmos[$cmo.Name].BlankToCs = 0
		$cmos[$cmo.Name].CarePlanToCs = 0
		$cmos[$cmo.Name].FinalToCs = 0
		$cmos[$cmo.Name].NotificationToCs = 0
	}

	$cmos[$cmo.Name].MedicaidIds += $cmo.MedicaidId
	if (-not [string]::IsNullOrEmpty($programType) -and $problems.Count -lt 1) {
		$cmos[$cmo.Name].BlankToCs += 1
		$blank = "TRUE"
	}
	else {
		$cmos[$cmo.Name].CarePlanToCs += 1
		$blank = "FALSE"
	}
	if ($transmissionType.Equals("F")) {
		$cmos[$cmo.Name].FinalToCs += 1
	}
	elseif ($transmissionType.Equals("N")) {
		$cmos[$cmo.Name].NotificationToCs += 1
	}

	Write-Message -message ($cmo.MedicaidId + ", " + $cmo.Name + ", Type: " + $transmissionType + ", Blank?: " + $blank) -file $logFile
}

Write-Message -message (" ") -file $logFile
Write-Message -message ("-----SUMMARY------------------------------") -file $logFile
Write-Message -message (" ") -file $logFile

foreach ($key in $cmos.Keys) {
	Write-Message -message ($cmos[$key].Name.ToString().ToUpper()) -file $logFile
	Write-Message -message ("    Blanks: " + $cmos[$key].BlankToCs) -file $logFile
	Write-Message -message ("    Care Plans: " + $cmos[$key].CarePlanToCs) -file $logFile
	Write-Message -message ("    Finals: " + $cmos[$key].FinalToCs) -file $logFile
	Write-Message -message ("    Notifications: " + $cmos[$key].NotificationToCs) -file $logFile
	Write-Message -message ("    Total: " + $cmos[$key].MedicaidIds.Count) -file $logFile
	Write-Message -message (" ") -file $logFile
}

Write-Message -message ("------------------------------------------") -file $logFile
Write-Message -message (" ") -file $logFile
Write-Message -message ("Finished Transition of Care counts...") -file $logFile

Read-Host "Press any key to exit"

exit