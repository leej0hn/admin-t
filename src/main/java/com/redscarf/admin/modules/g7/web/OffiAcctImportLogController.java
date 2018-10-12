package com.redscarf.admin.modules.g7.web;

import com.redscarf.admin.common.config.Global;
import com.redscarf.admin.common.persistence.Page;
import com.redscarf.admin.common.utils.StringUtils;
import com.redscarf.admin.common.web.BaseController;
import com.redscarf.admin.modules.g7.entity.OffiAcctImportLog;
import com.redscarf.admin.modules.g7.service.OffiAcctImportLogService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 公众号导入日志生成Controller
 * @author LeeJohn
 * @version 2016-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/g7/offiAcctImportLog")
public class OffiAcctImportLogController extends BaseController {
	@Autowired
	private OffiAcctImportLogService offiAcctImportLogService;

	@ModelAttribute
	public OffiAcctImportLog get(@RequestParam(required=false) String id) {
		OffiAcctImportLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = offiAcctImportLogService.get(id);
		}
		if (entity == null){
			entity = new OffiAcctImportLog();
		}
		return entity;
	}
	
	@RequiresPermissions("g7:offiAcctImportLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(OffiAcctImportLog offiAcctImportLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OffiAcctImportLog> page = offiAcctImportLogService.findPage(new Page<>(request, response), offiAcctImportLog);
		model.addAttribute("page", page);
		return "modules/g7/offiAcctImportLogList";
	}

	@RequiresPermissions("g7:offiAcctImportLog:view")
	@RequestMapping(value = "form")
	public String form(OffiAcctImportLog offiAcctImportLog, Model model) {
		model.addAttribute("offiAcctImportLog", offiAcctImportLog);
		return "modules/g7/offiAcctImportLogForm";
	}

	@RequiresPermissions("g7:offiAcctImportLog:edit")
	@RequestMapping(value = "save")
	public String save(OffiAcctImportLog offiAcctImportLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, offiAcctImportLog)){
			return form(offiAcctImportLog, model);
		}
		offiAcctImportLogService.save(offiAcctImportLog);
		addMessage(redirectAttributes, "保存公众号导入日志成功");
		return "redirect:"+ Global.getAdminPath() +"/g7/offiAcctImportLog/?repage";
	}
	
	@RequiresPermissions("g7:offiAcctImportLog:edit")
	@RequestMapping(value = "delete")
	public String delete(OffiAcctImportLog offiAcctImportLog, RedirectAttributes redirectAttributes) {
		offiAcctImportLogService.delete(offiAcctImportLog);
		addMessage(redirectAttributes, "删除公众号导入日志成功");
		return "redirect:"+Global.getAdminPath()+"/g7/offiAcctImportLog/?repage";
	}


}