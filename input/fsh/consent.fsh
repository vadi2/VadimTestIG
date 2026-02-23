Instance: example-consent
InstanceOf: Consent
Description: "Example of a consent"
Usage: #example
* language = #uz
* status = #active
* subject = Reference(PatientExample)
* period
  * start = "2025-02-15T14:02:52+05:00"
  * end = "2026-02-15T14:02:52+05:00"
* grantor = Reference(PatientExample)
// * regulatoryBasis = ConsentPolicyCS#uz-LRU-547
* decision = $consent-provision-type#permit
* provision
  * action = $consent-action#disclose
  * purpose = $v3-ActReason#RECORDMGT
  * period
    * start = "2025-02-15T14:02:52+05:00"
    * end = "2026-02-15T14:02:52+05:00"
