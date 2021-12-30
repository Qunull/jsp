package service.news;

import entity.News;

import java.util.List;

public interface NewsService {
    List<News> getNewsList(String title,Integer categoryId,int currentPageNo,int pageSize);//新闻业务  接口
    boolean addNews(News news);
    boolean updateNews(News news);
    News getNewsListById(int id);
    void delete(Integer id);
    int getCount(String title,Integer categoryId);//查询新闻数量
}
