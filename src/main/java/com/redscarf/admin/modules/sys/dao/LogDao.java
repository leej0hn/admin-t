package com.redscarf.admin.modules.sys.dao;

import com.redscarf.admin.common.persistence.CrudDao;
import com.redscarf.admin.modules.sys.entity.Log;
import org.apache.ibatis.annotations.Mapper;

/**
 * 日志DAO接口
 *
 */
@Mapper
public interface LogDao extends CrudDao<Log> {

}
