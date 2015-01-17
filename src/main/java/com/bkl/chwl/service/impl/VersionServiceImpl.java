package com.bkl.chwl.service.impl;

import java.util.Map;

import com.bkl.chwl.entity.Version;
import com.bkl.chwl.service.VersionService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public class VersionServiceImpl implements VersionService {
	GeneralDao<Version> versionDao=DaoFactory.createGeneralDao(Version.class);
	@Override
	public long saveVersion(Version version) {
		return versionDao.save(version);
	}

	@Override
	public Version getLatestVersion(int apktype) {
		Condition apkTypeCon=DbUtil.generalEqualWhere("apktype", apktype);
		return versionDao.find(new Condition[]{apkTypeCon}, new String[]{"id desc"});
	}

	@Override
	public long modifyVersion(long id, Version version) {
		return versionDao.update(version, id);
	}

	@Override
	public PageReply<Version> getVersionList(Page page,Map  searchMap) {
		return versionDao.getPage(page, new Condition[]{}, new String[]{"apktype desc,id desc"});
	}

	@Override
	public long deleteVersion(long id) {
		return versionDao.delete(id);
	}

}
