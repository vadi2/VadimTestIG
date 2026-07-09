// Repro: a CodeSystem supplement whose `supplements` canonical is version-pinned
// (url|version) is never matched during ValueSet expansion - any ValueSet that
// requires it via the valueset-supplement extension fails to expand with
// "Required supplement not found", even when the pinned version is correct.
// The identical unpinned twin works fine.

CodeSystem: SupplementReproBaseCS
Id: supplement-repro-base-cs
Title: "Supplement Repro Base CodeSystem"
Description: "Base code system for the pinned-supplement repro"
* ^url = "https://vadimperetok.in/fhir/CodeSystem/supplement-repro-base-cs"
* ^version = "1.0.0"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #a "Apple"
* #b "Banana"

CodeSystem: PinnedSupplementCS
Id: pinned-supplement-cs
Title: "Pinned Supplement"
Description: "Supplement whose supplements canonical is version-pinned (url|1.0.0, matching the base's actual version)"
* ^url = "https://vadimperetok.in/fhir/CodeSystem/pinned-supplement-cs"
* ^version = "1.0.0"
* ^status = #active
* ^experimental = true
* ^content = #supplement
* ^supplements = "https://vadimperetok.in/fhir/CodeSystem/supplement-repro-base-cs|1.0.0"
* #a
  * ^designation[0].language = #nl
  * ^designation[=].value = "Appel"

CodeSystem: UnpinnedSupplementCS
Id: unpinned-supplement-cs
Title: "Unpinned Supplement"
Description: "Identical supplement, but the supplements canonical carries no version pin"
* ^url = "https://vadimperetok.in/fhir/CodeSystem/unpinned-supplement-cs"
* ^version = "1.0.0"
* ^status = #active
* ^experimental = true
* ^content = #supplement
* ^supplements = "https://vadimperetok.in/fhir/CodeSystem/supplement-repro-base-cs"
* #a
  * ^designation[0].language = #nl
  * ^designation[=].value = "Appel"

ValueSet: PinnedSupplementVS
Id: pinned-supplement-vs
Title: "Pinned Supplement ValueSet"
Description: "Requires the version-pinned supplement - expansion fails with 'Required supplement not found'"
* ^url = "https://vadimperetok.in/fhir/ValueSet/pinned-supplement-vs"
* ^status = #active
* ^experimental = true
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/valueset-supplement"
* ^extension[=].valueCanonical = Canonical(PinnedSupplementCS)
* include codes from system SupplementReproBaseCS

ValueSet: UnpinnedSupplementVS
Id: unpinned-supplement-vs
Title: "Unpinned Supplement ValueSet"
Description: "Requires the unpinned supplement - expands fine"
* ^url = "https://vadimperetok.in/fhir/ValueSet/unpinned-supplement-vs"
* ^status = #active
* ^experimental = true
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/valueset-supplement"
* ^extension[=].valueCanonical = Canonical(UnpinnedSupplementCS)
* include codes from system SupplementReproBaseCS
