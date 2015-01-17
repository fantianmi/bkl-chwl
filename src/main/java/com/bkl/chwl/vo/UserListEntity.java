package com.bkl.chwl.vo;

import java.util.List;

import com.baiyi.data.model.User2;

public class UserListEntity
{
  private List<User2> list;
  private int total;

  public List<User2> getList()
  {
    return this.list;
  }

  public void setList(List<User2> list) {
    this.list = list;
  }

  public int getTotal() {
    return this.total;
  }

  public void setTotal(int total) {
    this.total = total;
  }
}
