# Pattern/fixed value on a choice element (value[x]) is not rendered in the profile table

Hit this on publisher 2.2.8 (Git# e39e13a432d0, built 2026-05-23), FHIR R5, sushi 3.19.0.

When I pin a coded value with a pattern on a **choice** element - `value[x] only CodeableConcept` followed by a `patternCodeableConcept` - the profile page renders the "Required Pattern" label but never paints the actual coding. The reader sees:

> Required Pattern: At least the following

…and then nothing - the next row is the following sibling element. So the fixed value looks like it was dropped. It only happens on choice (`[x]`) elements; the exact same pattern on a non-choice element renders fine.

## Reproduce

`./_genonce.sh`, then open the generated profile pages (any view - Snapshot, Differential, Key Elements):

- `output/StructureDefinition-observation-pattern-repro.html`
- `output/StructureDefinition-plandefinition-usecontext-pattern-repro.html`
- `output/StructureDefinition-value-pattern-ext.html`

Every element below is pinned to the **same** `repro-cs#foo` (or `usage-context-type#focus`) pattern, but only the non-choice ones show it:

| Element | kind | pattern body in table |
|---|---|---|
| `Observation.code` | CodeableConcept, non-choice | **rendered** (`foo`) |
| `UsageContext.code` | Coding, non-choice | **rendered** (`focus`) |
| `Observation.value[x]` | choice, resource root | empty |
| `Observation.component.value[x]` | choice, backbone element | empty |
| `PlanDefinition.useContext.value[x]` | choice, complex datatype | empty |
| `Extension.value[x]` | choice, in an extension | empty |

So it's not "it's a value[x]" (`Observation.value[x]` is one and still fails) and not "it's a CodeableConcept pattern" (`Observation.code` is one and renders). The deciding factor is the choice (`[x]`) element itself, and it fails at every position I tried - resource root, backbone, complex datatype, and extension.

## The value really is constrained - it's only the HTML that drops it

The generated StructureDefinitions all carry the pattern on the snapshot element, e.g. `fsh-generated/resources/StructureDefinition-plandefinition-usecontext-pattern-repro.json`:

```json
{
  "id": "PlanDefinition.useContext.value[x]",
  "path": "PlanDefinition.useContext.value[x]",
  "min": 1, "max": "1",
  "type": [{ "code": "CodeableConcept" }],
  "patternCodeableConcept": {
    "coding": [{ "system": "https://vadimperetok.in/fhir/CodeSystem/repro-cs", "code": "foo", "display": "Foo display" }]
  }
}
```

and the example `Observation` (value = `repro-cs#foo`) validates against it. There's no warning or error about the pattern - the publisher just silently omits it from the table, which makes it easy to mistake for "the constraint didn't take".

## Expected

Render the fixed coding (system / code / display) for a pattern[x]/fixed[x] on a choice element the same way it's rendered for a non-choice element - i.e. the `Observation.value[x]` row should show `foo` under "Required Pattern", just like the `Observation.code` row does.

## Where I hit it

Originally in a real IG (uzinfocom-org/digital-health-ig) on `PlanDefinition.useContext[immunizationFocus].value[x]`, pinned to `SNOMED 33879002`. The schedule's focus context was correctly fixed in the snapshot and enforced, but the profile page showed an empty "Required Pattern", so it looked like the binding hadn't applied. Worked around it with an explanatory `^short`, but the table should just show the value.
