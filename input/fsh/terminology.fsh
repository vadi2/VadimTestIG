// Custom CodeSystem with local laboratory observation codes
CodeSystem: LocalLabCodesCS
Id: local-lab-codes-cs
Title: "Local Laboratory Codes"
Description: "Local laboratory observation codes not found in LOINC"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true
* #LOCAL001 "Local Test 1" "A local laboratory test not in LOINC"
* #LOCAL002 "Local Test 2" "Another local laboratory test"
* #LOCAL003 "Regional Biomarker" "A region-specific biomarker test"

// ValueSet combining ALL of LOINC with custom CodeSystem
// This mirrors the pattern from digital-health-ig
ValueSet: CombinedLabCodesVS
Id: combined-lab-codes-vs
Title: "Combined Laboratory Codes"
Description: "Laboratory codes from LOINC and local CodeSystem"
* ^status = #active
* ^experimental = true

// Include ALL codes from LOINC
* include codes from system $loinc
// Include all codes from our custom CodeSystem
* include codes from system LocalLabCodesCS
