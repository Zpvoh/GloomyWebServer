<%--
  Created by IntelliJ IDEA.
  User: zpvoh
  Date: 2019/1/3
  Time: 11:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="SQL.*" %>
<% Utils.init();
    request.setCharacterEncoding("utf-8");%>
<html>
<head>
    <meta content=”text/html;charset=utf-8″ />
    <meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
    <link rel="icon" href="icon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mini.css/3.0.0/mini-default.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://cdn.bootcss.com/react/16.4.0/umd/react.development.js"></script>
    <script src="https://cdn.bootcss.com/react-dom/16.4.0/umd/react-dom.development.js"></script>
    <script src="https://cdn.bootcss.com/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <title>物业管理系统-业主交互页面</title>
</head>
<body>
    <header class="sticky">
        <a class="logo button" id="homePage" href="index.jsp">物业管理系统</a>
        <a class="button" id="houseInfoSearch" href="householder.jsp?type=house_info_search&action=none">住户信息查询</a>
        <a class="button" id="houseInfoSub" href="householder.jsp?type=house_info&action=none">住户信息登记</a>
        <a class="button" id="complainSub" href="householder.jsp?type=house_complain&action=none">投诉单填写</a>
        <a class="button" id="repairReport" href="householder.jsp?type=house_repair&action=none">室内设备报修单填写</a>
        <a class="button" id="houseBill" href="householder.jsp?type=house_bill&action=none">住户月账单管理</a>
        <a class="button" id="parkingLotInfoH" href="householder.jsp?type=parking_lot&action=none">日常车位信息查询</a>
    </header>
    <article>
        <%
            String type=request.getParameter("type");
            if(type!=null) {
                String strOut="";
                if (type.equals("house_info")) {
                    if(request.getParameter("action").equals("none")) {
                        strOut = "<form action=\"householder.jsp\" method=\"post\" id=\"houseInfo\">\n" +
                                "            <input type=\"hidden\" value=\"house_info\" name=\"type\">" +
                                "            <input type=\"hidden\" value=\"submitted\" name=\"action\">" +
                                "            户主姓名：<input type=\"text\" name=\"householder_name\" required>\n" +
                                "            小区名：<input type=\"text\" name=\"community\" required>\n" +
                                "            住宅楼号：<input type=\"number\" name=\"building_number\" required>\n" +
                                "            单元号：<input type=\"number\" name=\"unit_number\" required><br>\n" +
                                "            室号：<input type=\"number\" name=\"room_number\" required>\n" +
                                "            户主手机号：<input type=\"number\" name=\"phone_number\">\n" +
                                "<input type=\"submit\" value=\"提交\">" +
                                "        </form>";
                    }else if(request.getParameter("action").equals("submitted")){
                        String name=request.getParameter("householder_name");
                        String community=request.getParameter("community");
                        int buildingNo=Integer.parseInt(request.getParameter("building_number"));
                        int unitNo=Integer.parseInt(request.getParameter("unit_number"));
                        int roomNo=Integer.parseInt(request.getParameter("room_number"));
                        String phone=request.getParameter("phone_number");

                        if(Utils.insert_house_info(name,community,buildingNo,unitNo,roomNo,phone)){
                            strOut="<h1>插入成功</h1>";
                        }else{
                            strOut="<h1>插入失败</h1>";
                        }
                    }
                }else if(type.equals("house_bill")){
                    strOut="<form action=\"householder.jsp\" method=\"post\">\n" +
                            "            <input type=\"hidden\" value=\"house_bill\" name=\"type\">\n" +
                            "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                            "            查询日期：<input type=\"date\" name=\"house_bill_date\">\n" +
                            "            户主名：<input type=\"text\" name=\"householder_name\" required>\n" +
                            "            <input type=\"submit\" value=\"提交\">\n" +
                            "        </form>";
                    if(request.getParameter("action").equals("submitted")){
                        String name=request.getParameter("householder_name");
                        Date date=Date.valueOf(request.getParameter("house_bill_date"));
                        int year=date.getYear()+1900;
                        int month=date.getMonth()+1;
                        ArrayList<FeeWithStatus> fee_arr=Utils.search_month_house_bill(name,month,year);
                        StringBuilder rows=new StringBuilder();
                        fee_arr.forEach(fee->{
                            String isPaid=fee.is_paid?"已交":"未交";
                            String item="<tr>" +
                                    "<td>"+fee.item_name+"</td>" +
                                    "<td>"+fee.fee+"</td>" +
                                    "<td>"+isPaid+"</td>" +
                                    "</tr>";

                            rows.append(item);
                        });

                        String strTable= "            <table>\n" +
                                "<caption>住户月账单</caption>" +
                                "                <tr>\n" +
                                "                    <th>收费项</th>\n" +
                                "                    <TH>费用</TH>\n" +
                                "                    <TH>是否已交</TH>\n" +
                                "                </tr>\n" +rows.toString()+
                                "            </table>";
                        strOut+=strTable;
                    }
                }else if(type.equals("house_complain")){
                    if(request.getParameter("action").equals("none")) {
                        strOut = "<form action=\"householder.jsp\" method=\"post\">\n" +
                                "            <input type=\"hidden\" value=\"house_complain\" name=\"type\">\n" +
                                "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                                "            小区名：<input type=\"text\" name=\"community\" required>\n" +
                                "            楼号：<input type=\"number\" name=\"building_number\" required>\n" +
                                "            单元号：<input type=\"number\" name=\"unit_number\" required>\n" +
                                "            室号：<input type=\"number\" name=\"room_number\" required><br>\n" +
                                "            投诉时间：<input type=\"date\" name=\"complain_date\" required>\n" +
                                "            投诉类型：<select name=\"complain_type\" required>\n" +
                                "                <option>住户问题</option>\n" +
                                "                <option>设备问题</option>\n" +
                                "                <option>安保问题</option>\n" +
                                "                <option>费用问题</option>\n" +
                                "                <option>其他</option>\n" +
                                "            </select>\n" +
                                "            投诉具体内容：<textarea name=\"content\"></textarea><br>\n" +
                                "                <input type=\"submit\" value=\"提交\">\n" +
                                "        </form>";
                    }else if(request.getParameter("action").equals("submitted")){
                        String community=request.getParameter("community");
                        int buildingNo=Integer.parseInt(request.getParameter("building_number"));
                        int unitNo=Integer.parseInt(request.getParameter("unit_number"));
                        int roomNo=Integer.parseInt(request.getParameter("room_number"));
                        Date date=Date.valueOf(request.getParameter("complain_date"));
                        String complain_type=request.getParameter("complain_type");
                        String content=request.getParameter("content");

                        if(Utils.insert_complain_form(community,buildingNo,unitNo,roomNo,date,complain_type,content)){
                            strOut="<h1>记录提交成功</h1>";
                        }else {
                            strOut="<h1>记录提交出现问题</h1>";
                        }
                    }

                }else if(type.equals("house_repair")){
                    if(request.getParameter("action").equals("none")) {
                        strOut = "<label>" +
                                "<form action=\"householder.jsp\" method=\"post\">\n" +
                                "            <input type=\"hidden\" value=\"house_repair\" name=\"type\">\n" +
                                "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                                "            小区名：<input type=\"text\" name=\"community\" required>\n" +
                                "            楼号：<input type=\"number\" name=\"building_number\" required>\n" +
                                "            单元号：<input type=\"number\" name=\"unit_number\" required>\n" +
                                "            室号：<input type=\"number\" name=\"room_number\" required><br>\n" +
                                "            报修时间：<input type=\"date\" name=\"report_date\" required>\n" +
                                "            报修项目：<select name=\"report_type\" required>\n" +
                                "                <option>电梯问题</option>\n" +
                                "                <option>楼道灯问题</option>\n" +
                                "                <option>下水道堵塞</option>\n" +
                                "                <option>电线漏电</option>\n" +
                                "                <option>其他</option>\n" +
                                "            </select>\n" +
                                "            报修原因：<textarea name=\"cause\"></textarea><br>\n" +
                                "                <input type=\"submit\" value=\"提交\">\n" +
                                "        </form>";
                    }else if(request.getParameter("action").equals("submitted")){
                        String community=request.getParameter("community");
                        int buildingNo=Integer.parseInt(request.getParameter("building_number"));
                        int unitNo=Integer.parseInt(request.getParameter("unit_number"));
                        int roomNo=Integer.parseInt(request.getParameter("room_number"));
                        Date date=Date.valueOf(request.getParameter("report_date"));
                        String report_type=request.getParameter("report_type");
                        String cause=request.getParameter("cause");

                        if(Utils.insert_report_repair(community,buildingNo,unitNo,roomNo,date,report_type,cause)){
                            strOut="<h1>记录提交成功</h1>";
                        }else {
                            strOut="<h1>记录提交出现问题</h1>";
                        }
                    }
                }else if(type.equals("parking_lot")){
                    strOut="<form action=\"householder.jsp\" method=\"post\">\n" +
                            "            <input type=\"hidden\" value=\"parking_lot\" name=\"type\">\n" +
                            "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                            "            停车位号：<input type=\"number\" name=\"parking_lot_id\" required>\n" +
                            "            <input type=\"submit\" value=\"提交\">\n" +
                            "        </form>";

                    if(request.getParameter("action").equals("submitted")) {
                        int parkingNo=Integer.parseInt(request.getParameter("parking_lot_id"));
                        ArrayList<TempLotRec> temp_arr=Utils.search_parking_info_temp(parkingNo);
                        ArrayList<RentLotRec> rent_arr=Utils.search_parking_info_rent(parkingNo);
                        ArrayList<PurchaseLotRec> purchase_arr=Utils.search_parking_info_purchase(parkingNo);

                        StringBuilder rowTemp=new StringBuilder();
                        temp_arr.forEach(temp->{
                            String row="<tr>" +
                                    "<td>"+temp.temp_parking_lot_rec_id+"</td>" +
                                    "<td>"+temp.car_id+"</td>" +
                                    "<td>"+temp.startTime+"</td>" +
                                    "<td>"+temp.endTime+"</td>" +
                                    "</tr>";

                            rowTemp.append(row);
                        });

                        StringBuilder rowRent=new StringBuilder();
                        rent_arr.forEach(rent->{
                            String row="<tr>" +
                                    "<td>"+rent.rent_parking_lot_rec_id+"</td>" +
                                    "<td>"+rent.house_id+"</td>" +
                                    "<td>"+rent.startTime+"</td>" +
                                    "<td>"+rent.endTime+"</td>" +
                                    "</tr>";

                            rowRent.append(row);
                        });

                        StringBuilder rowPurchase=new StringBuilder();
                        purchase_arr.forEach(purchase->{
                            String row="<tr>" +
                                    "<td>"+purchase.purchase_rec_id+"</td>" +
                                    "<td>"+purchase.house_id+"</td>" +
                                    "</tr>";

                            rowPurchase.append(row);
                        });

                        String strTable = "<table>\n" +
                                "            <caption>临时停车记录</caption>\n" +
                                "            <tr>\n" +
                                "                <th>临时停车记录号</th>\n" +
                                "                <TH>车牌号</TH>\n" +
                                "                <th>起始时间</th>\n" +
                                "                <th>终止时间</th>\n" +
                                "            </tr>\n" +rowTemp.toString()+
                                "        </table>\n" +
                                "        <table>\n" +
                                "            <caption>租用记录</caption>\n" +
                                "            <tr>\n" +
                                "                <th>租用记录号</th>\n" +
                                "                <TH>住户号</TH>\n" +
                                "                <th>起始时间</th>\n" +
                                "                <th>终止时间</th>\n" +
                                "            </tr>\n" +rowRent.toString()+
                                "        </table>\n" +
                                "        <table>\n" +
                                "            <caption>购买记录</caption>\n" +
                                "            <tr>\n" +
                                "                <th>购买记录号</th>\n" +
                                "                <TH>住户号</TH>\n" +
                                "            </tr>\n" +rowPurchase.toString()+
                                "        </table>";
                        strOut+=strTable;
                    }
                }else if(type.equals("house_info_search")){
                    strOut="<form action=\"householder.jsp\" method=\"post\">\n" +
                            "            <input type=\"hidden\" value=\"house_info_search\" name=\"type\">\n" +
                            "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                            "            户主名：<input type=\"text\" name=\"householder_name\" required>\n" +
                            "            <input type=\"submit\" value=\"提交\">\n" +
                            "        </form>";

                    if(request.getParameter("action").equals("submitted")){
                        String name=request.getParameter("householder_name");
                        House house=Utils.search_house_by_name(name);

                        String row="<tr>" +
                                "<td>"+house.house_id+"</td>" +
                                "<td>"+house.householder_name+"</td>" +
                                "<td>"+house.community+"</td>" +
                                "<td>"+house.buildingNo+"</td>" +
                                "<td>"+house.unitNo+"</td>" +
                                "<td>"+house.roomNo+"</td>" +
                                "<td>"+house.phone+"</td>" +
                                "</tr>";

                        String strTable="<table>\n" +
                                "            <caption>住户信息表</caption>\n" +
                                "            <tr>\n" +
                                "                <th>住户序号</th>\n" +
                                "                <TH>户主姓名</TH>\n" +
                                "                <th>小区名</th>\n" +
                                "                <th>楼号</th>\n" +
                                "                <th>单元号</th>\n" +
                                "                <th>室号</th>\n" +
                                "                <th>户主手机号</th>\n" +
                                "            </tr>\n" +row+
                                "        </table>";
                        strOut+=strTable;
                    }
                }
        %>

        <%
                out.print(strOut);
            }
        %>
        <%--<form action="householder.jsp" method="post">--%>
            <%--<input type="hidden" value="house_bill_search" name="type">--%>
            <%--查询日期：<input type="date" name="house_bill_date">--%>
            <%--<br><input type="submit" value="提交">--%>
        <%--</form>--%>

        <%--<form action="householder.jsp" method="post">
            <input type="hidden" value="house_info_search" name="type">
            户主名：<input type="text" name="parking_lot_id">
            <br><input type="submit" value="提交">
        </form>
        <table>
            <caption>住户信息表</caption>
            <tr>
                <th>住户序号</th>
                <TH>户主姓名</TH>
                <th>小区名</th>
                <th>楼号</th>
                <th>单元号</th>
                <th>室号</th>
                <th>户主手机号</th>
                <th>是否已婚</th>
            </tr>
        </table>--%>
        <%--<table>
            <caption>租用记录</caption>
            <tr>
                <th>租用记录号</th>
                <TH>住户号</TH>
                <th>起始时间</th>
                <th>终止时间</th>
                <th>费用</th>
            </tr>
        </table>
        <table>
            <caption>购买记录</caption>
            <tr>
                <th>购买记录号</th>
                <TH>住户号</TH>
                <th>费用</th>
            </tr>
        </table>--%>
    </article>
</body>
</html>
