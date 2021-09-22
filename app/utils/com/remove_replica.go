package com

func RemoveReplicaSliceInterface(slc []interface{}) []interface{} {
	/*
	   slice(interface类型)元素去重
	*/
	result := make([]interface{}, 0)
	tempMap := make(map[interface{}]bool, len(slc))
	for _, e := range slc {
		if tempMap[e] == false {
			tempMap[e] = true
			result = append(result, e)
		}
	}

	return result
}

func RemoveReplicaSliceString(slc []string) []string {
	/*
	   slice(string类型)元素去重
	*/
	result := make([]string, 0)
	tempMap := make(map[string]bool, len(slc))
	for _, e := range slc {
		if tempMap[e] == false {
			tempMap[e] = true
			result = append(result, e)
		}
	}
	return result
}

func RemoveReplicaSliceInt(slc []int) []int {
	/*
	   slice(int类型)元素去重
	*/
	result := make([]int, 0)
	tempMap := make(map[int]bool, len(slc))
	for _, e := range slc {
		if tempMap[e] == false {
			tempMap[e] = true
			result = append(result, e)
		}
	}
	return result
}
