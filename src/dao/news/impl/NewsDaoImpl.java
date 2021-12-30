package dao.news.impl;

import dao.BaseDaoImpl;
import dao.news.NewsDao;
import entity.News;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class NewsDaoImpl extends BaseDaoImpl implements NewsDao {
    //根据数据源获取新闻信息
    public void getNewsListByDS() {
        try {
            // 3 获取Statement对象，执行sql语句
            String sql = "select * from news_detail";
            Object[] params = {};
            rs = this.executeSelect(sql, params);
            // 4 处理执行结果集ResultSet
            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String summary = rs.getString("summary");
                String content = rs.getString("content");
                String author = rs.getString("author");
                Timestamp createDate = rs.getTimestamp("createDate");
                System.out.println(id + "\t" + title + "\t" + summary + "\t"
                        + content + "\t" + author + "\t" + createDate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
    }

    // 查询新闻信息
    public List<News> getNewsList(String title,Integer categoryId,int currentPageNo ,int pageSize) {
        List<News> newsList = new ArrayList<>();
        try {
            // 3 获取Statement对象，执行sql语句
            String sql = "select * from news_detail where 1=1 ";
            List<Object> params = new ArrayList<>();
            if (title != null && !title.equals("")){
                sql += " and title like CONCAT('%',?,'%') ";
                params.add(title);
            }
            if (categoryId != null && categoryId !=0){
                sql += " and categoryId = ? ";
                params.add(categoryId);
            }
            /*Object[] params = {};*/
            sql += " limit ?,?";
            System.out.println(sql);
            params.add((currentPageNo-1)*pageSize);
            params.add(pageSize);
            rs = this.executeSelect(sql ,params.toArray());

            // 4 处理执行结果集ResultSet
            while (rs.next()) {
                News news = new News();
                int id = rs.getInt("id");
                String title1 = rs.getString("title");
                String summary = rs.getString("summary");
                String content = rs.getString("content");
                String author = rs.getString("author");
                Timestamp createDate = rs.getTimestamp("createDate");
				/*System.out.println(id + "\t" + title + "\t" + summary + "\t"
						+ content + "\t" + author + "\t" + createDate);*/
                news.setId(id);
                news.setAuthor(author);
                news.setTitle(title1);
                news.setSummary(summary);
                news.setContent(content);
                news.setCreateDate(createDate);
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return newsList;
    }


    @Override
    public int getCount(String title,Integer categoryId) {
        ResultSet rs = null;
        int count = 0;
        String sql = "select count(1) from news_detail where 1=1 ";
        List<Object> params = new ArrayList<>();
        if (title != null && !title.equals("")){
            sql += " and title like CONCAT('%',?,'%') ";
            params.add(title);
        }
        if (categoryId != null && categoryId !=0){
            sql += " and categoryId = ? ";
            params.add(categoryId);
        }
        try {
            rs = executeSelect(sql,params.toArray());
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            this.closeResource();
        }
        return count;
    }

    // 增加新闻信息
    public int add(News news) {
        int count = 0;
        try {
            String sql = "insert into news_detail(id,author,categoryId,title,summary,content,createDate,picPath) values(?,?,?,?,?,?,?,?)";
            Object[] params = {news.getId(), news.getAuthor(), news.getCategoryId(), news.getTitle(), news.getSummary(), news.getContent(), news.getCreateDate(), news.getPicPath()};
            count = this.executeModify(sql, params);
            // 4 处理执行结果
		/*	if (i > 0) {
				System.out.println("插入新闻成功！");
			}*/

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return count;
    }

    // 修改新闻标题
    public int update(News news) {
        int count = 0;
        try {
            String sql = "update news_detail set categoryId=?,title=?," +
                    "author=?,summary=?,content=?,picPath=?,modifyDate=? where" +
                    " id=?";
            /*Object[] params = {news.getTitle(),news.getId()};*/
            count = this.executeModify(sql, news.getCategoryId(), news.getTitle()
                    , news.getAuthor(), news.getSummary(), news.getContent(), news.getPicPath()
                    , news.getModifyDate(), news.getId());
			/*if (i > 0) {
				System.out.println("修改新闻标题成功！");
			}*/
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return count;
    }

    // 删除新闻信息
    public void delete(Integer id) {
        try {
            String sql = "delete from news_detail where id=?";
            /*Object[] params ={news.getId()};*/
            int i = this.executeModify(sql, id);
			/*if (i > 0) {
				System.out.println("删除新闻成功！");
			}*/
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 查找特定标题的新闻信息
    public void getNewsByTitle(News news) {
        try {
            String sql = "select id,title from news_detail where title like ?";
            Object[] params = {"%" + news.getTitle() + "%"};
            rs = this.executeSelect(sql, params);
            while (rs.next()) {
                int id = rs.getInt("id"); // rs.getInt(1);
                String newsTitle = rs.getString("title");

                System.out.println(id + "\t" + newsTitle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
    }

    @Override
    public News getNewsListById(int id) {
        News news = new News();
        try {
            // 3 获取Statement对象，执行sql语句
            String sql = "select * from news_detail where id=?";
            /*Object[] params = {};*/
            rs = this.executeSelect(sql, id);
            // 4 处理执行结果集ResultSet
            while (rs.next()) {
                /*int id = rs.getInt("id");*/
                String title = rs.getString("title");
                String summary = rs.getString("summary");
                String content = rs.getString("content");
                String author = rs.getString("author");
                Timestamp createDate = rs.getTimestamp("createDate");
                int categoryId = rs.getInt("categoryId");
                String picPath = rs.getString("picPath");
                Timestamp modifyDate = rs.getTimestamp("modifyDate");
				/*System.out.println(id + "\t" + title + "\t" + summary + "\t"
						+ content + "\t" + author + "\t" + createDate);*/
                news.setId(id);
                news.setAuthor(author);
                news.setTitle(title);
                news.setSummary(summary);
                news.setContent(content);
                news.setCreateDate(createDate);
                news.setCategoryId(categoryId);
                news.setPicPath(picPath);
                news.setModifyDate(modifyDate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return news;
    }

}
