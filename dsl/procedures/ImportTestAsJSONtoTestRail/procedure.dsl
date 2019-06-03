// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'Import Test As JSON to TestRail', description: 'The procedure take a xml and import it to Test Rail as Test Case', {

    step 'Import Test As JSON to TestRail', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/ImportTestAsJSONtoTestRail/steps/ImportTestAsJSONtoTestRail.pl").text
        shell = 'ec-perl'

        }

    formalOutputParameter 'response',
        description: 'Responce of TestRail'

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail'
// === procedure_autogen ends, checksum: 111b457ac522cdaeb5fd1a7339043b09 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}