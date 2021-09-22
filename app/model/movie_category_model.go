package model

import "gorm.io/gorm"

type MovieCategoryModel struct {
	*gorm.DB   `gorm:"-" json:"-"`
	Id         int64 `gorm:"column:mct_id;primarykey" json:"id"`
	CategoryId int64 `gorm:"column:mct_category_id" json:"category_id"`
	MovieId    int64 `gorm:"column:mct_movie_id" json:"movie_id"`
	CreatedAt  int   `gorm:"column:mct_created_at" json:"created_at"`
	UpdatedAt  int   `gorm:"column:mct_updated_at" json:"updated_at"`
}

func (m *MovieCategoryModel) TableName() string {
	return "tb_movie_category"
}

func (m *MovieCategoryModel) GetOne(maps interface{}) (category *MovieCategoryModel) {
	m.Where(maps).First(&category)

	return
}
