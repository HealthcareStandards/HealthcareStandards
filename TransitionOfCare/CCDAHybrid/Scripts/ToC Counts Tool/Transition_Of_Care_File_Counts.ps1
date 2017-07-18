param(
    [Parameter(ValueFromPipeline = $true)] [string] $tocLocation = ".",
    [string] $logFile,
    [switch] $validateXml,
    [string] $xmlSchemaLocation,
    [string] $validationLogFile
)

#GLOBAL VARIABLES
$countModel = @{}
#GLOBAL VARIABLES

<# 
.SYNOPSIS
Main entry function used after starting script.
.EXAMPLE
Main
 #>
function Main {
    Write-Message -message ("Starting Transition of Care counts...") -file $logFile
    Write-Message -message ('Processing files at location "' + $tocLocation + '\*.xml" ...') -file $logFile
    Write-Message -message (" ") -file $logFile

    processParameters
    generateCountModels
    processSummary

    Write-Message -message ("Finished Transition of Care counts...") -file $logFile
    Read-Host "Press any key to exit"
}

<#
.SYNOPSIS
Will process user given parameters given to the script
.EXAMPLE
processParameters
#>
function processParameters {
    if ([string]::IsNullOrEmpty($validationLogFile)) {
        $script:validationLogFile = $logFile
    }

    if ($validateXml -and [string]::IsNullOrEmpty($xmlSchemaLocation)) {
        throw 'ERROR: Specified the "-validatexml" flag without setting the schema XSD file path.'
    }
}

<#
.SYNOPSIS
Process all files in the given path and create a model based around interal information in the files.
.EXAMPLE
generateCountModels
#>
function generateCountModels {
    $files = (Get-ChildItem $tocLocation\*.xml)

    foreach ($file in $files) {

        if ($file -Is [System.IO.DirectoryInfo]) {
            continue
        }

        $fileCreateDate = $file.LastWriteTime.ToString("yyyy-MM-dd")
        if (-Not $countModel.ContainsKey($fileCreateDate)) {
            $countModel[$fileCreateDate] = @{}
            $countModel[$fileCreateDate].Date = $fileCreateDate
            $countModel[$fileCreateDate].FileCount = 0
            $countModel[$fileCreateDate].ErrorFileCount = 0
            $countModel[$fileCreateDate].Transmissions = @{}
        }

        $countModel[$fileCreateDate].FileCount += 1

        $fileContents = (Get-Content $file.FullName -raw).Trim()
        $fileContents = $fileContents -replace "\r\n", ""

        $fileContents | Select-String "<TransitionOfCare.*</TransitionOfCare>" -AllMatches |
            Foreach-Object {$_.Matches} |
            Foreach-Object {$transitionOfCare = $_.Value}

        if ($validateXml) {
            $tocFile = $PSScriptRoot + "\toc.xml" 
            New-Item $tocFile -type file -force -value $transitionOfCare | Out-Null
            $clinicalDocument = [xml]($fileContents)
            $XmlNamespace = @{ hl7 = 'urn:hl7-org:v3'; };
            $name = (Select-Xml -Xml $clinicalDocument -XPath '/hl7:ClinicalDocument/hl7:author/hl7:assignedAuthor/hl7:assignedAuthoringDevice/hl7:manufacturerModelName' -Namespace $XmlNamespace).ToString()
            $validation = Test-Xml -xmlfile $tocFile -schemafile $xmlSchemaLocation
            if ($validation) {
                Write-Message -message ("--" + $name.ToString().ToUpper() + " XML Validation--") -file $validationLogFile
                Write-Message -message ('File Name: "' + $file.Name + '"') -file $validationLogFile
                Write-Message -message ('File Date: ' + $fileCreateDate) -file $validationLogFile
                Write-Message -message ("Found ($($validation.count)) errors: $($validation)") -file $validationLogFile -error
                Write-Message -message (" ") -file $validationLogFile
            }
            Remove-Item $tocFile
        }

        Try {
            $tocDocument = [xml]($transitionOfCare)
        }
        Catch {
            Write-Message -message ($name.ToString().ToUpper()) -file $validationLogFile
            Write-Message -message ('File Name: "' + $file.Name + '"') -file $validationLogFile
            Write-Message -message ('File Date: ' + $fileCreateDate) -file $validationLogFile
            Write-Message -message ('Could not load Transition of Care canonical XML.') -file $validationLogFile -error
            Write-Message -message ($transitionOfCare) -file $validationLogFile -error
            Write-Message -message (" ") -file $validationLogFile

            $countModel[$fileCreateDate].ErrorFileCount += 1
            continue
        }

        $cmo = @{}
        $cmo.Name = (Select-Xml -Xml $tocDocument -XPath '/TransitionOfCare/Author/Name').ToString()
        $cmo.MedicaidId = (Select-Xml -Xml $tocDocument -XPath '/TransitionOfCare/Patient/MedicaidId').ToString()
        $transmissionType = (Select-Xml -Xml $tocDocument -XPath '/TransitionOfCare/@Type').ToString().ToString()
        $caseManagement = $tocDocument.SelectNodes('/TransitionOfCare/CaseManagement')
        $problems = $tocDocument.SelectNodes('/TransitionOfCare/CaseManagement/CarePlan/Problems/Problem')
        $pharmacyLockIn = $tocDocument.SelectNodes('/TransitionOfCare/PharmacyLockIn')
        $tocDocument = @{}

        if ([string]::IsNullOrEmpty($cmo.Name)) {
            Write-Message -message ($file.Name + " - Did not find an CMO.") -file $logFile
            continue
        }

        if (-Not $countModel[$fileCreateDate].Transmissions.ContainsKey($cmo.Name)) {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name] = @{}
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Name = $cmo.Name
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members = @{}
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].MedicaidIds = @()
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].NonConsenting = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Consenting = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].FinalToCs = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].NotificationToCs = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].CaseManagedOnly = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].PharmacyLockInOnly = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].CaseManagedAndPharmacyLockIn = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Empty = 0
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].NotificationToCs = 0
        }

        $careManaged = $false
        $lockIn = $false

        if ($caseManagement.Count -gt 0 -and $pharmacyLockIn.Count -gt 0) {
            $careManaged = $true
            $lockIn = $true
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].CaseManagedAndPharmacyLockIn += 1
        }
        elseif ($caseManagement.Count -lt 1 -and $pharmacyLockIn.Count -lt 1) {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Empty += 1
        }
        elseif ($caseManagement.Count -gt 0) {
            $careManaged = $true
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].CaseManagedOnly += 1
        }
        elseif ($pharmacyLockIn.Count -gt 0) {
            $lockIn = $true
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].PharmacyLockInOnly += 1
        }

        if ($caseManagement.Count -gt 0 -and $problems.Count -lt 1) {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].NonConsenting += 1
            $nonConsenting = $true
        }
        else {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Consenting += 1
            $nonConsenting = $false
        }

        if ($transmissionType.Equals("F")) {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].FinalToCs += 1
        }
        elseif ($transmissionType.Equals("N")) {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].NotificationToCs += 1
        }

        $countModel[$fileCreateDate].Transmissions[$cmo.Name].MedicaidIds += $cmo.MedicaidId
        if (-Not $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members.ContainsKey($cmo.MedicaidId)) {
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members[$cmo.MedicaidId] = @{}
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members[$cmo.MedicaidId].MedicaidId = $cmo.MedicaidId
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members[$cmo.MedicaidId].TransmissionType = $transmissionType
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members[$cmo.MedicaidId].CareManaged = $careManaged
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members[$cmo.MedicaidId].PharmacyLockIn = $lockIn
            $countModel[$fileCreateDate].Transmissions[$cmo.Name].Members[$cmo.MedicaidId].NonConsenting = $nonConsenting
        }

        Write-Message -message ($cmo.MedicaidId + ", " + $cmo.Name + ", Type: " + $transmissionType + ", Blank?: " + $nonConsenting) -file $logFile
    }
}

<#
.SYNOPSIS
Create the final count and xml validation sumary for all files at the given path.
.EXAMPLE
processSummary
#>
function processSummary {
    Write-Message -message (" ") -file $logFile
    Write-Message -message ("-----SUMMARY------------------------------") -file $logFile
    Write-Message -message (" ") -file $logFile

    foreach ($date in $countModel.Keys | Sort-Object) {
        Write-Message -message ("**************** TRANSMISSION DATE: " + $date) -file $logFile
        Write-Message -message (" ") -file $logFile
        $allCmoTotals = 0
        $allCmoNotfications = 0
        $allCmoFinals = 0
        $allCmoNonConsentingTotal = 0
        $allCmoCaseManagedOnly = 0
        $allCmoPharmacyLockInOnly = 0
        $allCmoCaseManagedAndPharmacyLockIn = 0
        $allCmoEmpty = 0

        foreach ($cmoName in $countModel[$date].Transmissions.Keys) {
            $cmoTitle = ("==" + $countModel[$date].Transmissions[$cmoName].Name.ToString().ToUpper() + " (Total: " + $countModel[$date].Transmissions[$cmoName].MedicaidIds.Count + ")==")
            Write-Message -message ($cmoTitle) -file $logFile
			
            Write-Message -message ("    Non-Consenting Data: " + $countModel[$date].Transmissions[$cmoName].NonConsenting) -file $logFile
            Write-Message -message ("    Consenting Data: " + $countModel[$date].Transmissions[$cmoName].Consenting) -file $logFile
            $allCmoNonConsentingTotal += $countModel[$date].Transmissions[$cmoName].NonConsenting
            $consentTotals = $countModel[$date].Transmissions[$cmoName].NonConsenting + $countModel[$date].Transmissions[$cmoName].Consenting
            Write-Message -message ("    -- Total: " + $consentTotals) -file $logFile
            Write-Message -message (" ") -file $logFile

            Write-Message -message ("    Finals: " + $countModel[$date].Transmissions[$cmoName].FinalToCs) -file $logFile
            Write-Message -message ("    Notifications: " + $countModel[$date].Transmissions[$cmoName].NotificationToCs) -file $logFile
            $allCmoNotfications += $countModel[$date].Transmissions[$cmoName].NotificationToCs
            $allCmoFinals += $countModel[$date].Transmissions[$cmoName].FinalToCs
            $typeTotals = $countModel[$date].Transmissions[$cmoName].FinalToCs + $countModel[$date].Transmissions[$cmoName].NotificationToCs
            Write-Message -message ("    -- Total: " + $typeTotals) -file $logFile
            Write-Message -message (" ") -file $logFile

            Write-Message -message ("    Case Managed Only: " + $countModel[$date].Transmissions[$cmoName].CaseManagedOnly) -file $logFile
            Write-Message -message ("    Pharmacy Lock-In Only: " + $countModel[$date].Transmissions[$cmoName].PharmacyLockInOnly) -file $logFile
            Write-Message -message ("    Both Case Managed and Pharmacy Lock-In: " + $countModel[$date].Transmissions[$cmoName].CaseManagedAndPharmacyLockIn) -file $logFile
            Write-Message -message ("    Empty: " + $countModel[$date].Transmissions[$cmoName].Empty) -file $logFile
            $allCmoCaseManagedOnly += $countModel[$date].Transmissions[$cmoName].CaseManagedOnly
            $allCmoPharmacyLockInOnly += $countModel[$date].Transmissions[$cmoName].PharmacyLockInOnly
            $allCmoCaseManagedAndPharmacyLockIn += $countModel[$date].Transmissions[$cmoName].CaseManagedAndPharmacyLockIn
            $allCmoEmpty += $countModel[$date].Transmissions[$cmoName].Empty
            $highlevelTotals = $countModel[$date].Transmissions[$cmoName].CaseManagedOnly + $countModel[$date].Transmissions[$cmoName].PharmacyLockInOnly + $countModel[$date].Transmissions[$cmoName].CaseManagedAndPharmacyLockIn + $countModel[$date].Transmissions[$cmoName].Empty
            Write-Message -message ("    -- Total: " + $highlevelTotals) -file $logFile
            Write-Message -message (" ") -file $logFile

            $cmoTitle = $cmoTitle -replace ".","="
            Write-Message -message ($cmoTitle) -file $logFile
            Write-Message -message (" ") -file $logFile

            $allCmoTotals += $countModel[$date].Transmissions[$cmoName].MedicaidIds.Count
        }

        Write-Message -message ("    All CMOs Non-Consenting Totals: " + $allCmoNonConsentingTotal) -file $logFile
        Write-Message -message ("    All CMOs Finals Totals: " + $allCmoFinals) -file $logFile
        Write-Message -message ("    All CMOs Notifications Totals: " + $allCmoNotfications) -file $logFile
        Write-Message -message ("    All CMOs Case Managed Only: " + $allCmoCaseManagedOnly) -file $logFile
        Write-Message -message ("    All CMOs Pharmacy Lock-In Only: " + $allCmoPharmacyLockInOnly) -file $logFile
        Write-Message -message ("    All CMOs Both Case Managed and Pharmacy Lock-In: " + $allCmoCaseManagedAndPharmacyLockIn) -file $logFile
        Write-Message -message ("    All CMOs Empty: " + $allCmoEmpty) -file $logFile
        Write-Message -message ("    All CMOs Erroring File Totals: " + $countModel[$date].ErrorFileCount) -file $logFile
        Write-Message -message ("    All CMOs Unique Member Totals: " + $allCmoTotals) -file $logFile
        Write-Message -message (" ") -file $logFile
        Write-Message -message ("**************** FILE COUNTS: " + $countModel[$date].FileCount) -file $logFile
        Write-Message -message (" ") -file $logFile
    }

    Write-Message -message ("------------------------------------------") -file $logFile
    Write-Message -message (" ") -file $logFile
}

<#
.SYNOPSIS
Take a given xml file and then validate it against a given xsd file.
.EXAMPLE
Test-Xml 'xmlFileName.xml' 'c:/xsd-location/xsdFileName.xsd'
#>
function Test-Xml {
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)] [string] $XmlFile,
        [Parameter(Mandatory = $true)] [string] $SchemaFile
    )

    [string[]]$Script:XmlValidationErrorLog = @()
    [scriptblock] $ValidationEventHandler = {
        $Script:XmlValidationErrorLog += $args[1].Exception.Message
    }

    $xml = New-Object System.Xml.XmlDocument
    $schemaReader = New-Object System.Xml.XmlTextReader $SchemaFile
    $schema = [System.Xml.Schema.XmlSchema]::Read($schemaReader, $ValidationEventHandler)
    $xml.Schemas.Add($schema) | Out-Null
    $xml.Load($XmlFile)
    $xml.Validate($ValidationEventHandler)

    return $Script:XmlValidationErrorLog
}

<#
.SYNOPSIS
Used to write message both the console and a text file.
.EXAMPLE
Write-Message -message "This is a message." -file ".\logFileName.txt"
#>
function Write-Message {
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)] [string] $message,
        [Parameter(Mandatory = $true)] [string] $file,
        [switch] $information,
        [switch] $warning,
        [switch] $error
    )

    if ($error) {
        $type = "ERROR:: "
        Write-Host ($type + $message) -foregroundcolor red
    }
    elseif ($warning) {
        $type = "WARNING:: "
        Write-Host ($type + $message) -foregroundcolor yellow
    }
    else {
        $type = ""
        Write-Host $message
    }

    if (-Not [string]::IsNullOrEmpty($file)) {
        Add-Content -path $file -value ($type + $message)
    }
}

Main

exit