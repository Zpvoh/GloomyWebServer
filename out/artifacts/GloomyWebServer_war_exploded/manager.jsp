<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.function.Consumer" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="SQL.*" %>
<%@ page import="sun.nio.ch.Util" %><%--
  Created by IntelliJ IDEA.
  User: zpvoh
  Date: 2019/1/3
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>物业管理系统-物业管理员交互页面</title>
</head>
<body>
<header class="sticky">
    <a class="logo button" id="homePage" href="index.jsp">物业管理系统</a>
    <a class="button" id="repairInfo" href="manager.jsp?type=repair_report&action=none">报修维修统计</a>
    <a class="button" id="manageBill" href="manager.jsp?type=income_cost&action=none">物业收支报表查看</a>
    <a class="button" id="complainSearch" href="manager.jsp?type=complain_search&action=none">投诉报修汇总报表查看</a>
    <a class="button" id="vacancyInfo" href="manager.jsp?type=vacancy_house&action=none">闲置房屋统计</a>
    <a class="button" id="parkingLotInfoP" href="manager.jsp?type=parking_lot&action=none">日常车位信息查询</a>
    <a class="button" id="houseInfoSub" href="manager.jsp?type=house_info_search&action=none">住户信息查询</a>
    <a class="button" id="handleReport" href="manager.jsp?type=handle_report">处理报修</a>
    <a class="button" id="handleComplain" href="manager.jsp?type=handle_complain">处理投诉</a>
</header>
<article>
    <%
        String type = request.getParameter("type");
        if (type != null) {
            String strOut = "";
            if (type.equals("repair_report")) {
                strOut = "<form action=\"manager.jsp\" method=\"post\">\n" +
                        "            <input type=\"hidden\" value=\"repair_report\" name=\"type\">\n" +
                        "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                        "            需查询小区：<input type=\"text\" name=\"community\">\n" +
                        "            需查询日期：<input type=\"date\" name=\"repair_report_date\">\n" +
                        "            <input type=\"submit\" value=\"提交\">\n" +
                        "        </form>";
                if(request.getParameter("action").equals("submitted")){
                    Date date=Date.valueOf(request.getParameter("repair_report_date"));
                    int year=date.getYear()+1900;
                    int month=date.getMonth()+1;
                    String season=Utils.getSeasonByMonth(month);
                    String community=request.getParameter("community");
                    ArrayList<RepairReportByHouse> month_house_arr= Utils.month_search_report_repair_by_house(community,month,year);
                    ArrayList<RepairReportByType> month_type_arr=Utils.month_search_report_repair_by_type(community,month,year);
                    ArrayList<RepairReportByHouse> season_house_arr=Utils.season_search_report_repair_by_house(community,season,year);
                    ArrayList<RepairReportByType> season_type_arr=Utils.season_search_report_repair_by_type(community,season,year);

                    StringBuilder row_month_house=new StringBuilder();
                    month_house_arr.forEach(repairReportByHouse -> {
                        String row="<tr>" +
                                "<td>"+repairReportByHouse.house_id+"</td>" +
                                "<td>"+repairReportByHouse.repair_report_count+"</td>" +
                                "<td>"+repairReportByHouse.total_repair_fee+"</td>" +
                                "</tr>";
                        row_month_house.append(row);
                    });

                    StringBuilder row_month_type=new StringBuilder();
                    month_type_arr.forEach(repairReportByType -> {
                        String row="<tr>" +
                                "<td>"+repairReportByType.type+"</td>" +
                                "<td>"+repairReportByType.repair_report_count+"</td>" +
                                "<td>"+repairReportByType.total_repair_fee+"</td>" +
                                "</tr>";
                        row_month_type.append(row);
                    });

                    StringBuilder row_season_house=new StringBuilder();
                    season_house_arr.forEach(repairReportByHouse -> {
                        String row="<tr>" +
                                "<td>"+repairReportByHouse.house_id+"</td>" +
                                "<td>"+repairReportByHouse.repair_report_count+"</td>" +
                                "<td>"+repairReportByHouse.total_repair_fee+"</td>" +
                                "</tr>";
                        row_season_house.append(row);
                    });

                    StringBuilder row_season_type=new StringBuilder();
                    season_type_arr.forEach(repairReportByType -> {
                        String row="<tr>" +
                                "<td>"+repairReportByType.type+"</td>" +
                                "<td>"+repairReportByType.repair_report_count+"</td>" +
                                "<td>"+repairReportByType.total_repair_fee+"</td>" +
                                "</tr>";
                        row_season_type.append(row);
                    });

                    String strTable = "<table>\n" +
                            "            <caption>月度报修表（按每户）</caption>\n" +
                            "            <tr>\n" +
                            "                <th>住户序号</th>\n" +
                            "                <th>报修次数</th>\n" +
                            "                <th>总计维修费用</th>\n" +
                            "            </tr>\n" +
                            row_month_house.toString()+
                            "        </table>\n" +
                            "        <table>\n" +
                            "            <caption>月度报修表（按每类目）</caption>\n" +
                            "            <tr>\n" +
                            "                <th>类目名</th>\n" +
                            "                <th>报修次数</th>\n" +
                            "                <th>总计维修费用</th>\n" +
                            "            </tr>\n" +
                            row_month_type.toString()+
                            "        </table>\n" +
                            "        <table>\n" +
                            "            <caption>季度报修表（按每户）</caption>\n" +
                            "            <tr>\n" +
                            "                <th>住户序号</th>\n" +
                            "                <th>报修次数</th>\n" +
                            "                <th>总计维修费用</th>\n" +
                            "            </tr>\n" +row_season_house.toString()+
                            "        </table>\n" +
                            "        <table>\n" +
                            "            <caption>季度报修表（按每类目）</caption>\n" +
                            "            <tr>\n" +
                            "                <th>类目名</th>\n" +
                            "                <th>报修次数</th>\n" +
                            "                <th>总计维修费用</th>\n" +
                            "            </tr>\n" +
                            row_season_type.toString()+
                            "        </table>";

                    strOut+=strTable;
                }
            } else if (type.equals("income_cost")) {
                strOut = "<form action=\"manager.jsp\" method=\"post\">\n" +
                        "            <input type=\"hidden\" value=\"income_cost\" name=\"type\">\n" +
                        "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                        "            需查询日期：<input type=\"date\" name=\"repair_report_date\">\n" +
                        "            <input type=\"submit\" value=\"提交\">\n" +
                        "        </form>";

                if(request.getParameter("action").equals("submitted")){
                    Date date=Date.valueOf(request.getParameter("repair_report_date"));
                    int year=date.getYear()+1900;
                    int month=date.getMonth()+1;
                    Bill month_bill=new Bill();
                    Bill season_bill=new Bill();
                    String season=Utils.getSeasonByMonth(month);
                    HashMap<String,Integer> monthDistri=Utils.month_search_income_cost(month,year);
                    HashMap<String,Integer> seasonDistri=Utils.season_search_income_cost(season,year);

                    StringBuilder rowMonth=new StringBuilder();
                    monthDistri.forEach((item,income)->{
                        String row="<tr>" +
                                "<td>"+item+"</td>" +
                                "<td>" +income+"</td>"+
                                "</tr>";
                        month_bill.in+=income>0?income:0;
                        month_bill.cost-=income<0?income:0;
                        month_bill.profit+=income;
                        rowMonth.append(row);
                    });

                    StringBuilder rowSeason=new StringBuilder();
                    seasonDistri.forEach((item,income)->{
                        String row="<tr>" +
                                "<td>"+item+"</td>" +
                                "<td>" +income+"</td>"+
                                "</tr>";
                        season_bill.in+=income>0?income:0;
                        season_bill.cost-=income<0?income:0;
                        season_bill.profit+=income;
                        rowSeason.append(row);
                    });

                    String strTable = "<table>\n" +
                            "            <caption>月度收支报表</caption>\n" +
                            "            <tr>\n" +
                            "                <th>项目名</th>\n" +
                            "                <th>收入或支出</th>\n" +
                            "            </tr>\n" +rowMonth.toString()+
                            "        </table>\n" +
                            "        该月共支出："+month_bill.cost+" 该月共收入："+month_bill.in+" 该月共盈利："+month_bill.profit+"\n" +
                            "        <table>\n" +
                            "            <caption>季度收支报表</caption>\n" +
                            "            <tr>\n" +
                            "                <th>项目名</th>\n" +
                            "                <th>收入或支出</th>\n" +
                            "            </tr>\n" +rowSeason.toString()+
                            "        </table>\n" +
                            "        该季共支出："+season_bill.cost+" 该季共收入："+season_bill.in+" 该季共盈利："+season_bill.profit;
                    strOut+=strTable;
                }

            } else if (type.equals("complain_search")) {
                strOut = "<form action=\"manager.jsp\" method=\"post\">\n" +
                        "            <input type=\"hidden\" value=\"complain_search\" name=\"type\">\n" +
                        "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                        "            查询类型：<select name=\"search_type\">\n" +
                        "                <option>按小区</option>\n" +
                        "                <option>按时间</option>\n" +
                        "                <option>按类别</option>\n" +
                        "            </select>\n" +
                        "            需查询日期：<input type=\"date\" name=\"repair_report_date\">\n" +
                        "            <input type=\"submit\" value=\"提交\">\n" +
                        "        </form>";
                if(request.getParameter("action").equals("submitted")){
                    HashMap<String,Integer> monthDistri=null;
                    HashMap<String,Integer> seasonDistri=null;
                    Date date=Date.valueOf(request.getParameter("repair_report_date"));
                    int year=date.getYear()+1900;
                    int month=date.getMonth()+1;
                    String season=Utils.getSeasonByMonth(month);
                    String priName="";
                    switch (request.getParameter("search_type")){
                        case "按小区":
                            priName="小区名";
                            monthDistri=Utils.month_complain_count_by_commuity(year,month);
                            seasonDistri=Utils.season_complain_count_by_commuity(year,season);
                            break;
                        case "按时间":
                            priName="日期";
                            monthDistri=Utils.month_complain_count_by_date(year,month);
                            seasonDistri=Utils.season_complain_count_by_date(year,season);
                            break;
                        case "按类别":
                            priName="类别";
                            monthDistri=Utils.month_complain_count_by_type(year,month);
                            seasonDistri=Utils.season_complain_count_by_type(year,season);
                            break;
                    }

                    StringBuilder rowMonth=new StringBuilder();
                    monthDistri.forEach((name,count)->{
                        String row="<tr>" +
                                "<td>"+name+"</td>" +
                                "<td>" +count+"</td>"+
                                "</tr>";
                        rowMonth.append(row);
                    });
                    StringBuilder rowSeason=new StringBuilder();
                    seasonDistri.forEach((name,count)->{
                        String row="<tr>" +
                                "<td>"+name+"</td>" +
                                "<td>" +count+"</td>"+
                                "</tr>";
                        rowSeason.append(row);
                    });

                    String strTable = "<table>\n" +
                            "            <caption>月度投诉分布</caption>\n" +
                            "            <tr>\n" +
                            "                <th>"+priName+"</th>\n" +
                            "                <th>投诉数量</th>\n" +
                            "            </tr>\n" +rowMonth.toString()+
                            "        </table>\n" +
                            "        \n" +
                            "        <table>\n" +
                            "            <caption>季度投诉分布</caption>\n" +
                            "            <tr>\n" +
                            "                <th>"+priName+"</th>\n" +
                            "                <th>投诉数量</th>\n" +
                            "            </tr>\n" +rowSeason.toString()+
                            "        </table>";
                    strOut+=strTable;
                }
            } else if (type.equals("vacancy_house")) {
                strOut = "<form action=\"manager.jsp\" method=\"post\">\n" +
                        "            <input type=\"hidden\" value=\"vacancy_house\" name=\"type\">\n" +
                        "            <input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                        "            查询类型：<select name=\"search_type\">\n" +
                        "                <option>按小区</option>\n" +
                        "                <option>按楼宇</option>\n" +
                        "            </select>\n" +
                        "            <input type=\"submit\" value=\"提交\">\n" +
                        "        </form>";

                if(request.getParameter("action").equals("submitted")){
                    HashMap<String,Integer> distri=null;
                    String priName="";
                    switch (request.getParameter("search_type")){
                        case "按小区":
                            distri=Utils.search_vacancy_by_community();
                            priName="小区名";
                            break;
                        case "按楼宇":
                            distri=Utils.search_vacancy_by_building();
                            priName="楼号";
                            break;
                    }

                    StringBuilder rowVacancy=new StringBuilder();
                    distri.forEach((name,count)->{
                        String row="<tr>" +
                                "<td>"+name+"</td>" +
                                "<td>" +count+"</td>"+
                                "</tr>";
                        rowVacancy.append(row);
                    });

                    String strTable = "<table>\n" +
                            "            <caption>闲置房屋分布</caption>\n" +
                            "            <tr>\n" +
                            "                <th>"+priName+"</th>\n" +
                            "                <th>闲置房屋数</th>\n" +
                            "            </tr>\n" +rowVacancy.toString()+
                            "        </table>";
                    strOut+=strTable;
                }

            } else if (type.equals("parking_lot")) {
                strOut="<form action=\"manager.jsp\" method=\"post\">\n" +
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
            } else if (type.equals("house_info_search")) {
                strOut="<form action=\"manager.jsp\" method=\"post\">\n" +
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
            } else if (type.equals("handle_report")) {
                strOut=GenerateOutput.handle_report();
            } else if (type.equals("handle_complain")) {
                strOut=GenerateOutput.handle_complain();
            }else if (type.equals("repair_rec")) {
                if(request.getParameter("action").equals("submitted")){
                    int repair_id=Integer.parseInt(request.getParameter("repair_id"));
                    Date date=Date.valueOf(request.getParameter("repair_date"));
                    int equ_id=Integer.parseInt(request.getParameter("equ_id"));
                    String staff=request.getParameter("staff_name");
                    String process=request.getParameter("detail");
                    int is_completed=request.getParameterMap().containsKey("status")?1:0;
                    if(repair_id!=0) {
                        Utils.update_repair_record(repair_id, equ_id, date, staff, process, is_completed);
                    }else{
                        int r_id=Integer.parseInt(request.getParameter("r_id"));
                        String source=request.getParameter("source");
                        if(source.equals("complain")){
                            Utils.insert_complain_repair_record(equ_id,date,staff,process,is_completed,r_id);
                        }else{
                            Utils.insert_report_repair_record(equ_id,date,staff,process,is_completed,r_id);
                        }
                    }
                    strOut="<h1>修改已提交完成！</h1>";
                }else{
                    int id=0;
                    RepairRecord repairRecord=new RepairRecord();
                    String source=request.getParameter("source");
                    String r_id=request.getParameter("r_id");
                    int equ_id=0;
                    Date date=null;
                    String staff="";
                    String process="";
                    String progress="";
                    if(!request.getParameter("repair_rec").equals("0")) {
                        id=Integer.parseInt(request.getParameter("repair_rec"));
                        repairRecord = Utils.search_repair_by_id(id);
                        equ_id=repairRecord.equ_id;
                        date=repairRecord.date;
                        staff=repairRecord.staff;
                        process=repairRecord.process;
                        progress=repairRecord.progress==0?"":"checked";
                    }
                    strOut="<div><h2>"+request.getParameter("name")+"</h2>\n" +
                            "    <h3>维修号："+id+"</h3>\n" +
                            "    <form action=\"manager.jsp\" method=\"post\">\n" +
                            "        <input type=\"hidden\" value=\"repair_rec\" name=\"type\">\n" +
                            "<input type=\"hidden\" value=\"submitted\" name=\"action\">\n" +
                            "<input type=\"hidden\" value=\""+id+"\" name=\"repair_id\">\n" +
                            "<input type=\"hidden\" value=\""+source+"\" name=\"source\">\n" +
                            "<input type=\"hidden\" value=\""+r_id+"\" name=\"r_id\">\n" +
                            "被维修设备编号：<input type=\"number\" name=\"equ_id\" value=\""+equ_id+"\">\n" +
                            "        维修时间：<input type=\"date\" name=\"repair_date\" value=\""+date+"\">\n" +
                            "        维修人：<input type=\"text\" name=\"staff_name\" value=\""+staff+"\">\n" +
                            "        维修过程描述：<textarea name=\"detail\">"+process+"</textarea>\n" +
                            "        是否已完成：<input type=\"checkbox\" name=\"status\" "+progress+"><br>\n" +
                            "<input type=\"submit\" value=\"提交\">" +
                            "    </form></div>";
                }
            }

            out.print(strOut);
        }
    %>
    <%--<h2></h2>
    <h3></h3>
    <form action="manager.jsp" method="post">
        <input type="hidden" value="handle_report" name="type">
        维修时间：<input type="date" name="repair_date">
        维修人：<input type="text" name="staff_name">
        维修过程描述：<textarea name="detail"></textarea>
        是否已完成：<input type="checkbox" name="status">
    </form>--%>
    <%--<form action="manager.jsp" method="post">
        <input type="hidden" value="income_cost" name="type">
        查询类型：<select name="search_type">
        <option>按小区</option>
        <option>按楼宇</option>
    </select>
        <br><input type="submit" value="提交">
    </form>
    <table>
        <caption>未完成报修列表</caption>
        <tr>
            <th>报修号</th>
            <th>小区名</th>
            <th>楼号</th>
            <th>单元号</th>
            <th>报修项目</th>
            <th>报修原因</th>
            <th>维修记录</th>
        </tr>
        <tr>
            <td>12</td>
            <td>Siren</td>
            <td>A12</td>
            <td>2</td>
            <td>下水道堵了</td>
            <td>真的堵了！</td>
            <td><a href="manager.jsp?id=12&type=repair_rec">添加记录</a></td>
        </tr>
    </table>
    <table>
        <caption>未完成投诉列表</caption>
        <tr>
            <th>投诉号</th>
            <th>小区名</th>
            <th>楼号</th>
            <th>单元号</th>
            <th>房间号</th>
            <th>时间</th>
            <th>投诉类别</th>
            <th>具体投诉内容</th>
            <th>当前进程</th>
            <th>相关维修记录</th>
        </tr>
        <tr>
            <td>11</td>
            <td>Baroque</td>
            <td>52</td>
            <td>1</td>
            <td>502</td>
            <td>2019-1-3</td>
            <td>邻里问题</td>
            <td>楼上小孩天天弹钢琴吵死我了</td>
            <td>未解决</td>
            <td><a href="manager.jsp?name=邻里问题&complain_id=11&source=complain&type=repair_rec">修改维修记录</a></td>
        </tr>
    </table>

    <table>
        <caption>季度投诉分布</caption>
        <tr>
            <th>小区名</th>
            <th>投诉数量</th>
        </tr>
    </table>
    <table>
        <caption>季度报修表（按每类目）</caption>
        <tr>
            <th>类目名</th>
            <th>报修次数</th>
            <th>总计维修费用</th>
        </tr>
    </table>--%>
</article>
</body>
</html>
<% Utils.close();%>
