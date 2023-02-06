#Dice-Generate Passphrase with number and symbols using EFF list
#wordlist from: https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases

#flag values
param(
    [int32]$phraseLength = 3,
    [bool]$useNumbers = $true,
    [bool]$useSymbols = $true,
    [string]$case = "sentence",
    [bool]$saveList = $false,
    [string]$useSavedDictionary = $null
)

$global:number = $useNumbers
$global:symbol = $useSymbols

$wc = new-object system.net.webclient
$wordlist = $wc.DownloadString('https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt')
$wc.Dispose()

$wordlist = $wordlist -split '\s+'

#format words to number: word as object
$formattedwords = [System.Collections.Hashtable]@{}
for ($word = 0; $word -lt $wordlist.length - 1; $word += 2) {
    # $format = [PSObject]@{$wordlist[$word] = $wordlist[$word + 1] }

    # $formattedwords.Add($format)
    $formattedwords[$wordlist[$word]] = $wordlist[$word + 1]
}
if ($saveList) {
    $sw = new-object system.IO.StreamWriter("$pwd\list.json")
    $sw.write((Convertto-Json -inputobject $formattedwords))
    $sw.close()
}
if($useSavedDictionary){
    $formattedwords = Get-Content -Path $useSavedDictionary | ConvertFrom-Json
}

function addSpecial($passphrase) {
    switch (Get-random -Maximum 2) {
        0 { 
            if ($global:number) {
                $val = 10..99 | Get-Random
                $passphrase += $val 
                $global:number = $false
            }
        }
        1 { 
            if ($global:symbol) {
                $symbols = @('!', '@', '#', '$', '%', '&', '*', '_', '-', '+', '=', '\', '(', ')', '{', '}', '[', ']', ':', ';', '<', '>', '?', '/')
                $passphrase += $symbols | Get-Random
                $global:symbol = $false
            }
        }
        Default {}
    }
    return $passphrase
}

$passphrase = $null

for ($x = 0; $x -lt $phraseLength; $x++) {
    
    #TODO get dicerolls to make value 11111-66666
    $result = $null
    for ($i = 0; $i -lt 5; $i++) {
        $roll = "1", "2", "3", "4", "5", "6" | Get-Random
        $result += $roll
    }
    #get word from word list
    $word = $formattedwords.$result
    switch ($case.ToLower()) {
        "lower" {}
        "upper" {
            $word = $word.toupper()

        }
        Default {
            $word = $word.substring(0, 1).toupper() + $word.substring(1)
        }
    }
    #capitalise word
    $passphrase += $word
    #add numbers or symbols
    $passphrase = addSpecial $passphrase
}

if ($global:number) {
    $val = 10..99 | Get-Random
    $passphrase += $val 
}
if ($global:symbol) {
    $symbols = @('!', '@', '#', '$', '%', '&', '*', '_', '-', '+', '=', '\', '(', ')', '{', '}', '[', ']', ':', ';', '<', '>', '?', '/')
    $passphrase += $symbols | Get-Random
}

Write-Host $passphrase
Read-Host