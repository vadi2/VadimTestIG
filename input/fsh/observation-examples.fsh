// ============================================================
// Examples for Profile 1 (CombinedLabCodesVS - specific LOINC + custom)
// ============================================================

// Example 1a: Using a LOINC code from the ValueSet
Instance: LabObservation1-LOINC
InstanceOf: LabObservationProfile1
Title: "Lab Observation 1 - LOINC Code"
Description: "Example using a LOINC code (Glucose) from CombinedLabCodesVS"
Usage: #example
* status = #final
* code = $loinc#2339-0 "Glucose [Mass/volume] in Blood"
* valueQuantity = 95 'mg/dL' "mg/dL"

// Example 1b: Using a custom code from the local CodeSystem
Instance: LabObservation1-Custom
InstanceOf: LabObservationProfile1
Title: "Lab Observation 1 - Custom Code"
Description: "Example using a custom code (LOCAL001) from CombinedLabCodesVS"
Usage: #example
* status = #final
* code = LocalLabCodesCS#LOCAL001 "Local Test 1"
* valueQuantity = 42 'mg/dL' "mg/dL"

// ============================================================
// Examples for Profile 2 (CombinedLabCodesVS2 - all LOINC + custom)
// ============================================================

// Example 2a: Using a LOINC code
Instance: LabObservation2-LOINC
InstanceOf: LabObservationProfile2
Title: "Lab Observation 2 - LOINC Code"
Description: "Example using a LOINC code (Hemoglobin) from CombinedLabCodesVS2"
Usage: #example
* status = #final
* code = $loinc#718-7 "Hemoglobin [Mass/volume] in Blood"
* valueQuantity = 14.5 'g/dL' "g/dL"

// Example 2b: Using a custom code from the local CodeSystem
Instance: LabObservation2-Custom
InstanceOf: LabObservationProfile2
Title: "Lab Observation 2 - Custom Code"
Description: "Example using a custom code (LOCAL002) from CombinedLabCodesVS2"
Usage: #example
* status = #final
* code = LocalLabCodesCS#LOCAL002 "Local Test 2"
* valueQuantity = 123 'U/L' "U/L"
