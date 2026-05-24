# IG Publisher bug: ConceptMap target-VS validation rejects explicit `concept` includes

## Environment

- **Publisher**: FHIR IG Publisher Version 2.2.7 (Git# 46f94953d4dc), built 2026-04-23
- **FHIR**: R5 (5.0.0)
- **SUSHI**: 3.19.0

## Symptom

For a ConceptMap whose `targetScopeCanonical` points to a local ValueSet that includes target codes via explicit `concept` enumeration, every target code emits:

```
ERROR CONCEPTMAP_GROUP_TARGET_CODE_INVALID_VS
"The target code '<code>' is not valid in the value set <TargetVS>|<version>"
```

The publisher does **not** query the tx server for this check (this build's `qa-tx.html` shows zero `validate-code` calls), so the misjudgement is entirely internal: the publisher's local VS expander does not honour the explicit `concept` lists when validating ConceptMap targets.

## Reproduction

```sh
./_genonce.sh
```

Then look at `output/qa.txt`. Expect:

```
ERROR: ConceptMap/repro-cm: ConceptMap.group[0].element[0].target[0].code: The target code '01' is not valid in the value set https://vadimperetok.in/fhir/ValueSet/target-vs|0.1.0
ERROR: ConceptMap/repro-cm: ConceptMap.group[0].element[1].target[0].code: The target code '19' is not valid in the value set https://vadimperetok.in/fhir/ValueSet/target-vs|0.1.0
ERROR: ConceptMap/repro-cm: ConceptMap.group[0].element[2].target[0].code: The target code '113' is not valid in the value set https://vadimperetok.in/fhir/ValueSet/target-vs|0.1.0
```

## Why this is a bug

`TargetVS` (`input/fsh/repro.fsh`) is:

```fsh
ValueSet: TargetVS
* ^url = "https://vadimperetok.in/fhir/ValueSet/target-vs"
* $cvx#01  "diphtheria, tetanus toxoids and pertussis vaccine"
* $cvx#19  "Bacillus Calmette-Guerin vaccine"
* $cvx#113 "tetanus and diphtheria toxoids, adsorbed, preservative free, for adult use ..."
```

generated JSON (verbatim from `fsh-generated/resources/ValueSet-target-vs.json`):

```json
{
  "compose": {
    "include": [{
      "system": "http://hl7.org/fhir/sid/cvx",
      "concept": [
        {"code": "01", "display": "..."},
        {"code": "19", "display": "..."},
        {"code": "113","display": "..."}
      ]
    }]
  }
}
```

The expansion of this VS, per FHIR semantics, is exactly these three codes. tx.fhir.org agrees: `ValueSet/$expand` returns them, and `ValueSet/$validate-code` with each code + this VS inline returns `result: true`. Despite this, the publisher's `CONCEPTMAP_GROUP_TARGET_CODE_INVALID_VS` check rejects every one of them.

## Other VS shapes tested (all reproduce the bug)

In the originating IG (Uzbekistan digital-health-ig, `ConceptMap/dmed-vaccine-to-cvx-cm`, 52 target elements), we tried three `TargetVS.compose.include` shapes - all 52 errors persisted:

1. Broad `* include codes from system $cvx`
2. Explicit concepts: `* $cvx#01 "..."` etc. (this repro)
3. Filter: `* include codes from system $cvx where vaccine-status = #Active` × {Active, Inactive, Pending, Never-Active, Non-US}

In the broad and filter shapes the publisher DID issue `validate-code` calls to tx.fhir.org and tx returned `result: true` for each of those 52 codes - the publisher emitted the error anyway. So the internal check is not consulting / not trusting the tx response either.

## Expected behaviour

Either:

- The `CONCEPTMAP_GROUP_TARGET_CODE_INVALID_VS` check uses the same VS expansion code path as `ValueSet/$validate-code`, OR
- A `result:true` from the configured tx server is treated as authoritative.

Currently neither happens, and any ConceptMap that maps to inactive / non-US / post-snapshot CVX codes - which is most real-world non-US vaccination IGs - accumulates one false-positive ERROR per target element.

## Original context

Discovered while fixing the Uzbekistan digital health IG (`digital-health-ig`), `ConceptMap/dmed-vaccine-to-cvx-cm`. 52 errors of this kind blocked CI. We cycled through all three VS shapes above before isolating the publisher as the source.
