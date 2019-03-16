# Get-CanadianStatutoryHolidays
Get Canadian Statutory Holidays using PowerShell 


## How to use it:
1. Import the module
 ```
 Import-Module Get-CanadianStatutoryHolidays.psm1
 ```

2. You can run following commands to get the holidays for specific year and province
Following command will get all the holidays of 2017 yearn for Ontario province (ON)
```
Get-CanadianStatutoryHolidays -Year 2019 -Province ON
```

3. Following command will get all the holidays of 2019 yearn for Quebec province (QC)
```
Get-CanadianStatutoryHolidays -Year 2018 -Province QC
```

Note: make sure to use the 2 letter province abbreviation 
