package com.bkl.chwl.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.ObjectMetadata;
import com.bkl.chwl.utils.ImageZipUtil;
import com.km.common.servlet.UploadServlet;
import com.km.common.utils.IOUtils;
import com.km.common.vo.RetCode;
import com.km.common.vo.UploadReply;

public class ChwlUploadServlet extends UploadServlet{
	private static final long serialVersionUID = 7280237333692634683L;
	public static final Log LOG = LogFactory.getLog(UploadServlet.class);
	
    private static final String ACCESS_ID = "dtXHc2oFlgmraEI7";
    private static final String ACCESS_KEY = "mxs71m8dd67esKCKWDjw9W9XsqWzZJ";
	
	private String[] blackFileSuffixList = {"css", "js","exe","bat","dll"};
	private String[] whiteSuffixList = null;
	protected String relativeUploadDir = "";
	
	public UploadReply doUploadFile(HttpServletRequest request, HttpServletResponse response, FileItem item) throws Exception
	  {
	    UploadReply uploadReply = new UploadReply();
	    String relativeUploadDir = getUploadDir(request, response);

	    String absoluteUploadDir = request.getServletContext().getRealPath(relativeUploadDir);
	    String uploadDirPath = absoluteUploadDir;

	    String requestFilename = getRequestFileName(item);

	    String suffix = IOUtils.getSuffixFileName(requestFilename);
	    File uploadFile = null;
	    do
	    {
	      String preffixFileName = UUID.randomUUID().toString();
	      uploadFile = new File(uploadDirPath, preffixFileName + "." + suffix);
	    }while (uploadFile.exists());

	    item.write(uploadFile);
	    
	    if(suffix.equals("jpg")||suffix.equals("png")||suffix.equals("gif")){
			ImageZipUtil.zipImageFile(uploadFile,uploadFile, 460, 279, .8f);
			String bucketName =  "dxw-object-img";
	        String image_name = uploadFile.getName();
	        String uploadFilePath = uploadDirPath+"\\"+image_name;
//	        // 使用默认的OSS服务器地址创建OSSClient对象。
	        OSSClient client = new OSSClient(ACCESS_ID, ACCESS_KEY);
	        try {
	        	uploadFile(client, bucketName, image_name, uploadFilePath);
	        }catch(Exception e){
	        	
	        }
		}

	    uploadReply.setCode(RetCode.OK.code());
	    uploadReply.setMsg(RetCode.OK.msg());

	    uploadReply.setRequestFileName(requestFilename);
	    uploadReply.setUploadFileURL(relativeUploadDir + "/" + uploadFile.getName());
	    uploadReply.setUploadFileName(uploadFile.getName());
	    uploadReply.setFileSize(item.getSize());

	    postUploadFile(request, response, uploadReply);
	    return uploadReply;
	  }
	
	private static void uploadFile(OSSClient client, String bucketName, String key, String filename)
            throws OSSException, ClientException, FileNotFoundException {
        File file = new File(filename);

        ObjectMetadata objectMeta = new ObjectMetadata();
        objectMeta.setContentLength(file.length());
        // 可以在metadata中标记文件类型
        objectMeta.setContentType("image/jpeg");

        InputStream input = new FileInputStream(file);
        client.putObject(bucketName, key, input, objectMeta);
    }

}
