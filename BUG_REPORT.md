# ConceptMap target-VS check rejects codes that are in the VS

Hit this on publisher 2.2.8 (and 2.2.7 before I updated), FHIR R5, sushi 3.19.0.

I have a ConceptMap with `targetScopeCanonical` pointing at a local VS that just enumerates a few CVX codes by concept. Every single target element fails validation with `CONCEPTMAP_GROUP_TARGET_CODE_INVALID_VS`, even though those exact codes are the only thing in the VS.

Run `./_genonce.sh` and look at `output/qa.txt`:

```
ERROR ConceptMap/repro-cm: ...target[0].code: The target code '01'  is not valid in the value set https://vadimperetok.in/fhir/ValueSet/target-vs|0.1.0
ERROR ConceptMap/repro-cm: ...target[0].code: The target code '19'  is not valid ...
ERROR ConceptMap/repro-cm: ...target[0].code: The target code '113' is not valid ...
```

The VS those codes are supposedly missing from:

```json
"include": [{
  "system": "http://hl7.org/fhir/sid/cvx",
  "concept": [{"code":"01",...},{"code":"19",...},{"code":"113",...}]
}]
```

`output/qa-tx.html` shows zero `validate-code` calls for this VS, so the publisher isn't even asking tx; the internal expander is just returning empty for an `include` that has a `concept` list on it.

I first ran into this in a larger IG (uzinfocom-org/digital-health-ig, 52 ConceptMap elements, all failing the same way). Tried three shapes of the target VS - none worked:

- `* include codes from system $cvx` (broad)
- `* $cvx#01 "..."` etc. (this repro)
- `* include codes from system $cvx where vaccine-status = #Active` × {Active, Inactive, Pending, Never-Active, Non-US}

In the broad and filter cases the publisher *did* hit tx, tx returned `result:true` for every code, and the publisher still emitted the error. So the check isn't trusting tx either.

I'd expect this check to either use the same expansion as `ValueSet/$validate-code`, or just believe a `result:true` from the configured tx server.
