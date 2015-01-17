package com.bkl.chwl.service;

import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Area;

public interface AreaService {
	public long save(Area area);
	public long update(Area area,long id);
	//need update
	public List<Area> getList(long reid);
	public Area get(long id);
	public Area get(String title);
	public Area getSecond(String title);
	public long delete(long id);
	//获得二级城市
	public List<Area> getSecondArea();
	public Map<Long,Area> areaMap(int reid);
	public Map<Long,Area> areaMap();
}
