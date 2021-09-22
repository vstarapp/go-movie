package api

import (
	"fmt"
	"go-movie/app/global/consts"
	"go-movie/app/model"
	"go-movie/app/utils/com"
	"go-movie/app/utils/response"

	"github.com/gin-gonic/gin"
)

type Comment struct {
}

func (c *Comment) AddComment(context *gin.Context) {
	var maps = make(map[string]interface{})
	content := context.GetString(consts.ValidatorPrefix + "content")
	uid := int64(context.GetFloat64(consts.ValidatorPrefix + "uid"))
	pid := int64(context.GetFloat64(consts.ValidatorPrefix + "pid"))
	movie_id := int64(context.GetFloat64(consts.ValidatorPrefix + "movie_id"))
	clientIp := context.ClientIP()
	maps["mcm_content"] = content
	maps["mcm_uid"] = uid
	maps["mcm_pid"] = pid
	maps["mcm_movie_id"] = movie_id
	maps["mcm_up"] = 0
	maps["mcm_status"] = 1
	maps["mcm_client_ip"] = clientIp
	commentModelFact := model.CreateCommentFactory("")
	err := commentModelFact.AddComment(maps)
	if err != nil {
		response.Fail(context, consts.MovieCommentAddFailCode, fmt.Sprint(err), "")
	} else {
		response.Success(context, "ok", gin.H{
			"content":  content,
			"uid":      uid,
			"pid":      pid,
			"movie_id": movie_id,
		})
	}
}

func (c *Comment) GetComments(context *gin.Context) {
	var maps = make(map[string]interface{})
	movieId := context.GetString(consts.ValidatorPrefix + "movie_id")
	maps["mcm_movie_id"] = movieId
	commentModelFact := model.CreateCommentFactory("")
	total := commentModelFact.GetCommentTotal(maps)
	data := commentModelFact.GetComments(com.GetPage(context), com.GetLimit(context), maps)
	response.Success(context, "ok", gin.H{
		"data":  data,
		"total": total,
	})
}
