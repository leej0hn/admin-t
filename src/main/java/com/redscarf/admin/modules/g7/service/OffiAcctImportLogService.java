package com.redscarf.admin.modules.g7.service;

import com.redscarf.admin.common.persistence.Page;
import com.redscarf.admin.common.service.CrudService;
import com.redscarf.admin.modules.g7.dao.OffiAcctImportLogDao;
import com.redscarf.admin.modules.g7.entity.OffiAcctImportLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 公众号导入日志生成Service
 * @author LeeJohn
 * @version 2016-11-17
 */
@Service
@Transactional(readOnly = true)
public class OffiAcctImportLogService extends CrudService<OffiAcctImportLogDao, OffiAcctImportLog> {

	@Autowired
	private OffiAcctImportLogDao offiAcctImportLogDao;

	public OffiAcctImportLog get(String id) {
		return super.get(id);
	}
	
	public List<OffiAcctImportLog> findList(OffiAcctImportLog offiAcctImportLog) {
		return super.findList(offiAcctImportLog);
	}
	
	public Page<OffiAcctImportLog> findPage(Page<OffiAcctImportLog> page, OffiAcctImportLog offiAcctImportLog) {
		return super.findPage(page, offiAcctImportLog);
	}
	
	@Transactional(readOnly = false)
	public void save(OffiAcctImportLog offiAcctImportLog) {
		super.save(offiAcctImportLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(OffiAcctImportLog offiAcctImportLog) {
		super.delete(offiAcctImportLog);
	}

	public Integer  findBatchDayCount(OffiAcctImportLog offiAcctImportLog){
		return offiAcctImportLogDao.findBatchDayCount(offiAcctImportLog);
	}
}