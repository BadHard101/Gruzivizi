<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1><hr>
<h4>Подробная информация о перевозке</h4>
<#--<#list images as img>
    <img src="/images/${img.id}" height="60px"/><br><br>
</#list>-->
<b>Название товара: </b>${order.id}<br>
<b>Описание товара: </b>${order.width}<br>
<b>Цена: </b>${order.height}<br>
<b>Город: </b>${order.pointA}<br>
<b>Город: </b>${order.pointB}<br>
<b>Автор: </b><a href="/user/${order.user.id}">${order.user.name}</a><br>
</body>
</html>