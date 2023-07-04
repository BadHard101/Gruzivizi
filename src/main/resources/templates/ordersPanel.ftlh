<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1>
<hr>
<h2>Панель администратора / Заказы</h2>
<form action="/admin/ordersPanel" method="get">
    Поиск заказа по id: <input type="number" name="id">
    <input type="submit" value="Поиск"/>
</form>
<br>
<table border="1">
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
        <th>Редактировние</th>
        <th>Удаление</th>
    </tr>
    <#list orders as order>
        <tr>
            <th>${order.id}</th>
            <th>${order.dateOfCreated}</th>
            <th>${order.user.name}</th>
            <th>${order.pointA}</th>
            <th>${order.pointB}</th>
            <th>${order.height}</th>
            <th>${order.width}</th>
            <th>${order.weight}</th>
            <th>${order.passengers}</th>
            <th><#if order.hydroboard>true<#else>false</#if></th>
            <th><#if order.thermalProtection>true<#else>false</#if></th>
            <th><#list order.status as status>${status}<br></#list></th>
            <th><a href="/admin/order/edit/${order.id}">Редактировние</a></th>
            <th>
                <form action="/admin/order/delete/${order.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Удалить">
                </form>
            </th>
        </tr>
    <#else>
        <h3>Заказов нет</h3>
    </#list>
</table>
</body>
</html>