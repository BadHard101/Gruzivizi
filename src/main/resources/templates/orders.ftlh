<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1>
<hr>
<#if user.email??>
    <h3>Имя пользователя: <i>${user.name}</i></h3>
    <#if user.isAdmin()>
        <a href="/admin">Панель администратора</a><br><br>
    </#if>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Выйти"/>
    </form>
<#else>
    <a href="/login">Войти</a></h1>
</#if>
<hr>
<h4>Перевозки по всей России</h4>
<form action="/" method="get">
    Поиск по заказа по id: <input type="number" name="id">
    <input type="submit" value="Поиск"/>
</form>
<#list orders as order>
        <div>
            <p><b>${order.id}</b> от ${order.user.name} | <a href="/order/${order.id}">Подробнее...</a></p>
        </div>
    <#else>
    <h3>Заказов нет</h3>
</#list>
<#if user.email??>
    <hr>
    <h3>Заказать перевозку</h3>
    <form action="/order/create" method="post" enctype="multipart/form-data">
        Адрес загрузки: <input type="text" name="pointA"/><br><br>
        Адрес разгрузки: <input type="text" name="pointB"/><br><br>
        Максимальный вес груза: <input type="number" step="0.1" name="weight"/><br><br>
        Максимальная высота груза: <input type="number" step="0.1" name="height"/><br><br>
        Максимальная ширина груза: <input type="number" step="0.1" name="width"/><br><br>
        Пассажиры: <input type="number" name="passengers"/><br><br>
        Гидроборт: <input type="checkbox" name="hydroboard"/><br><br>
        Термозащита: <input type="checkbox" name="thermalProtection"/><br><br>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Добавить заказ"/>
    </form>
</#if>
</body>
</html>