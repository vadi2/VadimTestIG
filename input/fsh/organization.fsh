Profile: MyOrganization
Parent: Organization
Id: my-organization
Title: "My Organization"
Description: "An example profile of the Organization resource with multilingual support."
* name 1..1 MS
* active MS
* type MS

Instance: OrganizationExample
InstanceOf: MyOrganization
Description: "An example of an organization with translations."
Usage: #example
* language = #en
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "City General Hospital"
  * extension[translation][0]
    * extension[lang][0]
      * valueCode = #ru
    * extension[content][+]
      * valueString = "Городская больница"
  * extension[translation][+]
    * extension[lang][0]
      * valueCode = #uz
    * extension[content][+]
      * valueString = "Shahar shifoxonasi"
