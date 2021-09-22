package com

func ConvertSliceInterfaceToString(slc []interface{}) []string {
	tempSlice := make([]string, len(slc))
	for i, s := range slc {
		tempSlice[i] = s.(string)
	}
	return tempSlice
}
