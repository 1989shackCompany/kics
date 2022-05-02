package Cx

import data.generic.common as common_lib

CxPolicy[result] {
	resource := input.document[i].command[name][_]
	resource.Cmd == "run"
    value := resource.Value
	contains(value[v], "/bin/bash")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("FROM={{%s}}.{{%s}}", [name, resource.Original]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("FROM={{%s}}.{{%s}} uses the SHELL command to change the default shell", [name, resource.Original]),
		"keyActualValue": sprintf("FROM={{%s}}.{{%s}} uses the RUN command to change the default shell", [name, resource.Original]),
	}
}

CxPolicy[result] {
	resource := input.document[i].command[name][_]
	resource.Cmd == "run"
    value := resource.Value
	contains(value[v], "powershell")

	result := {
		"documentId": input.document[i].id,
		"searchKey": sprintf("FROM={{%s}}.{{%s}}", [name, resource.Original]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("FROM={{%s}}.{{%s}} uses the SHELL command to change the default shell", [name, resource.Original]),
		"keyActualValue": sprintf("FROM={{%s}}.{{%s}} uses the RUN command to change the default shell", [name, resource.Original]),
	}
}
