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
<h2>Панель администратора / Заказы</h2>
<form action="/admin/ordersPanel" method="get">
    <div class="mb-3">
        <label for="searchId" class="form-label">Поиск заказа по ID:</label>
        <input type="number" id="searchId" name="id" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary">Поиск</button>
</form>
<br>
<table class="table table-bordered">
    <thead>
    <tr>
        <th>ID</th>
        <th>Дата создания</th>
        <th>Пользователь</th>
        <th>Загрузка</th>
        <th>Выгрузка</th>
        <th>Высота</th>
        <th>Ширина</th>
        <th>Вес</th>
        <th>Пассажиры</th>
        <th>Гидроборд</th>
        <th>Термозащита</th>
        <th>Статус</th>
        <th>Редактирование</th>
        <th>Удаление</th>
    </tr>
    </thead>
    <tbody>
    <#list orders as order>
        <tr>
            <td>${order.id}</td>
            <td>
                ${order.dateOfCreated.toLocalDate()} /
                ${order.dateOfCreated.getHour()}:${order.dateOfCreated.getMinute()}:${order.dateOfCreated.getSecond()}
            </td>
            <td>${order.user.name}</td>
            <td>${order.pointA}</td>
            <td>${order.pointB}</td>
            <td>${order.height}</td>
            <td>${order.width}</td>
            <td>${order.weight}</td>
            <td>${order.passengers}</td>
            <td><#if order.hydroboard>Да<#else>Нет</#if></td>
            <td><#if order.thermalProtection>Да<#else>Нет</#if></td>
            <td>
                <#list order.status as st>
                    <#if st=="CREATED">
                        Создан
                    <#elseif st=="ACCEPTED">
                        Принят в работу
                    <#elseif st=="IN_PROCESS">
                        Перевозится
                    <#elseif st=="COMPLETED">
                        Выполнен
                    <#elseif st=="CANCELED">
                        Отменен
                    <#else>
                        ${st}<br>
                    </#if>
                </#list>
            </td>
            <td><a href="/admin/order/edit/${order.id}">Редактирование</a></td>
            <td>
                <form action="/admin/order/delete/${order.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <button type="submit" class="btn btn-danger">Удалить</button>
                </form>
            </td>
        </tr>
    <#else>
        <tr>
            <td colspan="14"><h3>Заказов нет</h3></td>
        </tr>
    </#list>
    </tbody>
</table>
</body>
</html>