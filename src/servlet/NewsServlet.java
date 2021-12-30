package servlet;

import com.alibaba.fastjson.JSON;
import com.mysql.cj.util.StringUtils;
import entity.News;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.news.NewsService;
import service.news.impl.NewsServiceImpl;
import util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@WebServlet("/news")
public class NewsServlet extends HttpServlet {
    private NewsService newsService = new NewsServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String opr = request.getParameter("opr");
        if (opr.equals("addNews")) {//调用添加新闻操作
            this.addNews(request, response);
        } else if (opr.equals("newsList")) {
            this.getNewsList(request, response);
        } else if (opr.equals("newsDetail")) {
            getNewsDetail(request,response);
        } else if (opr.equals("toUpdate")){//跳转到修改页面
            toUpdate(request,response);
        }else if (opr.equals("updateNews")){
            updateNews(request,response);
        }
    }

    //新闻的添加操作
    private void addNews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                    } else {//文件类型
                        String fileName = item.getName();//获取文件 的 全文件名
                        //item.getSize();//获取字节数 可以限制大小
                        if (fileName != null && !fileName.equals("")) {//文件名是否重复的问题。 当前时间+随机数+fileName
                            String newFileName = System.currentTimeMillis() + ((int) (Math.random() * 10000000)) + "_file" + fileName.substring(fileName.lastIndexOf("."));
                            File newFile = new File(uploadPath, newFileName);//根据服务器的目录加上文件名的新文件
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
        news.setCreateDate(new Date());
        //执行 添加 操作

        if (newsService.addNews(news)) {//添加成功
            request.getRequestDispatcher(request.getContextPath() + "/jsp/newsDetailList.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/jsp/newsDetailCreateSimple.jsp");
        }
    }

    //新闻列表的展示
    private void getNewsList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pageSizeStr = request.getParameter("pageSize");//页面容量
        String currentPageNoStr = request.getParameter("currentPageNo");//当前页码
        int currentPageNo = currentPageNoStr == null ? 1 : Integer.parseInt(currentPageNoStr);
        int pageSize = pageSizeStr == null ? 2 : Integer.parseInt(pageSizeStr);
        String title = request.getParameter("title");
        if (title == null) {
            title = "";
        }
        String categoryIdStr = request.getParameter("categoryId");
        Integer categoryId = categoryIdStr == null ? 0 : Integer.valueOf(categoryIdStr);
        int totalCount = newsService.getCount(title, categoryId);//总条数
        PageUtil pageUtil = new PageUtil();
        pageUtil.setPageSize(pageSize);
        pageUtil.setCurrentPageNo(currentPageNo);
        pageUtil.setTotalCount(totalCount);
        int totalPageCount = pageUtil.getTotalPageCount();//总页数
        //对首页 和 末页 进行控制
        if (currentPageNo <= 1) {
            currentPageNo = 1;
        }
        if (currentPageNo > totalPageCount) {
            currentPageNo = totalPageCount;
        }
        //调用业务层读取数据
        List<News> newsList = newsService.getNewsList(title, categoryId, currentPageNo, pageSize);
        //封装数据 提供给JSP页面 -- 使用EL表达式
        request.setAttribute("newsList", newsList);
        //session.setAttribute("newsList", newsList);
        request.setAttribute("title", title); // 用于标题条件的回显
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("currentPageNo", currentPageNo);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("totalPageCount", totalPageCount);
        //设置显示数据的页面
        request.getRequestDispatcher(request.getContextPath() + "/jsp/newsDetailList.jsp").forward(request, response);
    }

    private News getNewsById(HttpServletRequest request, HttpServletResponse response){
        //获取参数
        String nid = request.getParameter("id");
        Integer id = null;
        if (!StringUtils.isNullOrEmpty(nid)){
            id = Integer.valueOf(nid);
        }
        //调用业务层的 业务方法
        News news = newsService.getNewsListById(id);
        return news;
    }

    //根据 新闻的id查询 询问详情信息
    private void getNewsDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        News news = getNewsById(request,response);
        request.setAttribute("news",news);
        //页面的跳转
        request.getRequestDispatcher(request.getContextPath()+"/jsp/newsDetailView.jsp").forward(request,response);
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        News news = getNewsById(request,response);
        request.setAttribute("news",news);
        //页面的跳转
        request.getRequestDispatcher(request.getContextPath()+"/jsp/adminNewsUpdate.jsp").forward(request,response);
    }

    //修改信息后 保存操作
    private void updateNews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String categoryId = request.getParameter("categoryId");
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String newscontent = request.getParameter("newscontent");
        String author = request.getParameter("author");
        //做一个 新闻对象
        String nid = request.getParameter("id");
        Integer id = null;
        if (!StringUtils.isNullOrEmpty(nid)){
            id = Integer.valueOf(nid);
        }
        News news = newsService.getNewsListById(id);
        news.setTitle(title);
        news.setContent(newscontent);
        news.setAuthor(author);
        news.setSummary(summary);
        news.setCreateDate(new Date());
        news.setCategoryId(Integer.valueOf(categoryId));
        //执行 添加 操作
        if(newsService.updateNews(news)){//添加成功
            response.sendRedirect(request.getContextPath()+"/jsp/newsDetailList.jsp");
        }else {
            request.getRequestDispatcher(request.getContextPath()+"/jsp/adminNewsUpdate.jsp").forward(request,response);
        }
    }

    private void getNewsList2 (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //   NewsService newsService = new NewsServiceImpl(); //生成service对象
        /*页面容量*/
        NewsService newsService = new NewsServiceImpl();
        String  pageSizeStr = request.getParameter("pageSize");
        /*当前页码*/
        String  currentPageNoStr = request.getParameter("currentPageNo");
        String title = request.getParameter("title");
        if (title == null){
            title = "";
        }

        int currentPageNo = currentPageNoStr == null?1: Integer.parseInt(currentPageNoStr);
        int pageSize = pageSizeStr == null?2: Integer.parseInt(pageSizeStr);
        /*总条数*/
        String categoryIdStr = request.getParameter("categoryId");
        Integer categoryId = categoryIdStr == null?0: Integer.parseInt(categoryIdStr);
        int totalCount = newsService.getCount(title,categoryId);
        PageUtil pageUtil = new PageUtil();
        pageUtil.setPageSize(pageSize);
        pageUtil.setCurrentPageNo(currentPageNo);
        pageUtil.setTotalCount(totalCount);
        /*总页数*/
        int totalPageCount = pageUtil.getTotalPageCount();
        /*对首页 和 末页 进行控制*/
        if (currentPageNo < 1){
            currentPageNo = 1;
        }
        if (currentPageNo > totalPageCount){
            currentPageNo = totalPageCount;
        }
        /*调用业务层 获取数据*/
        List<News> newsList = newsService.getNewsList(title,categoryId,currentPageNo,pageSize);
        /*封装数据 提供给JSP页面 借助EL表达式*//*
        request.setAttribute("newsList",newsList);
        *//*用于标题 条件的回显*//*
        request.setAttribute("title",title);
        *//*用户 新闻类型 的回显*//*
        request.setAttribute("categoryId",categoryId);
        request.setAttribute("currentPageNo",currentPageNo);
        request.setAttribute("totalCount",totalCount);
        request.setAttribute("totalPageCount",totalPageCount);
        *//*设置显示数据的页面*//*
        request.getRequestDispatcher(request.getContextPath()+"/Jsp/newsDetailList.jsp").forward(request,response);*/

        String newsListJson = JSON.toJSONString(newsList);
        PrintWriter out = response.getWriter();
        out.print(newsListJson);
        out.flush();
        out.close();

    }
}

