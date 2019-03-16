Function Get-CanadianStatutoryHolidays {
    
    Param
    (
        [Parameter(Position=0,Mandatory=$True)]
        [int]$Year,
        [Parameter(Position=1,Mandatory=$True)]
        [string]$Province
    )


    Write-Verbose "Building the Weblink for year $year"    
    $WebLink = "https://www.statutoryholidays.com/$Year.php"
    Write-Verbose "$WebLink"
    
    Write-Verbose "Getting webpage content"
    $Content = Invoke-WebRequest -Uri $WebLink -Verbose
    
    Write-Verbose "Getting tables stored on the webpage"
    $Tables = @($Content.ParsedHtml.getElementsByTagName('table'))
    
    Write-Verbose "Going through each table"
    $i = 0
    $Tables | foreach {
        
        Write-Verbose "Currently at Table $i"
        Write-Verbose "Looking for table that contains holidays information"
        if ($_.textcontent -match "boxing day") {
            
            Write-Verbose "Found Holidays table, table number: $i"
            Write-Verbose "Extracting the Holidays Table"
            $Table =  $Tables[$i]
            #break
        }
        $i++
    
    }
    
    Write-Verbose "Extracting Rows for the Holidays table"
    $Rows = @($Table.Rows)
    
    $Titles = @()

    Write-Verbose "Going through the each rows"

    foreach ($Row in $Rows) {
        
        $j++ 
        Write-Verbose "Currently at row number $j"
        $Cells = @($Row.Cells)

        #if ((!($Row.innerText -match "Not a stat holiday") -and ($Row.innerText -cmatch "ON" -or $Row.innerText -match "National")) -or ($Cells[0].tagName -eq "TH" -or ($Row.innerText -match "observance" -or $Row.innerText -match "date in $CurrentYear"))) {
        if (!($Row.innerText -match "Not a stat holiday") -and ($Row.innerText -cmatch $Province -or $Row.innerText -match "National") -and $Row.innerText -notmatch "[eE]xcept*.*$Province") {

            ## If we've found a table header, remember its titles
            
        
            #if ($Cells[0].tagName -eq "TH" -or ($Row.innerText -match "observance" -or $Row.innerText -match "date in $CurrentYear")) {

            #    Write-Verbose "Found Table Header"
            #    $Titles = @($Cells | % { ("" + $_.InnerText).Trim() })

            #    continue

            #}


            ## If we haven't found any table headers, make up names "P1", "P2", etc.

            if (-not $Titles) {

                Write-Verbose "Did not find any Table Headers."
                Write-Verbose "Making up table columns"
                #$Titles = @(1..($Cells.Count + 2) | % { "P$_" })
                $Titles = @("HolidayName","Dates","Region")

            }

            ## Now go through the cells in the the row. For each, try to find the

            ## title that represents that column and create a hashtable mapping those

            ## titles to content

            $ResultObject = [Ordered] @{}

            for ($Counter = 0; $Counter -lt $Cells.Count; $Counter++) {

                Write-Verbose "Storing Cells number $Counter in row number: $j"
                $Title = $Titles[$Counter]

                if (-not $Title) { continue }

                if ($Counter -eq "1") { 
                    $DateCell = Get-Date "$((($Cells[$Counter].innertext).trim() -split ",")[0]), $Year" -UFormat  "%A, %B %d, %Y" 
                    $ResultObject[$Title] = ("" + $DateCell)
                }
                else {
                    $ResultObject[$Title] = ("" + $Cells[$Counter].InnerText).Trim()
                }

            }

            ## And finally cast that hashtable to a PSCustomObject

            [PSCustomObject] $ResultObject
        }
        else {
            Write-Verbose "Skipping row number $j. Either it's `"Not a stat holiday`" or not a holiday in $Province"
            Write-Verbose "Skipped Row $($Row.innertext)"
        }
        
    }
   
}