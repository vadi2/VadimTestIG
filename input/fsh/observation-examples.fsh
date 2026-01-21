// Example 1: Using a LOINC code from the ValueSet
Instance: LabObservation-LOINC
InstanceOf: LabObservationProfile
Title: "Lab Observation - LOINC Code"
Description: "Example using a LOINC code (Glucose) from CombinedLabCodesVS"
Usage: #example
* status = #final
* code = $loinc#2339-0 "Glucose [Mass/volume] in Blood"
* valueQuantity = 95 'mg/dL' "mg/dL"

// Example 2: Using a custom code from the local CodeSystem
Instance: LabObservation-Custom
InstanceOf: LabObservationProfile
Title: "Lab Observation - Custom Code"
Description: "Example using a custom code (LOCAL001) from CombinedLabCodesVS"
Usage: #example
* status = #final
* code = LocalLabCodesCS#LOCAL001 "Local Test 1"
* valueQuantity = 42 'mg/dL' "mg/dL"
