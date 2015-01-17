package com.bkl.chwl.service;

import java.util.Map;

import com.bkl.chwl.entity.Version;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public interface VersionService {
	public long saveVersion(Version version);
	public Version getLatestVersion(int apktype);
	public long modifyVersion(long id,Version version);
	public PageReply<Version>  getVersionList(Page page,Map  searchMap);
	public long deleteVersion(long id);
}
