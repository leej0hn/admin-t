package com.redscarf.admin.modules.sys.dao;

import com.redscarf.admin.common.persistence.TreeDao;
import com.redscarf.admin.modules.sys.entity.Office;
import org.apache.ibatis.annotations.Mapper;

/**
 * 机构DAO接口
 *
 * @version 2014-05-16
 */
@Mapper
public interface OfficeDao extends TreeDao<Office> {

}
