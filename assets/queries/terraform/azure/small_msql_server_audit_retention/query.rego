package Cx

import data.generic.terraform as tf_lib

CxPolicy[result] {
	resource_type := ["azurerm_sql_database", "azurerm_sql_server"]
	resource := input.document[i].resource[resource_type[t]][name]

	var := resource.extended_auditing_policy.retention_in_days
	var <= 90

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource_type[t],
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("%s[%s].extended_auditing_policy.retention_in_days", [resource_type[t], name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("'%s.extended_auditing_policy.retention_in_days' is bigger than 90", [name]),
		"keyActualValue": sprintf("'extended_auditing_policy.retention_in_days' is %d", [var]),
	}
}
