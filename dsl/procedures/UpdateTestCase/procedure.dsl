// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'Update Test Case', description: 'The procedure take a JSON and update Case in Test Rail', {

    step 'Update Test Case', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/UpdateTestCase/steps/UpdateTestCase.pl").text
        shell = 'ec-perl'

        }

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail'
// === procedure_autogen ends, checksum: 2dece0500355887e2ccbae4fab41e4e1 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}