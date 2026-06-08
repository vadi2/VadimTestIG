// Minimal reproducer: a pattern[x] (or fixed[x]) assigned to a CHOICE element
// (value[x] and friends) is not rendered in the IG Publisher's profile
// (Snapshot / Differential / Key-Elements) table. The "Required Pattern: At least
// the following" header prints, but its body is empty - the fixed coding is never
// painted. The constraint IS present in the generated snapshot and IS enforced
// during validation; only the human-readable table drops it.
//
// Publisher:    FHIR IG Publisher 2.2.8 (Git# e39e13a432d0), built 2026-05-23
// FHIR version: R5 (5.0.0)
//
// The same construction - `value[x] only CodeableConcept` + a patternCodeableConcept -
// fails at EVERY position tested, while the identical pattern on a non-choice element
// renders fine. So the trigger is the choice ([x]) element, not the datatype or position:
//
//   ELEMENT                                           pattern body rendered?
//   ----------------------------------------------    ----------------------
//   Observation.code               (CodeableConcept, non-choice)   YES   <- control
//   UsageContext.code              (Coding, non-choice)            YES   <- control ("focus")
//   Observation.value[x]           (choice, resource root)         NO    <- bug
//   Observation.component.value[x] (choice, backbone element)      NO    <- bug
//   Extension.value[x]             (choice, in an extension)       NO    <- bug
//   UsageContext.value[x]          (choice, in a complex datatype) NO    <- bug
//
// The pattern is shown by the table as "Required Pattern: At least the following"
// followed immediately by the next sibling element (an empty body).
//
// PROOF the constraint is real (not just missing): every generated
//   fsh-generated/resources/StructureDefinition-*-repro.json
// carries patternCodeableConcept {repro-cs#foo} on its value[x] element, and the
// example instance below (value = repro-cs#foo) validates against it. Only the HTML
// table omits the value.

CodeSystem: ReproCS
Id: repro-cs
Title: "Repro CodeSystem"
Description: "Local code so the reproducer needs no terminology server."
* ^url = "https://vadimperetok.in/fhir/CodeSystem/repro-cs"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* #foo "Foo display"


// code (non-choice) renders; value[x] at the resource root and component.value[x]
// in a backbone element both fail to render their pattern.
Profile: ObservationPatternRepro
Parent: Observation
Id: observation-pattern-repro
Title: "Observation Pattern Repro"
Description: "code (CodeableConcept, non-choice) renders its pattern; value[x] (resource-root choice) and component.value[x] (backbone choice) do not."
* code = ReproCS#foo "Foo display"
* value[x] only CodeableConcept
* valueCodeableConcept = ReproCS#foo "Foo display"
* component.value[x] only CodeableConcept
* component.valueCodeableConcept = ReproCS#foo "Foo display"


// value[x] inside the UsageContext complex datatype - the failing case.
Profile: PlanDefinitionUseContextPatternRepro
Parent: PlanDefinition
Id: plandefinition-usecontext-pattern-repro
Title: "PlanDefinition useContext Pattern Repro"
Description: "useContext.code (Coding, non-choice) renders 'focus'; useContext.value[x] (CodeableConcept choice, nested in UsageContext) does NOT render its pattern."
* useContext.code = $uctype#focus
* useContext.value[x] only CodeableConcept
* useContext.valueCodeableConcept = ReproCS#foo "Foo display"


// value[x] inside an Extension - the most common real-world position.
Extension: ValuePatternExt
Id: value-pattern-ext
Title: "Value Pattern Extension"
Description: "Pins the extension value[x] to a CodeableConcept pattern; check whether it renders on the extension page."
* value[x] only CodeableConcept
* valueCodeableConcept = ReproCS#foo "Foo display"


// A valid instance, to show the value[x] pattern is enforced (not merely decorative):
// value matches the pinned pattern, so it validates.
Instance: repro-observation
InstanceOf: ObservationPatternRepro
Usage: #example
Title: "Repro Observation"
Description: "Satisfies the pinned code and value[x] patterns above."
* status = #final
* code = ReproCS#foo "Foo display"
* valueCodeableConcept = ReproCS#foo "Foo display"
