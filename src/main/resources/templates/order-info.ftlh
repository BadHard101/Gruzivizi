<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1><hr>
<h2>Подробная информация о заказе</h2>
<#--<#list images as img>
    <img src="/images/${img.id}" height="60px"/><br><br>
</#list>-->

<#--<b>Автор: </b><a href="/account">${order.user.name}</a><br>-->
<div>
    <b>Заказчик: </b> ${order.user.name}<br>
    <b>Номер телефона: </b> ${order.user.phoneNumber}<br>
    <b>Email: </b> ${order.user.email}<br>
    <hr>
    <p><b>ID заказа:</b> ${order.id}</p>
    <p><b>Откуда / Куда:</b> ${order.pointA} / ${order.pointB}</p>
    <p><b>Параметры (вес / высота / ширина):</b>
        ${order.weight} тонн / ${order.height} м. / ${order.width} м.</p>
    <p><b>Статус заказа:</b> <#list order.status as st>${st} </#list></p>
    <p><b>Дата заказа:</b> ${order.dateOfCreated}</p>
    <p><b>Кол-во пассажиров:</b> ${order.passengers}</p>
    <p><b>Гидроборт:</b> <#if order.hydroboard>Есть<#else>Нет</#if></p>
    <p><b>Термозащита:</b> <#if order.thermalProtection>Есть<#else>Нет</#if></p>
    <#if user.isAdmin()>
        <a href="/account">Подробнее о пользователе</a><br><br>
    </#if>
</div>
</body>
</html>