package com

import (
	"go-movie/app/global/variable"
	"math"

	"github.com/gin-gonic/gin"
	"github.com/unknwon/com"
)

func GetPage(c *gin.Context) int {
	result := 0
	page, _ := com.StrTo(c.Query("page")).Int()

	if page > 0 {
		result = (page - 1) * GetLimit(c)
	}

	return result
}

func GetCurrentPage(c *gin.Context) int {
	currentPage := 1
	page, _ := com.StrTo(c.Query("page")).Int()

	if page > 0 {
		currentPage = page
	}

	return currentPage
}

func GetTotalPage(total int64, c *gin.Context) float64 {
	count := float64(total)
	pageSize := float64(GetLimit(c))
	totalPage := math.Ceil(count / pageSize)
	return totalPage
}

func GetLimit(c *gin.Context) int {
	result := variable.ConfigYml.GetInt("Pagination.PageSize")
	limit, _ := com.StrTo(c.Query("limit")).Int()
	maxLimit := variable.ConfigYml.GetInt("Pagination.MaxPageSize")
	if limit > 0 && limit <= maxLimit {
		result = limit
	}

	return result
}
