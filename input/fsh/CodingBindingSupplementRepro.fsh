// Same ValueSet bound outside a Questionnaire: the bug follows the Coding datatype.
// - CodeableConcept bound to SnomedSwedishVS with a Swedish display: clean
// - Coding bound to SnomedSwedishVS with a Swedish display: Wrong Display Name error

Profile: SvFindingObservation
Parent: Observation
Id: sv-finding-observation
Title: "Swedish Finding Observation"
Description: "Observation whose value is bound (required) to the supplemented ValueSet"
* value[x] only CodeableConcept
* valueCodeableConcept from SnomedSwedishVS (required)

Instance: obs-sv-display
InstanceOf: SvFindingObservation
Usage: #example
Description: "Bound CodeableConcept with a Swedish display - validates clean"
* language = #sv
* status = #final
* code = $sct#404684003 "Clinical finding"
* valueCodeableConcept = $sct#14189004 "Mässling"

Extension: SvFindingCoding
Id: sv-finding-coding
Title: "Swedish Finding Coding"
Description: "Coding bound (required) to the supplemented ValueSet"
* ^context[0].type = #element
* ^context[0].expression = "Observation"
* value[x] only Coding
* valueCoding from SnomedSwedishVS (required)

Instance: obs-ext-sv-display
InstanceOf: Observation
Usage: #example
Description: "Bound Coding extension with a Swedish display - Wrong Display Name error"
* language = #sv
* status = #final
* code = $sct#404684003
* extension[sv-finding-coding].valueCoding = $sct#14189004 "Mässling"
