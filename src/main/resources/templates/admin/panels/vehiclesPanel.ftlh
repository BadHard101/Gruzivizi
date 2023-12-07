<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            padding: 0 5%;
        }
    </style>
</head>
<body>
<h1 class="mt-3">GruziVizi</h1>
<hr>
<h2>Панель администратора / Транспорт</h2>
<br>
<a href="/vehicle/getVehicleAddingPage" class="btn btn-primary">Добавить транспорт</a> <br><br>
<hr>
<h3>Список всех ТС</h3>
<form action="/admin/vehiclesPanel" method="get">
    <div class="mb-3">
        <label for="registrationNumber" class="form-label">Поиск ТС по рег. номеру:</label>
        <input type="text" class="form-control" id="registrationNumber" name="registrationNumber">
    </div>
    <input type="submit" value="Поиск" class="btn btn-primary">
</form>
<br>
<table class="table">
    <thead>
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
    </thead>
    <tbody>
    <#list vehicles as vehicle>
        <tr>
            <td>${vehicle.registerNumber}</td>
            <td>${vehicle.maxWeight}</td>
            <td>${vehicle.maxHeight}</td>
            <td>${vehicle.maxWidth}</td>
            <td>${vehicle.maxPassengers}</td>
            <td><#if vehicle.hydroboard>Есть<#else>Нет</#if></td>
            <td><#if vehicle.thermalProtection>Есть<#else>Нет</#if></td>
            <td><#if vehicle.carrierId != 0>ID: ${vehicle.carrierId}<#else>Свободен</#if></td>
            <td><a href="/admin/vehicle/${vehicle.id}">Подробнее</a></td>
            <td>
                <form action="/admin/vehicle/delete/${vehicle.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Удалить" class="btn btn-danger">
                </form>
            </td>
        </tr>
    <#else>
        <tr>
            <td colspan="10"><h3>Транспорта нет</h3></td>
        </tr>
    </#list>
    </tbody>
</table>
</body>
</html>
