// Profile 1: Uses CombinedLabCodesVS (specific LOINC codes + all custom codes)
Profile: LabObservationProfile1
Parent: Observation
Id: lab-observation-profile-1
Title: "Lab Observation Profile 1"
Description: "Observation profile using ValueSet with specific LOINC codes + custom CodeSystem"
* status MS
* code 1..1 MS
* code from CombinedLabCodesVS (required)
* value[x] only Quantity
* valueQuantity MS

// Profile 2: Uses CombinedLabCodesVS2 (all LOINC + all custom codes)
Profile: LabObservationProfile2
Parent: Observation
Id: lab-observation-profile-2
Title: "Lab Observation Profile 2"
Description: "Observation profile using ValueSet with all LOINC codes + custom CodeSystem"
* status MS
* code 1..1 MS
* code from CombinedLabCodesVS2 (required)
* value[x] only Quantity
* valueQuantity MS
