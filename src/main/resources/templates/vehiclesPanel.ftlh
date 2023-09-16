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
<hr>
<h3>Добавить ТС</h3>
<form action="/vehicle/create" method="post" enctype="multipart/form-data">
    <div class="mb-3">
        <label for="file1" class="form-label">Фотография:</label>
        <input type="file" class="form-control" id="file1" name="file1">
    </div>
    <div class="mb-3">
        <label for="registerNumber" class="form-label">Регистрационный номер:</label>
        <input type="text" class="form-control" id="registerNumber" name="registerNumber">
    </div>
    <div class="mb-3">
        <label for="maxWeight" class="form-label">Максимальный вес груза:</label>
        <input type="number" step="0.1" class="form-control" id="maxWidth" name="maxWidth">
    </div>
    <div class="mb-3">
        <label for="maxHeight" class="form-label">Максимальная высота груза:</label>
        <input type="number" step="0.1" class="form-control" id="maxHeight" name="maxHeight">
    </div>
    <div class="mb-3">
        <label for="maxWidth" class="form-label">Максимальная ширина груза:</label>
        <input type="number" step="0.1" class="form-control" id="maxWeight" name="maxWeight">
    </div>
    <div class="mb-3">
        <label for="maxPassengers" class="form-label">Максимальное количество пассажиров:</label>
        <input type="number" class="form-control" id="maxPassengers" name="maxPassengers">
    </div>
    <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="hydroboard" name="hydroboard">
        <label class="form-check-label" for="hydroboard">Гидроборт</label>
    </div>
    <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="thermalProtection" name="thermalProtection">
        <label class="form-check-label" for="thermalProtection">Термозащита</label>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Добавить" class="btn btn-primary">
</form>
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
