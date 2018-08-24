<%--
  Created by IntelliJ IDEA.
  User: zpvoh
  Date: 18-8-14
  Time: 下午2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
    <title>Gloomy</title>
    <link rel="icon" href="icon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mini.css/3.0.0/mini-default.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://cdn.bootcss.com/react/16.4.0/umd/react.development.js"></script>
    <script src="https://cdn.bootcss.com/react-dom/16.4.0/umd/react-dom.development.js"></script>
    <script src="https://cdn.bootcss.com/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <script src="js/handleCookie.js"></script>
    <script type="text/babel" src="js/react_render.js"></script>
    <script src="js/getContent.js"></script>
</head>
<body>
<div id="dialog"></div>
<header id="head" class="sticky"></header>
<div id="page"></div>
<input type="file" ng-model="my_file" id="conf" style="display: none;">
<footer id="foot" class="sticky"></footer>

</body>
</html>
