package service.news.impl;

import dao.news.NewsDao;
import dao.news.impl.NewsDaoImpl;
import entity.News;
import service.news.NewsService;

import java.util.List;

public class NewsServiceImpl implements NewsService {
    //新闻业务实现类
    private NewsDao newsDao;

    public NewsServiceImpl(){
        newsDao = new NewsDaoImpl();
    }

    @Override
    public List<News> getNewsList(String title,Integer categoryId,int currentPageNo,int pageSize) {
        return newsDao.getNewsList(title,categoryId,currentPageNo,pageSize);
    }

    @Override
    public boolean addNews(News news) {
        if (newsDao.add(news) > 0){
            return true;
        }
        return false;
    }

    @Override
    public boolean updateNews(News news) {
        if (newsDao.update(news) > 0) {
            return true;
        }
        return false;
    }

    @Override
    public News getNewsListById(int id) {
        return newsDao.getNewsListById(id);
    }

    @Override
    public void delete(Integer id) {
        newsDao.delete(id);
    }

    @Override
    public int getCount(String title,Integer categoryId) {
        return newsDao.getCount(title,categoryId);
    }
}
