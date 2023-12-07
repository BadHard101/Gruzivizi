<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            padding: 1% 5% 2% 5%;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>GruziVizi</h1>
    <hr>
    <#if user.email??>
        <h3>Имя пользователя: <i>${user.name}</i></h3>
        <#if user.isActive()>
            <a href="/account" class="btn btn-primary">Личный кабинет</a>
        </#if>
        <#if user.isActive()>
            <a href="/getVehicleAddingPage" class="btn btn-primary">Сделать заказ</a>
        </#if>
        <#if user.isAdmin()>
            <a href="/admin/" class="btn btn-primary">Панель администратора</a>
        </#if>
        <#if user.isCarrier()>
            <a href="/carrier" class="btn btn-primary">Панель перевозчика</a>
        </#if>
        <form action="/logout" method="post">
            <br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Выйти" class="btn btn-danger"/>
        </form>
    <hr>
    <h4>Ваши заказы на перевозку:</h4>
    <#if user.isEnabled()>
        <form action="/" method="get">
            Поиск заказа по id: <input type="number" name="id">
            <input type="submit" value="Поиск" class="btn btn-primary"/>
        </form>
    </#if>
    <#list orders as order>
        <#if user.isEnabled() && order.user.getId() == user.getId()>
            <div class="alert alert-success">
                <p>Заказ <b>${order.id}</b> из <b>${order.pointA}</b> в <b>${order.pointB}</b> от ${order.user.name} | <a href="/order/${order.id}">Подробнее...</a></p>
            </div>
        </#if>
    <#else>
        <h3>У Вас пока нет заказов</h3>
        <#if user.isActive()>
            <a href="/getAddingOrderPage" class="btn btn-primary">Сделать заказ</a>
        </#if>
    </#list>
    <#else>
        <h3>Авторизуйтесь, чтобы сделать заказ на перевозку!</h3>
        <br>
        <a href="/login" class="btn btn-primary">Войти</a>
    </#if>
</div>

<!-- Add Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
