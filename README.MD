# Passphrase Dice Generator
Passphrase creation tool using wordlist from [EFF](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases)

---

## Description
words generated from list using 5 randomised "dice rolls" to create 5 digit number between 11111 and 66666.
Each number is associated with a single word which is added to a passphrase including number and symbols

---

## Script Arguments
```
./PasswordDiceGen
    [-phraseLength <Int32>] 
    [-useNumbers <Bool>] 
    [-useSymbols <Bool>]
    [-case <String>]
    [-saveList <bool>]
    [-useSavedDictionary <string>]
```
- upper case and lower case are selected with `-case upper` and `-case lower`
- useSavedDictionary cannot be used in conjunction to saveList
- saved dictionary needs to be in json format 

## Script Defaults
- phraselength = 3 (3 is [minumum recomended safe value](https://weberblog.net/password-strengthentropy-characters-vs-words/#:~:text=However%2C%20to%20have%20at%20least,an%20entropy%20of%2070%20bits.))
- usenumbers = <span style="color:lightgreen">$true
- usesymbols = <span style="color:lightgreen">$true
- case = "default" (default is sentence case (e.g. ThisIsSentence), upper and lower cases supported)
- saveList = <span style="color:lightgreen">$false</span> (list of words not saved to device)
- useSavedDictionary = <span style="color:lightgreen">$null

### Example
` .\PasswordDiceGen.ps1 -phraseLength 5 -usenumbers $false -case upper -saveList $true `
Output: <br>
`KILOWATTVAGUELY(FRETFULTAPSYAHOO`