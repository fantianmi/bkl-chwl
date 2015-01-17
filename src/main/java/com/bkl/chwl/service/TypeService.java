package com.bkl.chwl.service;

import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Type;

public interface TypeService {
	public long save(Type type);
	public long update(Type type,long id);
	public Map<Long,Type> typeMap();
	//need update
	public List<Type> getList(long reid);
	public Type get(long id);
	public long delete(long id);
}
