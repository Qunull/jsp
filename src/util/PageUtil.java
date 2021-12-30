package util;
//分页工具
public class PageUtil {
    private int pageSize;//页面容量
    private int totalCount;//数据的 总数量
    private int currentPageNo;//当前的页码
    private int tootalPageCount;//总页数

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.setTootalPageCount();
    }

    public int getCurrentPageNo() {
        return currentPageNo;
    }

    public void setCurrentPageNo(int currentPageNo) {
        this.currentPageNo = currentPageNo;
    }

    public int getTotalPageCount() {
        return tootalPageCount;
    }
//根据页面容量和 总数量 计算出 总页码
    private void setTootalPageCount() {
        if (totalCount % pageSize == 0){
            this.tootalPageCount = totalCount / pageSize;
        }else {
            this.tootalPageCount = totalCount / pageSize + 1;
        }
    }


}
