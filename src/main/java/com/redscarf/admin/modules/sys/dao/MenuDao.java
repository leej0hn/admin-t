package com.redscarf.admin.modules.sys.dao;

import com.redscarf.admin.common.persistence.CrudDao;
import com.redscarf.admin.modules.sys.entity.Menu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 菜单DAO接口
 *
 * @version 2014-05-16
 */
@Mapper
public interface MenuDao extends CrudDao<Menu> {

    List<Menu> findByParentIdsLike(Menu menu);

    List<Menu> findByUserId(Menu menu);

    int updateParentIds(Menu menu);

    int updateSort(Menu menu);

}
