package download_file

import (
	"bufio"
	"errors"
	"fmt"
	"go-movie/app/global/my_errors"
	"go-movie/app/global/variable"
	"go-movie/app/utils/md5_encrypt"
	"io"
	"net/http"
	"os"
	"path"
	"strings"
	"time"
)

func Down(url string, savePath string) (r bool, finnalSavePath interface{}) {

	newSavePath := generateYearMonthPath(savePath)

	//  保存文件，原始文件名进行全局唯一编码加密、md5 加密，保证在后台存储不重复
	var saveErr error
	if sequence := variable.SnowFlake.GetId(); sequence > 0 {
		saveFileName := fmt.Sprintf("%d%s", sequence, ".jpg")
		saveFileName = md5_encrypt.MD5(saveFileName) + path.Ext(saveFileName)
		err := down(url, newSavePath+saveFileName)
		if err != nil {
			return false, nil
		}
		finnalSavePath = strings.ReplaceAll(newSavePath+saveFileName, variable.BasePath, "")
		return true, finnalSavePath
	} else {
		saveErr = errors.New(my_errors.ErrorsSnowflakeGetIdFail)
		variable.ZapLog.Error("文件保存出错：" + saveErr.Error())
	}
	return false, nil

}
func down(url string, filename string) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	out, err := os.Create(filename)
	wt := bufio.NewWriter(out)

	defer out.Close()
	_, err = io.Copy(wt, resp.Body)
	if err != nil {
		variable.ZapLog.Error("下载文件出错：" + err.Error())
		return err
	}
	wt.Flush()
	return nil
}

// 文件上传可以设置按照 xxx年-xx月 格式存储
func generateYearMonthPath(savePathPre string) string {
	curYearMonth := time.Now().Format("2006_01")
	newSavePathPre := savePathPre + curYearMonth
	// 相关路径不存在，创建目录
	if _, err := os.Stat(newSavePathPre); err != nil {
		if err = os.MkdirAll(newSavePathPre, os.ModePerm); err != nil {
			variable.ZapLog.Error("文件下载创建目录出错" + err.Error())
			return ""
		}
	}
	return newSavePathPre + "/"
}
