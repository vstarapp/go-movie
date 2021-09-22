package model

import (
	"encoding/json"
	"errors"
	"go-movie/app/global/variable"
	"go-movie/app/service/download_file"
	"sync"
	"time"

	"go.uber.org/zap"
	"gorm.io/gorm"
)

func CreateMovieFactory(sqlType string) *MovieModel {
	return &MovieModel{DB: UseDbConn(sqlType)}
}

type MovieModel struct {
	*gorm.DB       `gorm:"-" json:"-"`
	Id             int64   `gorm:"column:mov_id;primarykey" json:"id"`
	Title          string  `gorm:"column:mov_title" json:"title"`
	Area           string  `gorm:"column:mov_area" json:"area"`
	Category       string  `gorm:"column:mov_category" json:"category"`
	Language       string  `gorm:"column:mov_language" json:"language"`
	Year           int64   `gorm:"column:mov_year" json:"year"`
	Cover          string  `gorm:"column:mov_cover" json:"cover"`
	Display        int64   `gorm:"column:mov_display" json:"display"`
	Position       int64   `gorm:"column:mov_position" json:"position"`
	Up             int64   `gorm:"column:mov_up" json:"up"`
	Down           int64   `gorm:"column:mov_down" json:"down"`
	Alias          string  `gorm:"column:mov_alias" json:"alias"`
	Hits           int64   `gorm:"column:mov_hits" json:"hits"`
	Rate           float64 `gorm:"column:mov_rate" json:"rate"`
	RatingCount    int64   `gorm:"column:mov_rating_count" json:"rating_count"`
	Directors      string  `gorm:"column:mov_directors" json:"directors"`
	ScreenWriters  string  `gorm:"column:mov_screen_writers" json:"screen_writers"`
	Actors         string  `gorm:"column:mov_actors" json:"actors"`
	Serialize      string  `gorm:"column:mov_serialize" json:"serialize"`
	Status         int64   `gorm:"column:mov_status" json:"status"`
	ResourceUrl    string  `gorm:"column:mov_resource_url" json:"resource_url"`
	Duration       string  `gorm:"column:mov_duration" json:"duration"`
	Pubdate        string  `gorm:"column:mov_pubdate" json:"pubdate"`
	Pinyin         string  `gorm:"column:mov_pinyin" json:"pinyin"`
	FavoritesCount int64   `gorm:"column:mov_favorites_count" json:"favorites_count"`
	CreatedAt      int     `gorm:"column:mov_created_at" json:"created_at"`
	UpdatedAt      int     `gorm:"column:mov_updated_at" json:"updated_at"`
}

func (m *MovieModel) TableName() string {
	return "tb_movie"
}

func (m *MovieModel) GetMovies(PageNum int, PageSize int, maps interface{}) (movies []*MovieModel) {
	m.Where(maps).Offset(PageNum).Limit(PageSize).Find(&movies)

	return
}

func (m *MovieModel) GetMovie(id int64) interface{} {
	type Result struct {
		Id            int64       `json:"id"`
		Title         string      `json:"title"`
		Alias         string      `json:"alias"`
		Cover         string      `json:"cover"`
		Rate          float64     `json:"rate"`
		Directors     interface{} `json:"directors"`
		ScreenWriters interface{} `json:"screen_writers"`
		Actors        interface{} `json:"actors"`
		Category      interface{} `json:"category"`
		Area          string      `json:"area"`
		Language      string      `、json:"language"`
		Year          int64       `json:"year"`
		Duration      string      `json:"duration"`
		CreatedAt     string      `json:"created_at"`
	}
	var result *Result
	rows, err := m.Model(&MovieModel{}).Select([]string{"mov_id", "mov_title", "mov_alias", "mov_cover", "mov_rate", "mov_directors", "mov_screen_writers", "mov_actors", "mov_category", "mov_area", "mov_language", "mov_year", "mov_duration", "mov_created_at"}).Where("mov_id=?", id).Rows()
	// 凡是查询类记得释放记录集
	defer rows.Close()
	if err == nil && rows != nil {
		for rows.Next() {
			var id, year, created_at int64
			var rate float64
			var title, alias, cover, directors, screenWriters, actors, category, area, language, duration string
			err := rows.Scan(&id, &title, &alias, &cover, &rate, &directors, &screenWriters, &actors, &category, &area, &language, &year, &duration, &created_at)
			if err == nil {
				var directorsJson interface{}
				if err3 := json.Unmarshal([]byte(directors), &directorsJson); err3 != nil {
					variable.ZapLog.Error("解析电影导演失败:", zap.Error(err3))
				}
				var screenWritersJson interface{}
				if err3 := json.Unmarshal([]byte(screenWriters), &screenWritersJson); err3 != nil {
					variable.ZapLog.Error("解析电影编剧失败:", zap.Error(err3))
				}
				var actorsJson interface{}
				if err2 := json.Unmarshal([]byte(actors), &actorsJson); err2 != nil {
					variable.ZapLog.Error("解析电影演员失败:", zap.Error(err2))
				}
				var categoryJson interface{}
				if err3 := json.Unmarshal([]byte(category), &categoryJson); err3 != nil {
					variable.ZapLog.Error("解析电影类型失败:", zap.Error(err3))
				}

				result = &Result{
					Id:            id,
					Title:         title,
					Alias:         alias,
					Cover:         cover,
					Rate:          rate,
					Directors:     directorsJson,
					ScreenWriters: screenWritersJson,
					Actors:        actorsJson,
					Category:      categoryJson,
					Area:          area,
					Language:      language,
					Year:          year,
					Duration:      duration,
					CreatedAt:     time.Unix(created_at, 0).Format("2006-01-02 15:04:05"),
				}
			}
		}
	}
	return result
}

// 获取评分Top10
func (m *MovieModel) GetTop10(PageNum int, PageSize int, maps interface{}) interface{} {
	type Result struct {
		Id    int64   `gorm:"column:mov_id" json:"id"`
		Title string  `gorm:"column:mov_title" json:"title"`
		Rate  float64 `gorm:"column:mov_rate" json:"rate"`
	}
	var result []*Result
	m.Debug().Model(&MovieModel{}).Select([]string{"mov_id", "mov_title", "mov_rate"}).Joins("left join tb_movie_category on mct_id=mov_id").Where(maps).Offset(PageNum).Limit(PageSize).Order("mov_rate DESC").Find(&result)

	return result
}

// 获取最近更新
func (m *MovieModel) GetLatelyOfAll(PageNum int, PageSize int, maps interface{}) interface{} {
	type Result struct {
		Id        int64       `json:"id"`
		Title     string      `json:"title"`
		Cover     string      `json:"cover"`
		Rate      float64     `json:"rate"`
		Category  interface{} `json:"category"`
		CreatedAt string      `json:"created_at"`
	}
	var result []*Result
	rows, err := m.Model(&MovieModel{}).Select([]string{"mov_id", "mov_title", "mov_cover", "mov_rate", "mov_category", "mov_created_at"}).Where(maps).Offset(PageNum).Limit(PageSize).Order("mov_created_at DESC").Rows()
	// 凡是查询类记得释放记录集
	defer rows.Close()
	if err == nil && rows != nil {
		for rows.Next() {
			var id, created_at int64
			var rate float64
			var title, cover, category string
			err := rows.Scan(&id, &title, &cover, &rate, &category, &created_at)
			if err == nil {
				var tempJson interface{}
				if err2 := json.Unmarshal([]byte(category), &tempJson); err2 == nil {
					result = append(result, &Result{
						Id:        id,
						Title:     title,
						Cover:     cover,
						Rate:      rate,
						Category:  tempJson,
						CreatedAt: time.Unix(created_at, 0).Format("2006-01-02 15:04:05"),
					})
				}
			}
		}
	}
	return result
}

// 根据类型获取最近更新
func (m *MovieModel) GetLatelyByType(PageNum int, PageSize int, maps interface{}) interface{} {
	type Result struct {
		Id        int64       `json:"id"`
		Title     string      `json:"title"`
		Cover     string      `json:"cover"`
		Rate      float64     `json:"rate"`
		Category  interface{} `json:"category"`
		CreatedAt string      `json:"created_at"`
		Area      string      `json:"area"`
		Year      int64       `json:"year"`
	}
	var result []*Result
	rows, err := m.Model(&MovieModel{}).Select([]string{"mov_id", "mov_title", "mov_cover", "mov_rate", "mov_category", "mov_created_at", "mov_area", "mov_year"}).Joins("left join tb_movie_category on mct_id=mov_id").Where(maps).Offset(PageNum).Limit(PageSize).Order("mov_created_at DESC").Rows()
	// 凡是查询类记得释放记录集
	defer rows.Close()
	if err == nil && rows != nil {
		for rows.Next() {
			var id, created_at, year int64
			var rate float64
			var title, cover, category, area string
			err := rows.Scan(&id, &title, &cover, &rate, &category, &created_at, &area, &year)
			if err == nil {
				var tempJson interface{}
				if err2 := json.Unmarshal([]byte(category), &tempJson); err2 == nil {
					result = append(result, &Result{
						Id:        id,
						Title:     title,
						Cover:     cover,
						Rate:      rate,
						Category:  tempJson,
						CreatedAt: time.Unix(created_at, 0).Format("2006-01-02 15:04:05"),
						Area:      area,
						Year:      year,
					})
				}
			}
		}
	}
	return result
}

// 根据类型获取最近更新
func (m *MovieModel) GetLists(PageNum int, PageSize int, order string, maps map[string]interface{}) interface{} {
	type Result struct {
		Id        int64       `json:"id"`
		Title     string      `json:"title"`
		Cover     string      `json:"cover"`
		Rate      float64     `json:"rate"`
		Category  interface{} `json:"category"`
		CreatedAt string      `json:"created_at"`
		Area      string      `json:"area"`
		Year      int64       `json:"year"`
	}
	var result []*Result
	tx := m.Model(&MovieModel{})
	tx.Select([]string{"mov_id", "mov_title", "mov_cover", "mov_rate", "mov_category", "mov_created_at", "mov_area", "mov_year"})
	if title, ok := maps["mov_title"]; ok {
		tx.Where("mov_title LIKE ?", "%"+title.(string)+"%")
		delete(maps, "mov_title")
	}
	tx.Joins("left join tb_movie_category on mct_id=mov_id")
	tx.Where(maps).Offset(PageNum).Limit(PageSize).Order(order)

	rows, err := tx.Rows()
	// 凡是查询类记得释放记录集
	defer rows.Close()
	if err == nil && rows != nil {
		for rows.Next() {
			var id, created_at, year int64
			var rate float64
			var title, cover, category, area string
			err := rows.Scan(&id, &title, &cover, &rate, &category, &created_at, &area, &year)
			if err == nil {
				var tempJson interface{}
				if err2 := json.Unmarshal([]byte(category), &tempJson); err2 == nil {
					result = append(result, &Result{
						Id:        id,
						Title:     title,
						Cover:     cover,
						Rate:      rate,
						Category:  tempJson,
						CreatedAt: time.Unix(created_at, 0).Format("2006-01-02 15:04:05"),
						Area:      area,
						Year:      year,
					})
				}
			}
		}
	}
	return result
}

func (m *MovieModel) GetMovieTotalByType(maps map[string]interface{}) (count int64) {
	tx := m.Model(&MovieModel{})
	tx.Joins("left join tb_movie_category on mct_id=mov_id")
	if title, ok := maps["mov_title"]; ok {
		tx.Where("mov_title LIKE ?", "%"+title.(string)+"%")
		delete(maps, "mov_title")
	}
	tx.Where(maps).Count(&count)

	return
}

func (m *MovieModel) GetMovieTotal(maps interface{}) (count int64) {
	m.Model(&MovieModel{}).Where(maps).Count(&count)

	return
}

func (m *MovieModel) AddMovie(data map[string]interface{}) error {
	var maps = make(map[string]interface{})
	var movieCategory []MovieCategoryModel
	var categorySlice []map[string]interface{}
	var movieUrl []MovieUrlModel
	categoryFact := CreateCategoryFactory("")

	for _, val := range data["category"].([]interface{}) {
		maps["cat_title"] = val
		category := categoryFact.GetOne(maps)
		if category.Id <= 0 {
			return errors.New("类型不存在")
		}
		var categoryMaps = make(map[string]interface{})
		categoryMaps["id"] = category.Id
		categoryMaps["name"] = val
		categorySlice = append(categorySlice, categoryMaps)
	}
	categoryByte, _ := json.Marshal(categorySlice)
	directorsByte, _ := json.Marshal(data["directors"])
	screenWritersByte, _ := json.Marshal(data["screen_writers"])
	actorsByte, _ := json.Marshal(data["actors"])
	var movie = &MovieModel{
		Title:          data["title"].(string),
		Area:           data["area"].(string),
		Category:       string(categoryByte),
		Language:       data["language"].(string),
		Year:           data["year"].(int64),
		Cover:          data["cover"].(string),
		Display:        data["display"].(int64),
		Position:       data["position"].(int64),
		Up:             data["up"].(int64),
		Down:           data["down"].(int64),
		Alias:          data["alias"].(string),
		Hits:           data["hits"].(int64),
		Rate:           data["rate"].(float64),
		RatingCount:    data["rating_count"].(int64),
		Directors:      string(directorsByte),
		ScreenWriters:  string(screenWritersByte),
		Actors:         string(actorsByte),
		Serialize:      data["serialize"].(string),
		ResourceUrl:    data["resource_url"].(string),
		Duration:       data["duration"].(string),
		Pubdate:        data["pubdate"].(string),
		Pinyin:         data["pinyin"].(string),
		FavoritesCount: data["favorites_count"].(int64),
	}

	err := m.Transaction(func(tx *gorm.DB) error {
		// 在事务中执行一些 db 操作（从这里开始，您应该使用 'tx' 而不是 'db'）
		if err := tx.Create(movie).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}
		for _, item := range categorySlice {
			movieCategory = append(movieCategory, MovieCategoryModel{
				CategoryId: item["id"].(int64),
				MovieId:    movie.Id,
			})
		}
		if err := tx.Create(&movieCategory).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}

		if err := tx.Create(&MovieTextModel{
			MovieId: movie.Id,
			Content: data["content"].(string),
		}).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}

		for _, val := range data["movie_url"].([]interface{}) {
			item, _ := val.(map[string]interface{})
			movieUrl = append(movieUrl, MovieUrlModel{
				Title:    item["title"].(string),
				MovieUrl: item["url"].(string),
				MovieId:  movie.Id,
			})
		}
		if err := tx.Create(&movieUrl).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}
		go m.downloadCover(int(movie.Id), data["cover"].(string))
		// 返回 nil 提交事务
		return nil
	})
	return err
}

func (m *MovieModel) ExistMovie(maps interface{}) bool {
	var movie MovieModel
	m.Select("mov_id").Where(maps).First(&movie)
	if movie.Id > 0 {
		return true
	}

	return false
}

// 根据rul地址下载图片
func (m *MovieModel) downloadCover(id int, url string) {
	var saveFilePath = make(chan string)
	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		defer wg.Done()
		savePath := variable.BasePath + variable.ConfigYml.GetString("FileUploadSetting.UploadFileSavePath")
		if r, finnalSavePath := download_file.Down(url, savePath); r == true {
			saveFilePath <- finnalSavePath.(string)
		} else {
			saveFilePath <- ""
		}
	}()
	go func() {
		wg.Wait()
		close(saveFilePath)
	}()
	for path := range saveFilePath {
		var data = make(map[string]interface{})
		data["mov_cover"] = path
		m.Model(&MovieModel{}).Where("mov_id = ?", id).Updates(data)
	}
}
