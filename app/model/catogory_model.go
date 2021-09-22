package model

import (
	"reflect"

	"gorm.io/gorm"
)

func CreateCategoryFactory(sqlType string) *CategoryModel {
	return &CategoryModel{DB: UseDbConn(sqlType)}
}

type CategoryModel struct {
	*gorm.DB    `gorm:"-" json:"-"`
	Id          int64            `gorm:"column:cat_id;primarykey" json:"id"`
	Name        string           `gorm:"column:cat_name" json:"name"`
	Title       string           `gorm:"column:cat_title" json:"title"`
	Icon        string           `gorm:"column:cat_icon" json:"icon"`
	Pid         int64            `gorm:"column:cat_pid" json:"pid"`
	Sort        int64            `gorm:"column:cat_sort" json:"sort"`
	Display     int64            `gorm:"column:cat_display" json:"display"`
	MetaTitle   string           `gorm:"column:cat_meta_title" json:"meta_title"`
	Keywords    string           `gorm:"column:cat_keywords" json:"keywords"`
	Description string           `gorm:"column:cat_description" json:"description"`
	Status      int64            `gorm:"column:cat_status" json:"status"`
	Navno       int64            `gorm:"column:cat_navno" json:"navno"`
	Appno       int64            `gorm:"column:cat_appno" json:"appno"`
	Children    []*CategoryModel `gorm:"-" json:"children"`
	CreatedAt   int              `gorm:"column:cat_created_at" json:"created_at"`
	UpdatedAt   int              `gorm:"column:cat_updated_at" json:"updated_at"`
}

// 表名
func (c *CategoryModel) TableName() string {
	return "tb_category"
}

func (c *CategoryModel) GetCategorys(PageNum int, PageSize int, maps interface{}) (categorys []*CategoryModel) {
	c.Where(maps).Offset(PageNum).Limit(PageSize).Find(&categorys)

	return
}

func (c *CategoryModel) GetCategoryTree(PageNum int, PageSize int, maps interface{}) []*CategoryModel {
	var categorys []*CategoryModel
	c.Where(maps).Offset(PageNum).Limit(PageSize).Find(&categorys)
	//判断是否存在数据,存在进行树状图重构
	if reflect.ValueOf(categorys).IsValid() {
		//将一级菜单传递给回调函数
		return c.Tree(categorys, 0)
	}
	return nil
}

func (c CategoryModel) GetCategory(id int) (category CategoryModel) {
	c.Where("id = ?", id).First(&category)

	return
}

func (c *CategoryModel) GetCategoryTotal(maps interface{}) (count int64) {
	c.Model(&CategoryModel{}).Where(maps).Count(&count)

	return count
}

func (c *CategoryModel) AddCategory(data map[string]interface{}) bool {
	var maps = make(map[string]interface{})
	maps["cat_pid"] = data["pid"]
	if maps["cat_pid"] != 0 && !c.ExistCategory(maps) {
		return false
	}
	maps["cat_title"] = data["title"]
	maps["cat_name"] = data["name"]
	if c.ExistCategory(maps) {
		return false
	}

	c.Create(&CategoryModel{
		Name:        data["name"].(string),
		Title:       data["title"].(string),
		Icon:        data["icon"].(string),
		Pid:         data["pid"].(int64),
		Sort:        data["sort"].(int64),
		Display:     data["display"].(int64),
		MetaTitle:   data["meta_title"].(string),
		Keywords:    data["keywords"].(string),
		Description: data["description"].(string),
		Status:      data["status"].(int64),
		Navno:       data["navno"].(int64),
		Appno:       data["appno"].(int64),
	})

	return true
}

func (c *CategoryModel) ExistCategory(maps interface{}) bool {
	var category CategoryModel
	c.Select("cat_id").Where(maps).First(&category)
	if category.Id > 0 {
		return true
	}

	return false
}

func (c *CategoryModel) GetOne(maps interface{}) (category *CategoryModel) {
	c.Where(maps).First(&category)

	return
}

func (c *CategoryModel) Tree(categorys []*CategoryModel, pid int64) []*CategoryModel {
	//定义子节点目录
	var nodes []*CategoryModel
	if reflect.ValueOf(categorys).IsValid() {
		// 循环所有一级菜单
		for _, v := range categorys {
			if v.Pid == pid {
				var node = v
				v.Children = c.Tree(categorys, v.Id)
				nodes = append(nodes, node)
			}
		}
	}

	return nodes
}
