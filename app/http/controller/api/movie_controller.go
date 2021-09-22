package api

import (
	"fmt"
	"go-movie/app/global/consts"
	"go-movie/app/model"
	"go-movie/app/utils/com"
	"go-movie/app/utils/response"

	"github.com/gin-gonic/gin"
)

type Movie struct {
}

func (c *Movie) GetMovies(context *gin.Context) {
	var maps = make(map[string]interface{})
	maps["mov_display"] = 1
	movieModelFact := model.CreateMovieFactory("")
	data := movieModelFact.GetMovies(com.GetPage(context), 100, maps)
	response.Success(context, "ok", gin.H{
		"data": data,
	})
}

// 获取首页评分Top10
func (m *Movie) GetTop10(context *gin.Context) {
	var maps = make(map[string]interface{})
	pageNum := com.GetPage(context)
	pageSize := com.GetLimit(context)
	category := int64(context.GetFloat64(consts.ValidatorPrefix + "category"))
	maps["mov_display"] = 1
	maps["mct_category_id"] = category
	movieModelFact := model.CreateMovieFactory("")
	data := movieModelFact.GetTop10(pageNum, pageSize, maps)
	response.Success(context, "ok", gin.H{
		"data": data,
	})
}

// 获取首页最近更新
func (m *Movie) GetLatelyOfAll(context *gin.Context) {
	var maps = make(map[string]interface{})
	pageNum := com.GetPage(context)
	pageSize := com.GetLimit(context)
	maps["mov_display"] = 1
	movieModelFact := model.CreateMovieFactory("")
	data := movieModelFact.GetLatelyOfAll(pageNum, pageSize, maps)
	response.Success(context, "ok", gin.H{
		"data": data,
	})
}

func (m *Movie) GetLatelyByType(context *gin.Context) {
	var maps = make(map[string]interface{})
	category := int64(context.GetFloat64(consts.ValidatorPrefix + "category"))
	maps["mov_display"] = 1
	maps["mct_category_id"] = category
	movieModelFact := model.CreateMovieFactory("")
	data := movieModelFact.GetLatelyByType(com.GetPage(context), com.GetLimit(context), maps)
	total := movieModelFact.GetMovieTotalByType(maps)
	response.Success(context, "ok", gin.H{
		"data":       data,
		"total":      total,
		"cur_page":   com.GetCurrentPage(context),
		"total_page": com.GetTotalPage(total, context),
	})
}

func (m *Movie) GetLists(context *gin.Context) {
	var maps = make(map[string]interface{})
	var order = "mov_created_at DESC"
	pageNum := com.GetPage(context)
	pageSize := com.GetLimit(context)
	maps["mov_display"] = 1
	if category := int64(context.GetFloat64(consts.ValidatorPrefix + "category")); category != 0 {
		maps["mct_category_id"] = category
	}
	if area := context.GetString(consts.ValidatorPrefix + "area"); area != "" {
		maps["mov_area"] = area
	}
	if year := context.GetFloat64(consts.ValidatorPrefix + "year"); year != 0 {
		year := int64(year)
		maps["mov_year"] = year
	}
	if language := context.GetString(consts.ValidatorPrefix + "language"); language != "" {
		maps["mov_language"] = language
	}
	if title := context.GetString(consts.ValidatorPrefix + "title"); title != "" {
		maps["mov_title"] = title
	}
	if sort := context.GetString(consts.ValidatorPrefix + "sort"); sort != "" {
		switch sort {
		case "hit":
			order = "mov_hits DESC"
		case "commend":
			order = "mov_up DESC"
		}
	}
	movieModelFact := model.CreateMovieFactory("")
	data := movieModelFact.GetLists(pageNum, pageSize, order, maps)
	total := movieModelFact.GetMovieTotalByType(maps)
	response.Success(context, "ok", gin.H{
		"data":       data,
		"total":      total,
		"cur_page":   com.GetCurrentPage(context),
		"total_page": com.GetTotalPage(total, context),
	})
}

func (c *Movie) AddMovie(context *gin.Context) {
	var maps = make(map[string]interface{})
	title := context.GetString(consts.ValidatorPrefix + "title")
	area := context.GetString(consts.ValidatorPrefix + "area")
	language := context.GetString(consts.ValidatorPrefix + "language")
	year := int64(context.GetFloat64(consts.ValidatorPrefix + "year"))
	cover := context.GetString(consts.ValidatorPrefix + "cover")
	display := int64(context.GetFloat64(consts.ValidatorPrefix + "display"))
	position := int64(context.GetFloat64(consts.ValidatorPrefix + "position"))
	up := int64(context.GetFloat64(consts.ValidatorPrefix + "up"))
	down := int64(context.GetFloat64(consts.ValidatorPrefix + "down"))
	alias := context.GetString(consts.ValidatorPrefix + "alias")
	hits := int64(context.GetFloat64(consts.ValidatorPrefix + "hits"))
	rate := context.GetFloat64(consts.ValidatorPrefix + "rate")
	ratingCount := int64(context.GetFloat64(consts.ValidatorPrefix + "rating_count"))
	serialize := context.GetString(consts.ValidatorPrefix + "serialize")
	status := int64(context.GetFloat64(consts.ValidatorPrefix + "status"))
	resourceUrl := context.GetString(consts.ValidatorPrefix + "resource_url")
	duration := context.GetString(consts.ValidatorPrefix + "duration")
	pubdate := context.GetString(consts.ValidatorPrefix + "pubdate")
	pinyin := context.GetString(consts.ValidatorPrefix + "pinyin")
	favoritesCount := int64(context.GetFloat64(consts.ValidatorPrefix + "favorites_count"))
	content := context.GetString(consts.ValidatorPrefix + "content")
	var directors []interface{}
	if val, ok := context.Get(consts.ValidatorPrefix + "directors"); ok && val != nil {
		directors, ok = val.([]interface{})
		directors = com.RemoveReplicaSliceInterface(directors)
	}
	var screenWriters []interface{}
	if val, ok := context.Get(consts.ValidatorPrefix + "screen_writers"); ok && val != nil {
		screenWriters, ok = val.([]interface{})
		screenWriters = com.RemoveReplicaSliceInterface(screenWriters)
	}

	var actors []interface{}
	if val, ok := context.Get(consts.ValidatorPrefix + "actors"); ok && val != nil {
		actors, ok = val.([]interface{})
		actors = com.RemoveReplicaSliceInterface(actors)
	}
	var category []interface{}
	if val, ok := context.Get(consts.ValidatorPrefix + "category"); ok && val != nil {
		category, ok = val.([]interface{})
		category = com.RemoveReplicaSliceInterface(category)
	}
	var movieUrl []interface{}
	if val, ok := context.Get(consts.ValidatorPrefix + "movie_url"); ok && val != nil {
		movieUrl, _ = val.([]interface{})
	}
	maps["title"] = title
	maps["area"] = area
	maps["language"] = language
	maps["year"] = year
	maps["cover"] = cover
	maps["display"] = display
	maps["position"] = position
	maps["up"] = up
	maps["down"] = down
	maps["alias"] = alias
	maps["hits"] = hits
	maps["rate"] = rate
	maps["rating_count"] = ratingCount
	maps["directors"] = directors
	maps["screen_writers"] = screenWriters
	maps["actors"] = actors
	maps["serialize"] = serialize
	maps["status"] = status
	maps["resource_url"] = resourceUrl
	maps["duration"] = duration
	maps["pubdate"] = pubdate
	maps["pinyin"] = pinyin
	maps["favorites_count"] = favoritesCount
	maps["content"] = content
	maps["category"] = category
	maps["movie_url"] = movieUrl
	movieModelFact := model.CreateMovieFactory("")
	err := movieModelFact.AddMovie(maps)
	if err != nil {
		response.Fail(context, consts.MovieAddFailCode, fmt.Sprint(err), err)
	} else {
		response.Success(context, "ok", gin.H{
			"title": title,
		})
	}
}
