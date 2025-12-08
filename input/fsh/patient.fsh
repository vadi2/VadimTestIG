// This is a simple example of a FSH file.
// This file can be renamed, and additional FSH files can be added.
// SUSHI will look for definitions in any file using the .fsh ending.

Profile: MyPatient
Parent: Patient
Description: "An example profile of the Patient resource."
* name 1..* MS

Mapping: FakeEHRMapping
Id: fake-ehr-mapping
Title: "Fake EHR Patient Mapping"
Source: MyPatient
Target: "FakeEHRPatient"
* name -> "FakeEHRPatient.fullName - but only in a certain scenario"
* name.given -> "FakeEHRPatient.firstName, use the Nth name for this"
* name.family -> "FakeEHRPatient.lastName"
* birthDate -> "FakeEHRPatient.dob"
* identifier -> "FakeEHRPatient.patientId"

Instance: PatientExample
InstanceOf: MyPatient
Description: "An example of a patient with a license to krill."
* name
  * given[0] = "James"
  * family = "Pond"
