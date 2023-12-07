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
    </#if>
    <#if user.email??>
        <hr>
        <h3>Заказать перевозку</h3>
        <form action="/order/create" method="post" enctype="multipart/form-data">
            Адрес загрузки: <input type="text" name="pointA"/><br><br>
            Адрес разгрузки: <input type="text" name="pointB"/><br><br>
            Максимальный вес груза: <input type="number" step="0.1" name="weight"/> тонн<br><br>
            Максимальная высота груза: <input type="number" step="0.1" name="height"/> метров<br><br>
            Максимальная ширина груза: <input type="number" step="0.1" name="width"/> метров<br><br>
            Кол-во пассажиров: <input type="number" name="passengers"/><br><br>
            Нужен гидроборт? <input type="checkbox" name="hydroboard"/><br><br>
            Нужена термозащита? <input type="checkbox" name="thermalProtection"/><br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Добавить заказ" class="btn btn-primary"/>
        </form>
    </#if>
    <#if errorMessage??>
        <h2 style="color: red">${errorMessage}</h2>
    </#if>
</div>

<!-- Add Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
