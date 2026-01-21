// Profile using CombinedLabCodesVS (all LOINC + all custom codes)
Profile: LabObservationProfile
Parent: Observation
Id: lab-observation-profile
Title: "Lab Observation Profile"
Description: "Observation profile using ValueSet with all LOINC codes + custom CodeSystem"
* status MS
* code 1..1 MS
* code from CombinedLabCodesVS (required)
* value[x] only Quantity
* valueQuantity MS
