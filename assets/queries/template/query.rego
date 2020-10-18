package Cx

CxPolicy [ result ] {
  resource := input.document[i].resource
  resource == "<VALUE>"

	result := mergeWithMetadata({
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("%s", [resource]),
                "issueType":		"IncorrectValue",  #"MissingAttribute" / "RedundantAttribute"
                "keyExpectedValue": "<RESOURCE>",
                "keyActualValue": 	resource
            })
}