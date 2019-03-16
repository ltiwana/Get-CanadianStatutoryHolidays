# Get-CanadianStatutoryHolidays 
Get Canadian Statutory Holidays using PowerShell in table or object form


## How to use it:
1. Import the module
 ```
 Import-Module Get-CanadianStatutoryHolidays.psm1
 ```

2. You can run following commands to get the holidays for specific year and province
The following command gets all the holidays of the 2017 year for Ontario province (ON)
```
Get-CanadianStatutoryHolidays -Year 2019 -Province ON
```

3. This command gets all the holidays of the 2019 year for Quebec province (QC)
```
Get-CanadianStatutoryHolidays -Year 2018 -Province QC
```

Note: make sure to use the 2 letter province abbreviation. Also, use -Verbose flag to see what's happening under the hood. I am using https://www.statutoryholidays.com to get holiday data and convert the HTML page into PowerShell objects.


## Example runs:</br>

![Photo1](/Screenshots/1.png)

![Photo2](/Screenshots/2.png)
