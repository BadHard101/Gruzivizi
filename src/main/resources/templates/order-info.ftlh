<!DOCTYPE html>
<html>
<head>
    <title>BUYSELL</title>
</head>
<body>
<h1>BUYSELL</h1><hr>
<h4>Подробная информация о товаре</h4>
<#list images as img>
    <img src="/images/${img.id}" height="60px"/><br><br>
</#list>
<b>Название товара: </b>${order.title}<br>
<b>Описание товара: </b>${order.description}<br>
<b>Цена: </b>${order.price}<br>
<b>Город: </b>${order.city}<br>
<b>Автор: </b><a href="/user/${order.user.id}">${order.user.name}</a><br>
</body>
</html>