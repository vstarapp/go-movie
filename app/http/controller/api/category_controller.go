package api

import (
	"go-movie/app/global/consts"
	"go-movie/app/model"
	"go-movie/app/utils/com"
	"go-movie/app/utils/response"

	"github.com/gin-gonic/gin"
)

type Category struct {
}

func (c *Category) GetCategorys(context *gin.Context) {
	var maps = make(map[string]interface{})
	maps["cat_display"] = int64(1)
	categoryModelFact := model.CreateCategoryFactory("")
	data := categoryModelFact.GetCategorys(com.GetPage(context), com.GetLimit(context), maps)
	response.Success(context, "ok", gin.H{
		"data": data,
	})
}

func (c *Category) GetCategoryTree(context *gin.Context) {
	var maps = make(map[string]interface{})
	maps["cat_display"] = int64(1)
	categoryModelFace := model.CreateCategoryFactory("")
	data := categoryModelFace.GetCategoryTree(com.GetPage(context), com.GetLimit(context), maps)
	response.Success(context, "ok", gin.H{
		"data": data,
	})
}

func (c *Category) AddCategory(context *gin.Context) {
	var maps = make(map[string]interface{})
	name := context.GetString(consts.ValidatorPrefix + "name")
	title := context.GetString(consts.ValidatorPrefix + "title")
	icon := context.GetString(consts.ValidatorPrefix + "icon")
	pid := int64(context.GetFloat64(consts.ValidatorPrefix + "pid"))
	sort := int64(context.GetFloat64(consts.ValidatorPrefix + "sort"))
	display := int64(context.GetFloat64(consts.ValidatorPrefix + "display"))
	meta_title := context.GetString(consts.ValidatorPrefix + "meta_title")
	keywords := context.GetString(consts.ValidatorPrefix + "keywords")
	description := context.GetString(consts.ValidatorPrefix + "description")
	status := int64(context.GetFloat64(consts.ValidatorPrefix + "status"))
	navno := int64(context.GetFloat64(consts.ValidatorPrefix + "navno"))
	appno := int64(context.GetFloat64(consts.ValidatorPrefix + "appno"))
	maps["name"] = name
	maps["title"] = title
	maps["icon"] = icon
	maps["pid"] = pid
	maps["sort"] = sort
	maps["display"] = display
	maps["meta_title"] = meta_title
	maps["keywords"] = keywords
	maps["description"] = description
	maps["status"] = status
	maps["navno"] = navno
	maps["appno"] = appno
	categoryModelFace := model.CreateCategoryFactory("")
	ret := categoryModelFace.AddCategory(maps)
	if ret {
		response.Success(context, "ok", gin.H{
			"name":  name,
			"title": title,
			"pid":   pid,
		})
	} else {
		response.Fail(context, consts.CategoryAddFailCode, consts.CategoryAddFailMsg, "")
	}
}
