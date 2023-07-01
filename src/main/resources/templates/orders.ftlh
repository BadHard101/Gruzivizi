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
    <#if user.isActive()>
        <a href="/account">Личный кабинет</a><br><br>
    </#if>
    <#if user.isAdmin()>
        <a href="/admin">Панель администратора</a><br><br>
    </#if>
    <#if user.isCarrier()>
        <a href="/carrier">Панель перевозчика</a><br><br>
    </#if>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Выйти"/>
    </form>
<#else>
    <a href="/login">Войти</a></h1>
</#if>
<hr>
<h4>Ваши заказы:</h4>
<#if user.isEnabled()>
    <form action="/" method="get">
        Поиск заказа по id: <input type="number" name="id">
        <input type="submit" value="Поиск"/>
    </form>
<#else>
    Авторизируйтесь, чтобы сделать заказ!
</#if>
<#list orders as order>
    <#if user.isEnabled() && order.user.getId() == user.getId()>
        <div>
            <p>Заказ <b>${order.id}</b> от ${order.user.name} | <a href="/order/${order.id}">Подробнее...</a></p>
        </div>
    </#if>
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