<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1>
<hr>
<h2>Подробная информация о ТС</h2>
<#--<#list images as img>
    <img src="/images/${img.id}" height="60px"/><br><br>
</#list>-->
<div>
    <b>Регистрационный номер: </b> ${vehicle.registerNumber}<br>
    <b>Максимальный вес груза: </b> ${vehicle.maxWeight}<br>
    <b>Максимальная высота груза: </b> ${vehicle.maxHeight}<br>
    <b>Максимальная ширина груза: </b> ${vehicle.maxWidth}<br>
    <b>Максимальное количество пассажиров: </b> ${vehicle.maxPassengers}<br>
    <b>Гидроборт: </b> <#if vehicle.hydroboard>Есть<#else>Нет</#if><br>
    <b>Термозащита: </b> <#if vehicle.thermalProtection>Есть<#else>Нет</#if><br>
    <#--<#if user.isCarrier()>
        <form action="/carrier/order/accept/${order.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Занять ТС">
        </form>
    </#if>-->
</div>
</body>
</html>