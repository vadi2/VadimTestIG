// Custom CodeSystem with local laboratory observation codes
CodeSystem: LocalLabCodesCS
Id: local-lab-codes-cs
Title: "Local Laboratory Codes"
Description: "Local laboratory observation codes not found in LOINC"
* ^url = "http://example.org/fhir/CodeSystem/local-lab-codes-cs"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true
* #LOCAL001 "Local Test 1" "A local laboratory test not in LOINC"
* #LOCAL002 "Local Test 2" "Another local laboratory test"
* #LOCAL003 "Regional Biomarker" "A region-specific biomarker test"

// ValueSet combining LOINC with custom CodeSystem
// Pattern 1: Include all codes from custom CS + specific LOINC codes
ValueSet: CombinedLabCodesVS
Id: combined-lab-codes-vs
Title: "Combined Laboratory Codes"
Description: "Laboratory codes from LOINC and local CodeSystem"
* ^url = "http://example.org/fhir/ValueSet/combined-lab-codes-vs"
* ^status = #active
* ^experimental = true

// Include all codes from our custom CodeSystem
* include codes from system LocalLabCodesCS

// Include specific LOINC codes for common lab tests
* $loinc#2339-0 "Glucose [Mass/volume] in Blood"
* $loinc#2345-7 "Glucose [Mass/volume] in Serum or Plasma"
* $loinc#718-7 "Hemoglobin [Mass/volume] in Blood"

// Pattern 2: using "include codes from system" for both
// This mirrors the pattern from digital-health-ig more closely
ValueSet: CombinedLabCodesVS2
Id: combined-lab-codes-vs-2
Title: "Combined Laboratory Codes (Pattern 2)"
Description: "Laboratory codes using include codes from system for both"
* ^url = "http://example.org/fhir/ValueSet/combined-lab-codes-vs-2"
* ^status = #active
* ^experimental = true

// Include ALL codes from LOINC (this is intensive but matches the pattern)
* include codes from system $loinc
// Include all codes from our custom CodeSystem
* include codes from system LocalLabCodesCS
