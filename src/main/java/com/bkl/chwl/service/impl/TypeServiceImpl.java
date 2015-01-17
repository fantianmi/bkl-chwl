package com.bkl.chwl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Type;
import com.bkl.chwl.service.TypeService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;

public class TypeServiceImpl implements TypeService {
	GeneralDao<Type> typeDao=DaoFactory.createGeneralDao(Type.class);
	@Override
	public long save(Type type) {
		return typeDao.save(type);
	}

	@Override
	public long update(Type type, long id) {
		return typeDao.update(type,id);
	}

	@Override
	public List<Type> getList(long reid) {
		Condition reidCon=DbUtil.generalEqualWhere("reid", reid);
		return typeDao.findList(new Condition[]{reidCon}, new String[]{"name desc"});
	}

	@Override
	public Type get(long id) {
		return typeDao.find(id);
	}

	@Override
	public long delete(long id) {
		return typeDao.delete(id);
	}

	@Override
	public Map<Long, Type> typeMap() {
		List<Type> types=typeDao.findList();
		Map<Long, Type> map=new HashMap<Long,Type>();
		for(Type t:types){
			map.put(t.getId(), t);
		}
		return map;
	}

}
