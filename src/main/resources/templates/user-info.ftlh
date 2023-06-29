<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1><hr>
<h3>Подробная информация о пользователе ${user.name}</h3>
<b>Номер телефона: </b> ${user.phoneNumber}<br>
<b>Email: </b> ${user.email}<br>
<hr>
<h3>Заказы пользователя ${user.name}</h3>
<#list orders as order>
    <div>
        <p><b>ID:</b> ${order.id}</p>
        <p><b>Откуда/Куда:</b> ${order.pointA} / ${order.pointB}</p>
        <p><b>Параметры заказа (вес, макс. высота, макс. ширина):</b>
            ${order.weight} тонн, ${order.height} м., ${order.width} м.</p>
        <p><b>Статус заказа:</b> <#list order.status as st>${st} </#list></p>
        <p><b>Дата заказа:</b> ${order.dateOfCreated}</p>
        <p><b>Кол-во пассажиров:</b> ${order.passengers}</p>
        <p><b>Гидроборт:</b> <#if order.hydroboard>Есть<#else>Нет</#if></p>
        <p><b>Термозащита:</b> <#if order.thermalProtection>Есть<#else>Нет</#if></p>
        <a href="/order/${order.id}">Подробнее...</a>
    </div>
    <hr>
<#else>
    <h3>Товаров нет</h3>
</#list>
<#if errorMessage??>
    <h2 style="color: red">${errorMessage}</h2>
</#if>
</body>
</html>