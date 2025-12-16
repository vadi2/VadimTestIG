// Minimal reproduction case for structuredefinition-implements bug
// In FHIR R5, Questionnaire implements MetadataResource interface.
// SUSHI copies this extension from the base definition, but the extension
// http://hl7.org/fhir/StructureDefinition/structuredefinition-implements
// is not published anywhere, causing IG Publisher validation errors.

Profile: TestQuestionnaire
Parent: Questionnaire
Id: test-questionnaire
Title: "Test Questionnaire"
Description: "Minimal Questionnaire profile to reproduce structuredefinition-implements extension bug"
* status MS
* title MS
* item MS
