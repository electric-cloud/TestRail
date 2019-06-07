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

        condition = '!($[/myParent/outputParameters/caseId])'

        actualParameter = [
            'json' : '$[json]',

            'sectionId' : '$[sectionId]',
            ]
        }

    step 'Update Test Case', {
        description = 'some step description'
        command = new File(pluginDir, "dsl/procedures/CreateOrUpdateRest/steps/UpdateTestCase.pl").text
        shell = 'ec-perl'

        condition = '$[/myParent/outputParameters/caseId]'

        actualParameter = [
            'json' : '$[json]',

            'caseId' : '$[caseId]',
            ]
        }

    formalOutputParameter 'caseJSON',
        description: 'case as JSON'

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail, if exist'
// === procedure_autogen ends, checksum: 143d13bd1b9bd428e822650155e8a9ea ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}