package com.redscarf.admin.modules.sys.service;

import java.util.List;

import com.redscarf.admin.modules.sys.dao.AreaDao;
import com.redscarf.admin.modules.sys.entity.Area;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.redscarf.admin.common.service.TreeService;
import com.redscarf.admin.modules.sys.dao.AreaDao;
import com.redscarf.admin.modules.sys.entity.Area;
import com.redscarf.admin.modules.sys.utils.UserUtils;

/**
 * 区域Service
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {

	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Override
	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
}
