package model

import "gorm.io/gorm"

func CreateMovieUrlFactory(sqlType string) *MovieUrlModel {
	return &MovieUrlModel{DB: UseDbConn(sqlType)}
}

type MovieUrlModel struct {
	*gorm.DB  `gorm:"-" json:"-"`
	Id        int64  `gorm:"column:mul_id;primarykey" json:"id"`
	Title     string `gorm:"column:mul_title" json:"title"`
	MovieUrl  string `gorm:"column:mul_movie_url" json:"movie_url"`
	MovieId   int64  `gorm:"column:mul_movie_id" json:"movie_id"`
	CreatedAt int    `gorm:"column:mul_created_at" json:"created_at"`
	UpdatedAt int    `gorm:"column:mul_updated_at" json:"updated_at"`
}

func (m *MovieUrlModel) TableName() string {
	return "tb_movie_url"
}
