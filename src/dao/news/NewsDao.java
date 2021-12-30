package dao.news;


import entity.News;

import java.util.List;

public interface NewsDao {
	//根据数据源获取新闻信息
	public void getNewsListByDS() ;

	// 查询新闻信息
	public List<News> getNewsList(String title,Integer categoryId,int currentPageNo,int pageSize);

	//查询新闻数量
	 int getCount(String title,Integer categoryId);


	// 增加新闻信息
	public int add(News news) ;
	// 修改新闻标题
	public int update(News news);
	// 删除新闻信息
	public void delete(Integer id);

	// 查找特定标题的新闻信息
	public void getNewsByTitle(News news);

	// 查询新闻信息
	 News getNewsListById(int id);


}
