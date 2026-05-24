// Minimal reproducer for IG Publisher ConceptMap target-VS validation bug.
//
// Publisher: FHIR IG Publisher 2.2.7 (Git# 46f94953d4dc), built 2026-04-23
// FHIR version: R5 (5.0.0)
//
// Symptom: every target code emits
//   ERROR CONCEPTMAP_GROUP_TARGET_CODE_INVALID_VS
//   "The target code 'X' is not valid in the value set <TargetVS>"
//
// Even though the same codes resolve OK at tx.fhir.org. Querying tx.fhir.org's
// $validate-code with the same code and the same VS (sent inline) returns
//   {"name":"result","valueBoolean":true}
//   diagnostics: 'Code "X" found in http://hl7.org/fhir/sid/cvx|20250715'
//
// So the publisher's internal expander used for ConceptMap target validation
// disagrees with the tx server. We've reproduced this with three TargetVS shapes:
//   (1) `* include codes from system $cvx` (broad)
//   (2) Explicit `* $cvx#01 "..."` concept list
//   (3) Filter `* include codes from system $cvx where vaccine-status = #Active`
// All three produce the same 1-error-per-target-element pattern.

CodeSystem: SourceCS
Id: source-cs
Title: "Source CodeSystem"
Description: "Toy local source codes for the ConceptMap"
* ^url = "https://vadimperetok.in/fhir/CodeSystem/source-cs"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* #A "Code A"
* #B "Code B"
* #C "Code C"

ValueSet: SourceVS
Id: source-vs
Title: "Source ValueSet"
Description: "All codes from SourceCS"
* ^url = "https://vadimperetok.in/fhir/ValueSet/source-vs"
* ^status = #active
* include codes from system SourceCS

ValueSet: TargetVS
Id: target-vs
Title: "Target ValueSet - explicit CVX concepts"
Description: "Three specific CVX codes used as targets in the ConceptMap below."
* ^url = "https://vadimperetok.in/fhir/ValueSet/target-vs"
* ^status = #active
// Each include explicitly enumerates the concept. tx.fhir.org $expand of this VS
// returns these 3 codes (verifiable via qa-tx.html in the build output) and
// $validate-code returns result:true for each. The IG publisher's internal
// ConceptMap-target check, however, treats the VS as if it contained no codes.
* $cvx#01 "diphtheria, tetanus toxoids and pertussis vaccine"
* $cvx#19 "Bacillus Calmette-Guerin vaccine"
* $cvx#113 "tetanus and diphtheria toxoids, adsorbed, preservative free, for adult use (5 Lf of tetanus toxoid and 2 Lf of diphtheria toxoid)"

Instance: repro-cm
InstanceOf: ConceptMap
Usage: #definition
Title: "Reproducer ConceptMap"
Description: "Maps SourceCS to CVX, with targetScopeCanonical=TargetVS. Each target code IS explicitly listed in TargetVS, yet the publisher reports each as not valid in the VS."
* url = "https://vadimperetok.in/fhir/ConceptMap/repro-cm"
* name = "ReproCM"
* status = #active
* experimental = false
* sourceScopeCanonical = Canonical(SourceVS)
* targetScopeCanonical = Canonical(TargetVS)
* group[+].source = Canonical(SourceCS)
* group[=].target = $cvx
* group[=].element[+].code = #A
* group[=].element[=].target[+].code = #01
* group[=].element[=].target[=].display = "diphtheria, tetanus toxoids and pertussis vaccine"
* group[=].element[=].target[=].relationship = #related-to
* group[=].element[+].code = #B
* group[=].element[=].target[+].code = #19
* group[=].element[=].target[=].display = "Bacillus Calmette-Guerin vaccine"
* group[=].element[=].target[=].relationship = #related-to
* group[=].element[+].code = #C
* group[=].element[=].target[+].code = #113
* group[=].element[=].target[=].display = "tetanus and diphtheria toxoids, adsorbed, preservative free, for adult use (5 Lf of tetanus toxoid and 2 Lf of diphtheria toxoid)"
* group[=].element[=].target[=].relationship = #related-to
