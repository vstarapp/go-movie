package movie

import (
	"go-movie/app/global/consts"
	"go-movie/app/http/controller/api"
	"go-movie/app/http/validator/common/validator_trans"
	"go-movie/app/http/validator/core/data_transfer"
	"go-movie/app/utils/response"

	"github.com/gin-gonic/gin"
)

type Category struct {
	Name        string `form:"name" json:"name" binding:"required,min=1,max=15"`
	Title       string `form:"title" json:"title" binding:"required,min=1,max=25"`
	Icon        string `form:"icon" json:"icon" binding:"max=50"`
	Pid         int64  `form:"pid" json:"pid" binding:"min=0"`
	Sort        int64  `form:"sort" json:"sort" binding:"min=0"`
	Display     int64  `form:"display" json:"display" binding:"min=0,max=1"`
	MetaTitle   string `form:"meta_title" json:"meta_title" binding:"max=50"`
	Keywords    string `form:"keywords" json:"keywords" binding:"max=255"`
	Description string `form:"description" json:"description" binding:"max=255"`
	Status      int64  `form:"status" json:"status" binding:"min=0,max=1"`
	Navno       int64  `form:"navno" json:"navno" binding:"min=0,max=1"`
	Appno       int64  `form:"appno" json:"appno" binding:"min=0,max=1"`
}

func (c Category) CheckParams(context *gin.Context) {
	//1.先按照验证器提供的基本语法，基本可以校验90%以上的不合格参数
	if err := context.ShouldBind(&c); err != nil {
		response.ErrorParam(context, gin.H{
			"tips": "category参数校验失败，参数不符合规定，name(长度>=1 and 长度<=15)、title(长度>=1 and 长度<=25),请按照规则自己检查",
			"err":  validator_trans.Translate(err),
		})
		return
	}

	//  该函数主要是将绑定的数据以 键=>值 形式直接传递给下一步（控制器）
	extraAddBindDataContext := data_transfer.DataAddContext(c, consts.ValidatorPrefix, context)
	if extraAddBindDataContext == nil {
		response.ErrorSystem(context, "comment表单验证器json化失败", "")
	} else {
		// 验证完成，调用控制器,并将验证器成员(字段)递给控制器，保持上下文数据一致性
		(&api.Category{}).AddCategory(extraAddBindDataContext)
	}

}
