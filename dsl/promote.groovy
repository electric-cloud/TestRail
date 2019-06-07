import groovy.transform.BaseScript
import com.electriccloud.commander.dsl.util.BasePlugin

//noinspection GroovyUnusedAssignment
@BaseScript BasePlugin baseScript

// Variables available for use in DSL code
def pluginName = args.pluginName
def upgradeAction = args.upgradeAction
def otherPluginName = args.otherPluginName

def pluginKey = getProject("/plugins/$pluginName/project").pluginKey
def pluginDir = getProperty("/projects/$pluginName/pluginDir").value

//List of procedure steps to which the plugin configuration credentials need to be attached
def stepsWithAttachedCredentials = [
[procedureName: "Get Test Case", stepName: "Get Test Case"],
[procedureName: "Create Test Case", stepName: "Create Test Case"],
[procedureName: "Update Test Case", stepName: "Update Test Case"],
[procedureName: "Get Test Case CLI", stepName: "Get Test Case CLI"],
[procedureName: "Create Test Case CLI", stepName: "Create Test Case CLI"],
[procedureName: "Update Test Case CLI", stepName: "Update Test Case CLI"],
[procedureName: "Create or Update Test Case", stepName: "Create or Update Test Case"],
[procedureName: "CreateOrUpdate  CLI", stepName: "GetCase"],
[procedureName: "CreateOrUpdate  CLI", stepName: "CreateCase"],
[procedureName: "CreateOrUpdate  CLI", stepName: "UpdateCase"],
[procedureName: "CreateOrUpdate  CLI", stepName: "Get Test Case CLI"],
[procedureName: "CreateOrUpdate  CLI", stepName: "Create Test Case CLI"],
[procedureName: "CreateOrUpdate  CLI", stepName: "Update Test Case CLI"],
[procedureName: "Create Or Update Rest", stepName: "Get Test Case"],
[procedureName: "Create Or Update Rest", stepName: "Create Test Case"],
[procedureName: "Create Or Update Rest", stepName: "Update Test Case"],
// === steps with credentials ends ===
// Please do not remove the line above, it marks the place for the new steps
// The code above will be updated automatically as you add more procedures into your plugin
// Feel free to change the code below
]


project pluginName, {
    // Please do not remove the line below
    property 'ec_keepFilesExtensions', value: 'true'

    // This line is required in order for React forms to work (you probably do not want to remove it too)
    property 'ec_formXmlCompliant', value: 'true'
    loadPluginProperties(pluginDir, pluginName)
    loadProcedures(pluginDir, pluginKey, pluginName, stepsWithAttachedCredentials)
    // plugin configuration metadata
    // Please remove the block below if your plugin does not require configuration
    property 'ec_config', {
        configLocation = 'ec_plugin_cfgs'
        form = '$[' + "/projects/$pluginName/procedures/CreateConfiguration/ec_parameterForm]"
        property 'fields', {
            property 'desc', {
                property 'label', value: 'Description'
                property 'order', value: '1'
            }
        }
    }
    // Place your custom project-level properties in here, like
    // property 'myPropName', {
    //     value = 'some value'
    // }
    // or
    // property 'myPropName', {
    //     property 'second level', value: 1
    // }
}

// Copy existing plugin configurations from the previous
// version to this version. At the same time, also attach
// the credentials to the required plugin procedure steps.
upgrade(upgradeAction, pluginName, otherPluginName, stepsWithAttachedCredentials)