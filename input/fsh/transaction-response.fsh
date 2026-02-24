Instance: example-transaction-response
InstanceOf: Bundle
Usage: #example
Title: "Example Transaction Response"
Description: "Example of a successful transaction response where all resources were created"
* type = #transaction-response

* entry[0].response.status = "201 Created"
* entry[=].response.location = "Patient/PatientExample/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

* entry[+].response.status = "201 Created"
* entry[=].response.location = "Condition/ConditionExample/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

