package com.redscarf.admin.modules.sys.dao;

import com.redscarf.admin.common.persistence.CrudDao;
import com.redscarf.admin.modules.sys.entity.Dict;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 字典DAO接口
 *
 * @version 2014-05-16
 */
@Mapper
public interface DictDao extends CrudDao<Dict> {

    List<String> findTypeList(Dict dict);

}
