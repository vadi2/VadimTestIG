// Repro: a QuestionnaireResponse answer coding bound (answerValueSet) to a SNOMED
// ValueSet that requires a Swedish supplement via valueset-supplement. The validator
// validates the coding twice: once against the ValueSet, where tx.fhir.org applies the
// supplement and accepts the Swedish display, and once against bare SNOMED CT with no
// ValueSet, where the supplement is dropped. The second check decides the outcome:
// - sv display: Wrong Display Name error, which ignoreWarnings cannot suppress
// - en display: "no valid display names for 'sv'" warning, although the supplement has one
// - no display: the only shape that validates clean

CodeSystem: SnomedSwedishSupplementCS
Id: snomed-sv-supplement-cs
Title: "SNOMED CT Swedish Supplement"
Description: "Swedish displays for two SNOMED CT concepts"
* ^url = "https://vadimperetok.in/fhir/CodeSystem/snomed-sv-supplement-cs"
* ^version = "1.0.0"
* ^status = #active
* ^experimental = true
* ^content = #supplement
* ^supplements = "http://snomed.info/sct"
* #14189004
  * ^designation[0].language = #sv
  * ^designation[=].value = "Mässling"
* #6736007
  * ^designation[0].language = #sv
  * ^designation[=].value = "Måttlig"

ValueSet: SnomedSwedishVS
Id: snomed-sv-vs
Title: "SNOMED CT Swedish ValueSet"
Description: "Two SNOMED CT concepts, with the Swedish supplement required"
* ^url = "https://vadimperetok.in/fhir/ValueSet/snomed-sv-vs"
* ^status = #active
* ^experimental = true
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/valueset-supplement"
* ^extension[=].valueCanonical = Canonical(SnomedSwedishSupplementCS)
* $sct#14189004 "Measles"
* $sct#6736007 "Moderate severity"

Instance: snomed-sv-questionnaire
InstanceOf: Questionnaire
Usage: #example
Title: "Swedish SNOMED Questionnaire"
Description: "One coded item bound to the supplemented ValueSet"
* url = "https://vadimperetok.in/fhir/Questionnaire/snomed-sv-questionnaire"
* language = #sv
* status = #active
* item[0].linkId = "finding"
* item[0].text = "Fynd"
* item[0].type = #choice
* item[0].answerValueSet = Canonical(SnomedSwedishVS)
* item[1].linkId = "severity"
* item[1].text = "Svårighetsgrad"
* item[1].type = #choice
* item[1].answerValueSet = Canonical(SnomedSwedishVS)

Instance: qr-sv-display
InstanceOf: QuestionnaireResponse
Usage: #example
Description: "Swedish displays from the supplement - errors on the bare SNOMED display check"
* language = #sv
* questionnaire = Canonical(snomed-sv-questionnaire)
* status = #completed
* item[0].linkId = "finding"
* item[0].answer[0].valueCoding = $sct#14189004 "Mässling"
* item[1].linkId = "severity"
* item[1].answer[0].valueCoding = $sct#6736007 "Måttlig"

Instance: qr-en-display
InstanceOf: QuestionnaireResponse
Usage: #example
Description: "English SNOMED displays - warns that no Swedish display exists"
* language = #sv
* questionnaire = Canonical(snomed-sv-questionnaire)
* status = #completed
* item[0].linkId = "finding"
* item[0].answer[0].valueCoding = $sct#14189004 "Measles"
* item[1].linkId = "severity"
* item[1].answer[0].valueCoding = $sct#6736007 "Moderate severity"

Instance: qr-no-display
InstanceOf: QuestionnaireResponse
Usage: #example
Description: "No displays - the only shape that validates clean"
* language = #sv
* questionnaire = Canonical(snomed-sv-questionnaire)
* status = #completed
* item[0].linkId = "finding"
* item[0].answer[0].valueCoding = $sct#14189004
* item[1].linkId = "severity"
* item[1].answer[0].valueCoding = $sct#6736007
