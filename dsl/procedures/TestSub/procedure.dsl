// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
procedure 'Test Sub', description: 'The getting the Test Case from Test Rail as JSON via CLI', {

    step 'Get Test Case', {
        description = 'some step description'

        subproject = ''

        subprocedure = 'Get Test Case'

        actualParameter = [
            'caseId' : '$[caseId]',

            'config' : '$[config]',
            ]
        }

    formalOutputParameter 'caseJSON',
        description: 'case as JSON'

    formalOutputParameter 'caseId',
        description: 'Id of created/updated test case on TestRail, if exist'
// === procedure_autogen ends, checksum: 89389a60666f0ea17f53d4b966aef421 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}