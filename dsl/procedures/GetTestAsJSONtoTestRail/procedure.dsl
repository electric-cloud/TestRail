// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'Get Test As JSON to TestRail', description: 'The procedure take a xml and import it to Test Rail as Test Case', {

    step 'Get Test As JSON to TestRail', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/GetTestAsJSONtoTestRail/steps/GetTestAsJSONtoTestRail.pl").text
        shell = 'ec-perl'

        }

    formalOutputParameter 'response',
        description: 'Responce of TestRail'

    formalOutputParameter 'caseJSON',
        description: 'case as JSON'

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail'
// === procedure_autogen ends, checksum: 7ddb05c8f4e01ffdb93aa01bcb47bc13 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}