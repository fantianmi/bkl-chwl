package com.bkl.chwl.vo;

import com.bkl.chwl.vo.SellLog;
import java.util.List;
public class SellLogEntity
{
  private List<SellLog> list;
  private boolean hasNext;

  public List<SellLog> getList()
  {
    return this.list;
  }

  public void setList(List<SellLog> list) {
    this.list = list;
  }

  public boolean isHasNext()
  {
    return this.hasNext;
  }

  public void setHasNext(boolean hasNext) {
    this.hasNext = hasNext;
  }
}