package com.redscarf.admin.modules.sys.service;

import java.util.List;

import com.redscarf.admin.modules.sys.dao.DictDao;
import com.redscarf.admin.modules.sys.entity.Dict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.redscarf.admin.common.service.CrudService;
import com.redscarf.admin.common.utils.CacheUtils;
import com.redscarf.admin.modules.sys.dao.DictDao;
import com.redscarf.admin.modules.sys.entity.Dict;
import com.redscarf.admin.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Override
	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

}
