// uz.dhp.core#0.8.0 iso-3166-2-vs includes urn:iso:std:iso:3166 and requires a supplement to it.
// THO 7 no longer ships a content = not-present stub for that code system, so it is only available
// on the terminology server. The example uses a valid code, but the publisher reports
// "Required supplement not found".

Profile: CountryObservation
Parent: Observation
Description: "Observation whose value is a country from uz.dhp.core iso-3166-2-vs"
* value[x] only CodeableConcept
* valueCodeableConcept from https://terminology.dhp.uz/fhir/core/ValueSet/iso-3166-2-vs (required)

Instance: CountryObservationExample
InstanceOf: CountryObservation
Description: "Valid ISO 3166 code that fails validation"
* status = #final
* code.text = "Country of birth"
* valueCodeableConcept = urn:iso:std:iso:3166#UZ "Uzbekistan"
