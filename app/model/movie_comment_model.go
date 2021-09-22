package model

import (
	"errors"

	"gorm.io/gorm"
)

func CreateCommentFactory(sqlType string) *MovieCommentModel {
	return &MovieCommentModel{DB: UseDbConn(sqlType)}
}

type MovieCommentModel struct {
	*gorm.DB  `gorm:"-" json:"-"`
	Id        int64  `gorm:"column:mcm_id;primarykey" json:"id"`
	Content   string `gorm:"column:mcm_content" json:"content"`
	Uid       int64  `gorm:"column:mcm_uid" json:"uid"`
	Status    int    `gorm:"column:mcm_status" json:"status"`
	Up        int    `gorm:"column:mcm_up" json:"up"`
	Pid       int64  `gorm:"column:mcm_pid" json:"pid"`
	MovieId   int64  `gorm:"column:mcm_movie_id" json:"movie_id"`
	ClientIp  string `gorm:"column:mcm_client_ip" json:"-"`
	CreatedAt int    `gorm:"column:mcm_created_at" json:"created_at"`
	UpdatedAt int    `gorm:"column:mcm_updated_at" json:"updated_at"`
}

func (c *MovieCommentModel) TableName() string {
	return "tb_movie_comment"
}

func (c *MovieCommentModel) GetComments(PageNum int, PageSize int, maps interface{}) (comments []*MovieCommentModel) {
	c.Where(maps).Offset(PageNum).Limit(PageSize).Find(&comments)

	return
}

func (c *MovieCommentModel) GetComment(id int) (comments *MovieCommentModel) {
	c.Where("id=?", id).First(&comments)

	return
}

func (c *MovieCommentModel) GetCommentTotal(maps interface{}) (count int64) {
	c.Model(&MovieCommentModel{}).Where(maps).Count(&count)

	return count
}

func (c *MovieCommentModel) AddComment(data map[string]interface{}) error {
	var maps = make(map[string]interface{})
	maps["id"] = data["movie_id"]
	movieModelFact := CreateMovieFactory("")
	if !movieModelFact.ExistMovie(maps) {
		return errors.New("电影ID不存在")
	}
	if err := c.Create(&MovieCommentModel{
		Content:  data["content"].(string),
		Uid:      data["uid"].(int64),
		Status:   data["status"].(int),
		Up:       data["up"].(int),
		Pid:      data["pid"].(int64),
		MovieId:  data["movie_id"].(int64),
		ClientIp: data["client_ip"].(string),
	}).Error; err != nil {
		return err
	}

	return nil
}

func (c *MovieCommentModel) EditComment(id int, data map[string]interface{}) bool {
	c.Model(&MovieCommentModel{}).Where("id=?", id).Updates(data)

	return true
}

func (c *MovieCommentModel) DeleteComment(id int) bool {
	c.Where("id=?", id).Delete(&MovieCommentModel{})

	return true
}
