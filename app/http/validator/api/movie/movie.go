package movie

import (
	"go-movie/app/global/consts"
	"go-movie/app/http/controller/api"
	"go-movie/app/http/validator/common/validator_trans"
	"go-movie/app/http/validator/core/data_transfer"
	"go-movie/app/utils/response"

	"github.com/gin-gonic/gin"
)

type AddMovie struct {
	Title          string        `form:"title" json:"title" binding:"required,min=1,max=40"`
	Area           string        `form:"area"  json:"area" binding:"required,min=1,max=20"`
	Language       string        `form:"language"  json:"language" binding:"required,min=1,max=20"`
	Year           int64         `form:"year"  json:"year" binding:"required,min=1900,max=2099"`
	Cover          string        `form:"cover"  json:"cover" binding:"required,url,min=1"`
	Display        int64         `form:"display"  json:"display" binding:"min=0,max=1"`
	Position       int64         `form:"position"  json:"position" binding:"min=0,max=1"`
	Up             int64         `form:"up"  json:"up" binding:"min=0,max=1"`
	Down           int64         `form:"down"  json:"down" binding:"min=0,max=1"`
	Alias          string        `form:"alias"  json:"alias" binding:"required,min=1,max=40"`
	Hits           int64         `form:"hits"  json:"hits" binding:"min=0,max=1"`
	Rate           float64       `form:"rate"  json:"rate" binding:"min=0,max=10"`
	RatingCount    int64         `form:"rating_count"  json:"rating_count" binding:"min=0"`
	Directors      []interface{} `form:"directors"  json:"directors" binding:"required,min=1"`
	ScreenWriters  []interface{} `form:"screen_writers"  json:"screen_writers" binding:"required,min=1"`
	Actors         []interface{} `form:"actors"  json:"actors" binding:"required,min=1"`
	Serialize      string        `form:"serialize"  json:"serialize"`
	Status         int64         `form:"status"  json:"status" binding:"min=0"`
	ResourceUrl    string        `form:"resource_url"  json:"resource_url" binding:"min=0,max=255"`
	Duration       string        `form:"duration"  json:"duration" binding:"required,min=0,max=10"`
	Pubdate        string        `form:"pubdate"  json:"pubdate" binding:"min=0"`
	Pinyin         string        `form:"pinyin"  json:"pinyin" binding:"min=0,max=5"`
	FavoritesCount int64         `form:"favorites_count"  json:"favorites_count" binding:"min=0"`
	Content        string        `form:"content" json:"content" binding:"required,min=1"`
	Category       []interface{} `form:"category" json:"category" binding:"required,min=1"`
	MovieUrl       []interface{} `form:"movie_url" json:"movie_url" binding:"required,min=1"`
}

func (m AddMovie) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&m); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "Movie参数校验失败，参数不符合规定,请按照规则自己检查",
			"err":  validator_trans.Translate(err),
		})
		return
	}
	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(m, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "AddMovie表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Movie{}).AddMovie(extraAddBindDataContext)
	}
}

type GetLatelyByType struct {
	Category int64 `form:"category" json:"category" binding:"required,min=1"`
}

func (m GetLatelyByType) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&m); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "参数校验失败，参数不符合规定,请按照规则自己检查",
			"err":  validator_trans.Translate(err),
		})
		return
	}
	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(m, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Movie{}).GetLatelyByType(extraAddBindDataContext)
	}
}

type MovieGetTop struct {
	Category int64 `form:"category" json:"category" binding:"required,min=1"`
}

func (m MovieGetTop) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&m); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "参数校验失败，参数不符合规定,请按照规则自己检查",
			"err":  validator_trans.Translate(err),
		})
		return
	}
	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(m, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Movie{}).GetTop10(extraAddBindDataContext)
	}
}

type MovieGetLists struct {
	Title    string `form:"title" json:"title" binding:"min=0,max=40"`
	Area     string `form:"area"  json:"area" binding:"min=0,max=20"`
	Language string `form:"language"  json:"language" binding:"min=0,max=20"`
	Year     int64  `form:"year"  json:"year" binding:"min=0,max=2099"`
	Category int64  `form:"category" json:"category" binding:"min=0"`
}

func (m MovieGetLists) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&m); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "参数校验失败，参数不符合规定,请按照规则自己检查",
			"err":  validator_trans.Translate(err),
		})
		return
	}
	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(m, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Movie{}).GetLists(extraAddBindDataContext)
	}
}
