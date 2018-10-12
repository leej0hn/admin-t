<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<title>公众号导入日志管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#messageBox").attr("style","display: block;");
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/g7/offiAcctImportLog/">公众号导入日志列表</a></li>
		<shiro:hasPermission name="g7:offiAcctImportLog:edit"><li><a href="${ctx}/g7/offiAcctImportLog/form">公众号导入日志添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="offiAcctImportLog" action="${ctx}/g7/offiAcctImportLog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>导入批次号：</label>
				<form:input path="batchId" htmlEscape="false" maxlength="12" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="12" class="input-medium"/>
			</li>
			<li class="clearfix"></li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>导入批次号</th>
				<th>微信ID</th>
				<th>微信昵称</th>
				<th>微信用户名</th>
				<th>微信认证类型</th>
				<th>监控时间表达式名称</th>
				<th>获取状态</th>
				<th>--------创建时间--------</th>
				<th>公众号文章URL</th>
				<shiro:hasPermission name="g7:offiAcctImportLog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="offiAcctImportLog">
			<tr>
				<td>
					<a href="${ctx}/g7/offiAcctImportLog/list?batchId=${offiAcctImportLog.batchId}&pageNo=1&pageSize=30">
					<shiro:hasPermission name="g7:offiAcctImportLog:edit">
						<a href="${ctx}/g7/offiAcctImportLog/form?id=${offiAcctImportLog.id}">
					</shiro:hasPermission>
					${offiAcctImportLog.batchId}
					</a>
				</td>
				<td>
					${offiAcctImportLog.alias}
				</td>
				<td>
					${offiAcctImportLog.nikiName}
				</td>
				<td>
					${offiAcctImportLog.userName}
				</td>
				<td>
					${offiAcctImportLog.serviceTypeInfo}
				</td>
				<td>
					${offiAcctImportLog.triggerName}
				</td>
				<td>
					${offiAcctImportLog.status}
				</td>
				<td>
					<fmt:formatDate value="${offiAcctImportLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
				 	${offiAcctImportLog.articleUrl}
				</td>
				<shiro:hasPermission name="g7:offiAcctImportLog:edit"><td>
    				<a href="${ctx}/g7/offiAcctImportLog/form?id=${offiAcctImportLog.id}">修改</a>
					<a href="${ctx}/g7/offiAcctImportLog/delete?id=${offiAcctImportLog.id}" onclick="return confirmx('确认要删除该公众号导入日志吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>