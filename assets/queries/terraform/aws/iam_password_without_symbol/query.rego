package Cx

import data.generic.common as common_lib
import data.generic.terraform as tf_lib

CxPolicy[result] {
	password_policy := input.document[i].resource.aws_iam_account_password_policy[name]
	not common_lib.valid_key(password_policy, "require_symbols")

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_iam_account_password_policy",
		"resourceName": tf_lib.get_resource_name(password_policy, name),
		"searchKey": sprintf("aws_iam_account_password_policy[%s]", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'require_symbols' should be set with true value",
		"keyActualValue": "'require_symbols' is undefined",
	}
}

CxPolicy[result] {
	password_policy := input.document[i].resource.aws_iam_account_password_policy[name]
	password_policy.require_symbols == false

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_iam_account_password_policy",
		"resourceName": tf_lib.get_resource_name(password_policy, name),
		"searchKey": sprintf("aws_iam_account_password_policy[%s].require_symbols", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'require_symbols' should be true",
		"keyActualValue": "'require_symbols' is false",
	}
}
