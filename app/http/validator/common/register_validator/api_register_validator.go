package register_validator

import (
	"go-movie/app/core/container"
	"go-movie/app/global/consts"
	"go-movie/app/http/validator/api/movie"
)

// 各个业务模块验证器必须进行注册（初始化），程序启动时会自动加载到容器
func ApiRegisterValidator() {
	//创建容器
	containers := container.CreateContainersFactory()

	//  key 按照前缀+模块+验证动作 格式，将各个模块验证注册在容器
	var key string

	// 注册门户类表单参数验证器
	key = consts.ValidatorPrefix + "MovieNews"
	containers.Set(key, movie.News{})

	// 添加分类表单参数验证器
	key = consts.ValidatorPrefix + "MovieAddCategory"
	containers.Set(key, movie.Category{})
	// 获取评论表单参数验证其
	key = consts.ValidatorPrefix + "MovieGetComment"
	containers.Set(key, movie.GetComments{})
	// 评论添加表单参数验证器
	key = consts.ValidatorPrefix + "MovieAddComment"
	containers.Set(key, movie.AddComment{})
	// 电影添加表单参数验证器
	key = consts.ValidatorPrefix + "MovieAddMovie"
	containers.Set(key, movie.AddMovie{})

	// 根据类型获取最新电影表单参数验证器
	key = consts.ValidatorPrefix + "GetLatelyByType"
	containers.Set(key, movie.GetLatelyByType{})

	// 根据类型获取最新电影表单参数验证器
	key = consts.ValidatorPrefix + "MovieGetTop"
	containers.Set(key, movie.MovieGetTop{})

	// 根据类型获取最新电影表单参数验证器
	key = consts.ValidatorPrefix + "MovieGetLists"
	containers.Set(key, movie.MovieGetLists{})
}
