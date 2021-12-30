<%@ page import="entity.News" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../common/common.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    //做一个 新闻对象
    News news = new News();

    //1.检查 请求request的类型 是否是多类型 请求
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    //2.目前（项目路径）-设置服务器保存 文件的目录
    String uploadPath = request.getSession().getServletContext().getRealPath("uploadFile");
    File file = new File(uploadPath);
    if (!file.exists()) {//取反 --不存在
        file.mkdirs();//如果，没有，创建
    }
    if (isMultipart) {//确定为 多类型
        //3. 声明 文件上传对象
        FileItemFactory factory = new DiskFileItemFactory();//实列化一个 Disk硬盘工厂 帮我实列ServletFileUpload
        ServletFileUpload sfu = new ServletFileUpload(factory);//文件上传对象 可以解析 请求
        //4.转换请求对象
        List<FileItem> itemList = null;
        try {
            itemList = sfu.parseRequest(request);//解析请求 获取文件目录结构
            Iterator<FileItem> itemIterator = itemList.iterator();
            while (itemIterator.hasNext()) {
                FileItem item = itemIterator.next();
                if (item.isFormField()) {//是否是表单的 普通控件 比如 input select textarea buttom
                    String fieldName = item.getFieldName();
                    if (fieldName.equals("title")) {//判断类型是不是Title
                        news.setTitle(item.getString("UTF-8"));//按照字符集获取指定的内容 filedName 的 值
                    } else if (fieldName.equals("summary")) {
                        news.setSummary(item.getString("UTF-8"));
                    } else if (fieldName.equals("categorId")) {
                        news.setCategoryId(Integer.parseInt(item.getString()));
                    } else if (fieldName.equals("author")) {
                        news.setAuthor(item.getString("UTF-8"));
                    } else if (fieldName.equals("newscontent")) {
                        news.setContent(item.getString("UTF-8"));
                    }
                }else {//文件类型
                    String fileName = item.getName();//获取文件 的 全文件名
                    //item.getSize();//获取字节数 可以限制大小
                    if (fileName != null && !fileName.equals("")){//文件名是否重复的问题。 当前时间+随机数+fileName
                        String newFileName = System.currentTimeMillis()+((int)(Math.random()*10000000))+"_file"+fileName.substring(fileName.lastIndexOf("."));
                        File newFile = new File(uploadPath ,newFileName);//根据服务器的目录加上文件名的新文件
                        try {
                            item.write(newFile);//数据传递，从本地文件 上传 服务器的文件中
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        //将服务器得到 文件目录 保存到相应的字段中
                        String picPath = "uploadFile" + File.separator + newFileName;//file.separator 获取当前系统的分隔符
                        news.setPicPath(picPath);
                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
    }


   /* String categoryId = request.getParameter("categoryId");
    String title = request.getParameter("title");
    String summary = request.getParameter("summary");
    String newscontent = request.getParameter("newscontent");
    String author = request.getParameter("author");*/

  /*  news.setTitle(title);
    news.setContent(newscontent);
    news.setAuthor(author);
    news.setSummary(summary);

    news.setCategoryId(Integer.valueOf(categoryId));*/

    news.setCreateDate(new Date());
    //执行 添加 操作
    if (newsService.addNews(news)) {//添加成功
%>
<jsp:forward page="newsDetailList.jsp"></jsp:forward>
<%
    } else {
        response.sendRedirect("newsDetailCreateSimple.jsp");
    }
%>