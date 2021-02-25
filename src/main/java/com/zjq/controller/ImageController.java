package com.zjq.controller;

import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class ImageController {

    /**
     * 上传图片
     *
     * @param file
     * @return
     */
    @ResponseBody
    @PostMapping("/uploadImage")
    public Map upload(MultipartFile file, HttpServletRequest request) {

        String prefix = "";
        String dateStr = "";
        //保存上传
        OutputStream out = null;
        InputStream fileInput = null;
        try {
            if (file != null) {
                String originalName = file.getOriginalFilename();
                prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
                Date date = new Date();
                //利用时间毫秒来生成图片新名称，避免重名
                String newName = System.currentTimeMillis() + "." + prefix;
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dateStr = simpleDateFormat.format(date);
                String filepath = "/usr/local/tomcat/webapps/cloudnote/image/uploads/" + dateStr + "/" + newName;

                File files = new File(filepath);
                //打印查看上传路径
                System.out.println(filepath);
                if (!files.getParentFile().exists()) {
                    files.getParentFile().mkdirs();
                }
                //文件压缩
                MultipartFile oldMultipartFile = file;//记录原MultipartFile，如果压缩异常就用原来的MultipartFile
                try {
                    Thumbnails.of(file.getInputStream())
                            .scale(1f)//尺寸不变
                            .outputQuality(0.30f)//质量变为原来的0.3倍
                            .toFile(files);

                } catch (IOException e) {
                    file = oldMultipartFile;
                    file.transferTo(files);//转存文件
                }

                Map<String, Object> map2 = new HashMap<>();
                Map<String, Object> map = new HashMap<>();
                map2.put("src", "https://www.dawnsite.cn:8443/tomcatapp/cloudnote/image/uploads/" + dateStr + "/" + newName);
                map.put("code", 0);
                map.put("msg", "");
                map.put("data", map2);
                return map;
            }

        } catch (Exception e) {
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (fileInput != null) {
                    fileInput.close();
                }
            } catch (IOException e) {
            }
        }
        Map<String, Object> map = new HashMap<>();
        map.put("code", 1);
        map.put("msg", "");
        return map;

    }
}
