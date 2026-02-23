// // This is a minimal example of a Condition profile using SNOMED CT valueset binding.
// Profile: MyCondition
// Parent: Condition
// Description: "An example profile of the Condition resource with SNOMED CT binding for code."
// * code from $sct-vs (required)

// Instance: ConditionExample
// InstanceOf: MyCondition
// Description: "An example of a condition with a SNOMED CT code."
// * code = $sct#38341003 "Hypertensive disorder"
// * subject = Reference(PatientExample)
