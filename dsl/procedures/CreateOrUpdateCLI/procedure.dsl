// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'CreateOrUpdate  CLI', description: 'The getting the Test Case from Test Rail as JSON via CLI', {

    step 'Get Test Case CLI', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateCLI/steps/GetTestCaseCLI.pl").text
        shell = 'ec-perl'

        actualParameter = [
            'caseId' : '$[caseId]',
            ]
        }

    step 'Create Test Case CLI', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateCLI/steps/CreateTestCaseCLI.pl").text
        shell = 'ec-perl'

        actualParameter = [
            'json' : '$[json]',

            'sectionId' : '$[sectionId]',
            ]
        }

    step 'Update Test Case CLI', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateCLI/steps/UpdateTestCaseCLI.pl").text
        shell = 'ec-perl'

        actualParameter = [
            'json' : '$[json]',

            'caseId' : '$[caseId]',
            ]
        }

    formalOutputParameter 'caseJSON',
        description: 'case as JSON'

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail, if exist'
// === procedure_autogen ends, checksum: d83ab01774519933df8db65dc9bcb5fa ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}