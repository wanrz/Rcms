<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
 	<%@include file="../../common/head.jsp" %>
	<%@include file="../../common/tree.jsp" %>
    <title>RCMS</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta content="width=device-wi.dth, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link href="<%=request.getContextPath()%>/css/jquery-ui-themes.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/axure_rp_page.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/data/styles.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/files/cusItem/styles.css" type="text/css" rel="stylesheet"/>
    <script src="<%=request.getContextPath()%>/js/jquery-1.7.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/axQuery.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/globals.js"></script>
    <script src="<%=request.getContextPath()%>/js/axutils.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/annotation.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/axQuery.std.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/doc.js"></script>
    <script src="<%=request.getContextPath()%>/js/data/document.js"></script>
    <script src="<%=request.getContextPath()%>/js/messagecenter.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/events.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/recording.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/action.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/expr.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/geometry.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/flyout.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/ie.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/model.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/repeater.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/sto.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/utils.temp.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/variables.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/drag.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/move.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/visibility.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/style.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/adaptive.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/tree.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/init.temp.js"></script>
    <script src="<%=request.getContextPath()%>/js/files/cusItem/data.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/legacy.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/viewer.js"></script>
    <script src="<%=request.getContextPath()%>/js/axure/math.js"></script>
    <script type="text/javascript">
      $axure.utils.getTransparentGifPath = function() { return 'resources/images/transparent.gif'; };
      $axure.utils.getOtherPath = function() { return 'resources/Other.html'; };
      $axure.utils.getReloadPath = function() { return 'resources/reload.html'; };
    </script>
  </head>
  <body>
    <div class="wrapper">
  	  <%@include file="../../webhead.jsp" %>
	  <%@include file="../../webleft.jsp" %>
    <div id="base" class="content-wrapper">
      <!-- Unnamed (矩形) -->
      <div id="u159" class="ax_default _形状">
        <div id="u159_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u160" class="text" style="visibility: visible;">
          <p><span>&nbsp; 客户事记</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u161" class="ax_default _形状">
        <div id="u161_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u162" class="text" style="display: none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u163" class="ax_default _形状">
        <div id="u163_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u164" class="text" style="visibility: visible;">
          <p><span>客户名称：</span></p>
        </div>
      </div>

      <!-- Unnamed (文本框) -->
      <div id="u165" class="ax_default _文本框">
        <input id="u165_input" type="text" value=""/>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u166" class="ax_default _形状">
        <div id="u166_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u167" class="text" style="visibility: visible;">
          <p><span>拜访人员：</span></p>
        </div>
      </div>

      <!-- Unnamed (文本框) -->
      <div id="u168" class="ax_default _文本框">
        <input id="u168_input" type="text" value=""/>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u169" class="ax_default _形状">
        <div id="u169_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u170" class="text" style="visibility: visible;">
          <p><span>拜访日期：</span></p>
        </div>
      </div>

      <!-- Unnamed (文本框) -->
      <div id="u171" class="ax_default _文本框">
        <input id="u171_input" type="text" value=""/>
      </div>

      <!-- Unnamed (提交按钮) -->
      <div id="u172" class="ax_default _提交按钮">
        <input id="u172_input" type="submit" value="查询"/>
      </div>

      <!-- Unnamed (提交按钮) -->
      <div id="u173" class="ax_default _提交按钮">
        <input id="u173_input" type="submit" value="重置"/>
      </div>

      <!-- Unnamed (提交按钮) -->
      <div id="u174" class="ax_default _提交按钮">
        <input id="u174_input" type="submit" value="新增"/>
      </div>

      <!-- Unnamed (提交按钮) -->
      <div id="u175" class="ax_default _提交按钮">
        <input id="u175_input" type="submit" value="修改"/>
      </div>

      <!-- Unnamed (提交按钮) -->
      <div id="u176" class="ax_default _提交按钮">
        <input id="u176_input" type="submit" value="删除"/>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u177" class="ax_default _形状">
        <div id="u177_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u178" class="text" style="visibility: visible;">
          <p style="font-size:14px;"><span>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; </span><span style="font-size:13px;">&nbsp; &nbsp; 序号&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 客户名称&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 事项主题&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 拜访日期&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 拜访人员&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 随行人员</span></p>
        </div>
      </div>

      <!-- Unnamed (文本框) -->
      <div id="u179" class="ax_default _文本框">
        <input id="u179_input" type="text" value=""/>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u180" class="ax_default _形状">
        <div id="u180_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u181" class="text" style="visibility: visible;">
          <p><span style="color:#000000;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color:#0066FF;">惠氏&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span></p>
        </div>
      </div>

      <!-- Unnamed (文本框) -->
      <div id="u182" class="ax_default _文本框">
        <input id="u182_input" type="text" value=""/>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u183" class="ax_default _形状">
        <div id="u183_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u184" class="text" style="visibility: visible;">
          <p><span>事项主题：</span></p>
        </div>
      </div>

      <!-- Unnamed (文本框) -->
      <div id="u185" class="ax_default _文本框">
        <input id="u185_input" type="text" value=""/>
      </div>
    </div>
    <%@include file="../../webfooter.jsp" %>
  </div>
  </body>
</html>
