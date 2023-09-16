<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="mt-4">GruziVizi</h1>
    <hr>
    <h2 class="mt-4">Подробная информация о заказе</h2>
    <div class="mb-4">
        <b>Заказчик: </b> ${order.user.name}<br>
        <b>Номер телефона: </b> ${order.user.phoneNumber}<br>
        <b>Email: </b> ${order.user.email}<br>
    </div>
    <hr>
    <p><b>ID заказа:</b> ${order.id}</p>
    <p><b>Откуда / Куда:</b> ${order.pointA} / ${order.pointB}</p>
    <p><b>Параметры (вес / высота / ширина):</b>
        ${order.weight} тонн / ${order.height} м. / ${order.width} м.</p>
    <p><b>Статус заказа:</b> <#list order.status as st>${st} </#list></p>
    <p><b>Дата создания заказа:</b> ${order.dateOfCreated.toLocalDate()} /
        ${order.dateOfCreated.getHour()}:${order.dateOfCreated.getMinute()}:${order.dateOfCreated.getSecond()}</p>
    <p><b>Кол-во пассажиров:</b> ${order.passengers}</p>
    <p><b>Гидроборт:</b> <#if order.hydroboard>Есть<#else>Нет</#if></p>
    <p><b>Термозащита:</b> <#if order.thermalProtection>Есть<#else>Нет</#if></p>

    <#if user.isCarrier()>
        <p><b>Подходящие ТС:</b>
            <#list order.getValidateVehicles() as vehicle>
                ${vehicle.registerNumber}
            <#else>
                Нет
            </#list></p>
    </#if>

    <#if user.isAdmin()>
        <a href="/user/${order.user.id}">Подробнее о пользователе</a><br><br>
    </#if>
</div>
</body>
</html>