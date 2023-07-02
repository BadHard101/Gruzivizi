<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1>
<hr>
<h4>Панель администратора / Транспорт</h4>

<h3>Добавить ТС</h3>
<form action="/vehicle/create" method="post" enctype="multipart/form-data">
    Регистрационный номер: <input type="text" name="registerNumber"/><br>
    Максимальный вес груза: <input type="number" step="0.1" name="maxWidth"/><br>
    Максимальная высота груза: <input type="number" step="0.1" name="maxHeight"/><br>
    Максимальная ширина груза: <input type="number" step="0.1" name="maxWeight"/><br>
    Максимальное количество пассажиров: <input type="number" name="maxPassengers"/><br>
    Гидроборт: <input type="checkbox" name="hydroboard"/><br>
    Термозащита: <input type="checkbox" name="thermalProtection"/><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Добавить"/>
</form>
<br>
<table border="1">
    <tr>
        <th>Рег. номер</th>
        <th>Вес</th>
        <th>Высота</th>
        <th>Ширина</th>
        <th>Пассажиры</th>
        <th>Гидроборт</th>
        <th>Термозащита</th>
        <th>Кем занят</th>
        <th>Подробнее</th>
        <th>Удаление</th>
    </tr>
    <#list vehicles as vehicle>
        <tr>
            <th>${vehicle.registerNumber}</th>
            <th>${vehicle.maxWeight}</th>
            <th>${vehicle.maxHeight}</th>
            <th>${vehicle.maxWidth}</th>
            <th>${vehicle.maxPassengers}</th>
            <th><#if vehicle.hydroboard>true<#else>false</#if></th>
            <th><#if vehicle.thermalProtection>true<#else>false</#if></th>
            <th><#if vehicle.carrierId != 0>ID: ${vehicle.carrierId}<#else>Свободен</#if></th>
            <th><a href="/admin/vehicle/${vehicle.id}">Подробнее</a></th>
            <th>
                <form action="/admin/vehicle/delete/${vehicle.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Удалить">
                </form>
            </th>
        </tr>
    <#else>
        <h3>Транспорта нет</h3>
    </#list>
</table>
</body>
</html>