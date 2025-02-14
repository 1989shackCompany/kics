package Cx

import data.generic.cloudformation as cf_lib

CxPolicy[result] {
	document := input.document
	resource = document[i].Resources[name]
	resource.Type == "AWS::ApiGateway::Stage"

	not check_resources_type(document[i].Resources)

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("Resources.%s has UsagePlan defined", [name]),
		"keyActualValue": sprintf("Resources.%s doesn't have UsagePlan defined", [name]),
	}
}

CxPolicy[result] {
	document := input.document
	resource = document[i].Resources[name]
	resource.Type == "AWS::ApiGateway::Stage"

	properties := resource.Properties
	not settings_are_equal(document[i].Resources, properties.RestApiId, properties.StageName)

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("Resources.%s has AWS::ApiGateway::UsagePlan associated, RestApiId and StageName are the same as the %s resource", [name, name]),
		"keyActualValue": sprintf("Resources.%s should have AWS::ApiGateway::UsagePlan associated, RestApiId and StageName should be the same in the %s resource", [name, name]),
	}
}

check_resources_type(resource) {
	resource[_].Type == "AWS::ApiGateway::UsagePlan"
}

settings_are_equal(resource, restApiId, stageName) {
	resource[_].Type == "AWS::ApiGateway::UsagePlan"
	find_api_stages(resource[_].Properties.ApiStages, restApiId, stageName)
}

find_api_stages(apiStages, restApiId, stageName) {
	apiStages[_].ApiId == restApiId
	apiStages[_].Stage == stageName
}
