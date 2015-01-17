package com.bkl.chwl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.service.AreaService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;

public class AreaServiceImpl implements AreaService {
	GeneralDao<Area> areaDao=DaoFactory.createGeneralDao(Area.class);
	@Override
	public long save(Area area) {
		return areaDao.save(area);
	}

	@Override
	public long update(Area area, long id) {
		return areaDao.update(area,id);
	}

	@Override
	public List<Area> getList(long reid) {
		Condition reidCon=DbUtil.generalEqualWhere("reid", reid);
		return areaDao.findList(new Condition[]{reidCon}, new String[]{"title desc"});
	}

	@Override
	public Area get(long id) {
		return areaDao.find(id);
	}

	@Override
	public long delete(long id) {
		return areaDao.delete(id);
	}

	@Override
	public List<Area> getSecondArea() {
		String sql="select * from area where reid in (select id from area where reid=0) order by reid";
		return areaDao.findList(sql, null);
	}

	@Override
	public Map<Long, Area> areaMap(int reid) {
		Map<Long, Area> map=new HashMap<Long, Area>();
		Condition reidCon=DbUtil.generalEqualWhere("reid", reid);
		List<Area> areas= areaDao.findList(new Condition[]{reidCon}, new String[]{});
		for(Area a:areas){
			map.put(a.getId(), a);
		}
		long temp=0l;
		Area tempArea=new Area();
		tempArea.setId(0);
		tempArea.setReid(0);
		tempArea.setTitle("未设置");
		map.put(temp,tempArea);
		return map;
	}
	public Map<Long, Area> areaMap() {
		Map<Long, Area> map=new HashMap<Long, Area>();
		List<Area> areas= areaDao.findList(new Condition[]{}, new String[]{});
		for(Area a:areas){
			map.put(a.getId(), a);
		}
		long temp=0l;
		Area tempArea=new Area();
		tempArea.setId(0);
		tempArea.setReid(0);
		tempArea.setTitle("未设置");
		map.put(temp,tempArea);
		return map;
	}

	@Override
	public Area get(String title) {
		Condition titleCon=DbUtil.generalEqualWhere("title", title);
		return areaDao.find(new Condition[]{titleCon}, new String[]{});
	}

	@Override
	public Area getSecond(String title) {
		Condition titleCon=DbUtil.generalEqualWhere("title", title);
		Condition reidCon=DbUtil.generalUnEqualWhere("reid", 0);
		return areaDao.find(new Condition[]{titleCon,reidCon}, new String[]{});
	}
	
	@Test
	public void test(){
		Area a=this.getSecond("重庆市");
		System.out.println(a.getId());
		System.out.println(a.getTitle());
		System.out.println(a.getReid());
		
	}

}
