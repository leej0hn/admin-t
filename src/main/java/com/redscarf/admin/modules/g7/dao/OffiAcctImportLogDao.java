package com.redscarf.admin.modules.g7.dao;

import com.redscarf.admin.common.persistence.CrudDao;
import com.redscarf.admin.modules.g7.entity.OffiAcctImportLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * 公众号导入日志生成DAO接口
 * @author LeeJohn
 * @version 2016-11-17
 */
@Mapper
public interface OffiAcctImportLogDao extends CrudDao<OffiAcctImportLog> {

    /**
     * 通过batchId获取条数
     * @return
     */
    Integer findBatchDayCount(OffiAcctImportLog offiAcctImportLog);
}