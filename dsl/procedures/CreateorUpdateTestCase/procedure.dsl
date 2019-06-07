// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'Create or Update Test Case', description: 'The procedure take a JSON and update Case in Test Rail', {

    step 'Get Test Case', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/CreateorUpdateTestCase/steps/GetTestCase.pl").text
        shell = 'ec-perl'
        }

    step 'Create Test Case', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/CreateorUpdateTestCase/steps/CreateTestCase.pl").text
        shell = 'ec-perl'
        condition = '"$[/myJob/steps/"Get Test Case"/outputParameters/caseId]" == ""'
        }

    step 'Update Test Case', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/CreateorUpdateTestCase/steps/UpdateTestCase.pl").text
        shell = 'ec-perl'
        condition = '"$[/myJob/steps/"Get Test Case"/outputParameters/caseId]" != ""'
        }

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail'
    formalOutputParameter 'caseJSON',
        description: 'case as JSON'
// === procedure_autogen ends, checksum: 3b7e05224a0858266312c6ba3831fac9 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}