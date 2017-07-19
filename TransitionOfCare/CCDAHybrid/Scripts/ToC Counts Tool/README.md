# Transition of Care Count Tool

This tool is used to get different counts based off of ToC transmission files sitting in a folder. In order to run the script download the [Transition_Of_Care_File_Counts.ps1](https://github.com/HealthcareStandards/HealthcareStandards/blob/master/TransitionOfCare/CCDAHybrid/Scripts/ToC%20Counts%20Tool/Transition_Of_Care_File_Counts.ps1) powershell script and run the below command. This will create a log file in the same folder as the script and also log message to the console.

`.\Transition_Of_Care_File_Counts.ps1 -toclocation "c:/xml-location/tocFileName.xml" -logFile "log_DATE.txt" -validatexml -xmlschemalocation "c:/xsd-location/xsdFileName.xsd" -validationlogfile "validation_log_DATE.txt"`

## Script Parameters

- `tocLocation`
	- Parameter allows you to change where the script looks for the Transition of Care files. By default this is set to the same directory of the script.
- `logFile`
	- Parameter allows you to name a path and file name for a text file to hold a copy of the messages sent to the console. By default the script will not create a log file.
- `validatexml`
	- Parameter switch that signifies you want to also validate the Transition of Care transmission against an xml schema.
	- Requires that you also use the `xmlschemalocation` parameter.
- `xmlschemalocation`
	- Parameter for the location of the schema you want to use when validating Transition of Care xml.
	- This is ignored if you do not use the `validatexml` parameter.
- `validationlogfile`
	- Parameter to make the script write all xml validation error to a separate file location.
	- This is ignored if you do not use the `validatexml` parameter.

## Term Description

- **Non-Consent:** Case Management element and required elements have been populated but Care Plan HAS NO Problems.
- **Consent:** Case Management element and required elements have been populated but Care Plan HAS Problems.
- **Case Managed:** Case Management element and required elements have been populated.
- **Pharmacy Lock-In:** Pharmacy Lock-In element and required elements have been populated.
- **Foster Care:** Foster Care element elements have been populated.
- **Empty:** No Case Management, Pharmacy Lock-In, or Foster Care elements have been populated.
