// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'Create Or Update Rest', description: 'The getting the Test Case from Test Rail as JSON via CLI', {

    step 'Get Test Case', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateRest/steps/GetTestCase.pl").text
        shell = 'ec-perl'

        actualParameter = [
            'caseId' : '$[caseId]',
            ]
        }

    step 'Create Test Case', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateRest/steps/CreateTestCase.pl").text
        shell = 'ec-perl'

        condition = '$[/javascript myParent.outputParameters.caseId == undefined]'

        actualParameter = [
            'json' : '$[json]',

            'sectionId' : '$[sectionId]',
            ]
        }

    step 'Update Test Case', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateRest/steps/UpdateTestCase.pl").text
        shell = 'ec-perl'

        condition = '$[/javascript myParent.outputParameters.caseId]'

        actualParameter = [
            'json' : '$[json]',

            'caseId' : '$[caseId]',
            ]
        }

    formalOutputParameter 'caseJSON',
        description: 'case as JSON'

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail, if exist'
// === procedure_autogen ends, checksum: 92b566c2eac5ce7203a74dde90ff2c92 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}