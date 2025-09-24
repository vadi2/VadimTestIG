Alias: $usage-context-type = http://terminology.hl7.org/CodeSystem/usage-context-type
Alias: $variant-state = http://terminology.hl7.org/CodeSystem/variant-state
Alias: $restful-security-service = http://hl7.org/fhir/restful-security-service
Alias: $message-transport = http://hl7.org/fhir/message-transport

Instance: example
InstanceOf: CapabilityStatement
Usage: #definition
* version = "20130510"
* name = "ACMEEHR"
* title = "ACME EHR capability statement"
* status = #draft
* experimental = true
* date = "2012-01-04"
* publisher = "ACME Corporation"
* contact
  * name = "System Administrator"
  * telecom
    * system = #email
    * value = "wile@acme.org"
* description = "This is the FHIR capability statement for the main EHR at ACME for the private interface - it does not describe the public interface"
* useContext
  * code = $usage-context-type#focus
  * valueCodeableConcept = $variant-state#positive
* jurisdiction = urn:iso:std:iso:3166#US "United States of America (the)"
* purpose = "Main EHR capability statement, published for contracting and operational support"
* copyright = "Copyright © Acme Healthcare and GoodCorp EHR Systems"
* kind = #instance
* software
  * name = "EHR"
  * version = "0.00.020.2134"
  * releaseDate = "2012-01-04"
* implementation
  * description = "main EHR at ACME"
  * url = "https://playground.medcore.uz/fhir"
* fhirVersion = #5.0.0
* format[0] = #xml
* format[+] = #json
* patchFormat[0] = #application/xml-patch+xml
* patchFormat[+] = #application/json-patch+json
* acceptLanguage[0] = #en
* acceptLanguage[+] = #es
* implementationGuide = "http://example.org/fhir/us/lab"
* rest
  * mode = #server
  * documentation = "Main FHIR endpoint for acem health"
  * security
    * cors = true
    * service = $restful-security-service#SMART-on-FHIR
    * description = "See Smart on FHIR documentation"
  * resource
    * type = #Patient
    * documentation = "This server does not let the clients create identities."
    * interaction[0].code = #read
    * interaction[+]
      * code = #vread
      * documentation = "Only supported for patient records since 12-Dec 2012"
    * interaction[+].code = #update
    * interaction[+].code = #history-instance
    * interaction[+].code = #create
    * interaction[+].code = #history-type
    * versioning = #versioned-update
    * readHistory = true
    * updateCreate = false
    * conditionalCreate = true
    * conditionalRead = #full-support
    * conditionalUpdate = false
    * conditionalPatch = false
    * conditionalDelete = #not-supported
    * searchInclude = "Patient:organization"
    * searchRevInclude = "Person:patient"
    * searchParam[0]
      * name = "identifier"
      * definition = "http://hl7.org/fhir/SearchParameter/Patient-identifier"
      * type = #token
      * documentation = "Only supports search by institution MRN"
    * searchParam[+]
      * name = "general-practitioner"
      * definition = "http://hl7.org/fhir/SearchParameter/Patient-general-practitioner"
      * type = #reference
  * interaction[0].code = #transaction
  * interaction[+].code = #history-system
