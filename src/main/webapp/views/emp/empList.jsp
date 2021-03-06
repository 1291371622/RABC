<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>员工管理</title>
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-3">
                登录名: <input type="text" class="input-text" style="width: 250px">
            </div>
            <div class="formControls col-4">
                邮箱： <input type="text" class="input-text" style="width: 250px">
            </div>
            <div class="formControls col-5">
                手机： <input type="text" class="input-text" style="width: 250px">
            </div>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 搜用户
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
        <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius">
            <i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>

        <a href="javascript:;" onclick="emp_add('添加员工','empController/toAddEmp','800','500')" class="btn btn-primary radius">
            <i class="Hui-iconfont">&#xe600;</i> 添加员工
        </a>
    </span>
    </div>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="111">员工列表</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="40">ID</th>
            <th width="150">用户名</th>
            <th width="90">手机号</th>
            <th width="150">邮箱</th>
            <th width="150">头像</th>
            <th width="40">性别</th>
            <th width="130">部门</th>
            <th width="100">创建人</th>
            <th width="100">创建时间</th>
            <th width="100">操作</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${pageInfo.list}" var="emp">
            <tr class="text-c">
                <td><input class="batchDel" type="checkbox" value="${emp.id}" name=""></td>
                <td>${emp.id}</td>
                <td>${emp.username}</td>
                <td>${emp.mobile}</td>
                <td>${emp.email}</td>
                <td>
                    <img src="/commonController/showPng?pngPath=${emp.userpng}" onerror="this.src='upload/enxing.jpg'" width="100">
<%--                    onerror 当无法显示src的时候就会调用  显示默认图片--%>
                </td>
                <td>${emp.sex == 1?"男":"女"}</td>
                <td>${emp.deptno}</td>
                <td>${emp.createUser.username}</td>
                <td>
                    <fmt:formatDate value="${emp.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td class="td-manage">

                    <a title="编辑" href="javascript:;" onclick="admin_edit('员工编辑','empController/getEmpById/${emp.id}','1','800','500')" class="ml-5" style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6df;</i>
                    </a>

                    <a title="删除" href="javascript:;" onclick="admin_del(this,'${emp.id}')" class="ml-5" style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6e2;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../common/page.jsp" flush="false"/>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="js/oa_utils.js"></script>
<script type="text/javascript">
    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function emp_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-删除*/
    function admin_del(obj,id){
        layer.confirm('确认要删除吗？',function(index) {
            //此处请求后台程序，下方是成功后的前台处理……

            //发送异步请求把用户输出
            $.get("empController/deleteEmp/" + id, "", function (data) {
                responseClient(data);
            })

            $(obj).parents("tr").remove();
            layer.msg('已删除!', {icon: 1, time: 1000});
        });
    }
    /*管理员-编辑*/
    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    //批量删除
    function batchDel() {

        layer.confirm('确认要删除吗？',function(index){
        //1.要获取用户勾选的数据
            var array = $(".batchDel:checked");

        //2.创建一个数组
            var idArray = new Array();

        //3.循环遍历把id放入数组中
            for(var i = 0;i < array.length;i++){
                var id = array[i].value;
                idArray.push(id);
            }

        //4.创建一个对象,把数组封装到对象中
            var param = new Object();
            param.ids = idArray;

        //5.发送请求
            debugger;
            $.post("empController/batchDelEmp",param,function (data) {
                reminderMsg(data);
            });

            $().parents("tr").remove();
                layer.msg('删除成功!',{icon:1,time:1000});
            });
    }

    /*管理员-启用*/
    function admin_start(obj,id){
        layer.confirm('确认要启用吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……


            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
            $(obj).remove();
            layer.msg('已启用!', {icon: 6,time:1000});
        });
    }
</script>
</body>
</html>
