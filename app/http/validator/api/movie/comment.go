package movie

import (
	"go-movie/app/global/consts"
	"go-movie/app/http/controller/api"
	common_data_type "go-movie/app/http/validator/common/data_type"
	"go-movie/app/http/validator/common/validator_trans"
	"go-movie/app/http/validator/core/data_transfer"
	"go-movie/app/utils/response"

	"github.com/gin-gonic/gin"
)

type AddComment struct {
	Content string `form:"content" json:"content" binding:"required,min=1,max=500"`
	Uid     int64  `form:"uid" json:"uid" binding:"min=0"`
	Pid     int64  `form:"pid" json:"pid" binding:"min=0"`
	MovieId int64  `form:"movie_id" json:"movie_id" binding:"required,min=1"`
}

func (n AddComment) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&n); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "Comment参数校验失败，参数不符合规定，content(长度>=1)max<=500、movie_id>=1,请按照规则自己检查",
			"err":  validator_trans.Translate(err),
		})
		return
	}

	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(n, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "comment表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Comment{}).AddComment(extraAddBindDataContext)
	}

}

type GetComments struct {
	MovieId string `form:"movie_id" json:"movie_id" binding:"required,min=1"` //  验证规则：必填，最小长度为1
	common_data_type.Page
}

func (m GetComments) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&m); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "comment参数校验失败，参数不符合规定，movie_id(长度>=1)、page>=1、limit>=1,请按照规则自己检查",
			"err":  err.Error(),
		})
		return
	}

	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(m, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "comment表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Comment{}).GetComments(extraAddBindDataContext)
	}

}
