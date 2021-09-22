package model

import "gorm.io/gorm"

type MovieTextModel struct {
	*gorm.DB  `gorm:"-" json:"-"`
	Id        int64  `gorm:"column:mtx_id;primarykey" json:"id"`
	Content   string `gorm:"column:mtx_content" json:"content"`
	MovieId   int64  `gorm:"column:mtx_movie_id" json:"movie_id"`
	CreatedAt int    `gorm:"column:mtx_created_at" json:"created_at"`
	UpdatedAt int    `gorm:"column:mtx_updated_at" json:"updated_at"`
}

func (m *MovieTextModel) TableName() string {
	return "tb_movie_text"
}
