<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1>
<hr>
<h2>Подробная информация о ТС</h2>
<img src="/images/${vehicle.previewImageId}" height="250px"/><br><br>
<div>
    <b>Регистрационный номер: </b> ${vehicle.registerNumber}<br>
    <b>Максимальный вес груза: </b> ${vehicle.maxWeight}<br>
    <b>Максимальная высота груза: </b> ${vehicle.maxHeight}<br>
    <b>Максимальная ширина груза: </b> ${vehicle.maxWidth}<br>
    <b>Максимальное количество пассажиров: </b> ${vehicle.maxPassengers}<br>
    <b>Гидроборт: </b> <#if vehicle.hydroboard>Есть<#else>Нет</#if><br>
    <b>Термозащита: </b> <#if vehicle.thermalProtection>Есть<#else>Нет</#if><br>
    <#if user.isCarrier() && !vehicle.busy>
        <br>
        <form action="/carrier/vehicle/accept/${vehicle.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Занять ТС">
        </form>
    </#if>
    <#if user.isCarrier() && vehicle.busy && vehicle.carrierId == user.id>
        <br>
        <form action="/carrier/vehicle/decline/${vehicle.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Освободить ТС">
        </form>
    </#if>
    <#if vehicle.busy && vehicle.carrierId != user.id>
        <h3 style="color: red">ТС занято другим перевозщиком</h3>
    </#if>
</div>
</body>
</html>