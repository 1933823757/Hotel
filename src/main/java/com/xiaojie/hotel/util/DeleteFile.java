package com.xiaojie.hotel.util;

import java.io.File;

/*
    删除文件类
 */
public class DeleteFile {
    public static void deleteFile(String fileName){
            String [] imgname =fileName.split(";");
            for(int i=0;i<imgname.length;i++){
                if (imgname[i] !=null){
                    File f = new File("D://Java-Webxiangmu//hotel//src//main//webapp//"+imgname[i]);
                    if (f.exists()){
                        //说明存在文件
                        f.delete();
                        System.out.println(imgname[i]+"---------文件已删除");
                    }else{
                        System.out.println(imgname[i]+"============文件不存在");
                    }
                }

            }


    }
}
