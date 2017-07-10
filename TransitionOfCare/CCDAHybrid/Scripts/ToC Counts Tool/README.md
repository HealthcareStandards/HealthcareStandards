# Transition of Care Count Tool

This tool is used to get different counts based off of ToC transmission files sitting in a folder. In order to run the script copy the [Transition_Of_Care_File_Counts.ps1](https://github.com/HealthcareStandards/HealthcareStandards/blob/master/TransitionOfCare/CCDAHybrid/Scripts/ToC%20Counts%20Tool/Transition_Of_Care_File_Counts.ps1) powershell script and then run the below command. This will create a log file in the same folder as the script and also log message to the console.

'.\Transition_Of_Care_File_Counts.ps1 -logFile "log_DATE.txt"'

## Script Parameters

- 'tocLocation'
	- Parameter allows you to change where the script looks for the Transition of Care files. By default this is set to the same directory of the script.
- 'logFile'
	- Parameter allows you to name a path and file name for a text file log of the messages sent to the console. By default the script will not create a log file.
