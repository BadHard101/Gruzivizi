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

        .btn-group-horizontal > .btn {
            float: none;
        }

        .btn-custom {
            /* Add your custom styling for button colors */
            color: #fff;
        }

        .btn-custom-primary {
            background-color: #007bff; /* Primary color - blue */
        }

        .btn-custom-success {
            background-color: #28a745; /* Success color - green */
        }

        .btn-custom-warning {
            background-color: #ffc107; /* Warning color - yellow */
        }

        .btn-custom-custom {
            background-color: #d78e3d; /* Custom color - orange */
        }

        .btn-custom-danger {
            background-color: #dc3545; /* Danger color - red */
        }
    </style>
</head>
<body>
<div class="container">
    <h1>GruziVizi</h1>
    <hr>
    <#if user.email??>
        <h3>Имя пользователя: <i>${user.name}</i></h3>
        <div class="btn-group btn-group-horizontal" role="group" aria-label="User Actions">
            <#if user.isActive()>
                <a href="/account" class="btn btn-custom btn-custom-primary"><i class="bi bi-person"></i> Личный кабинет</a>
                <a href="/order/getAddingOrderPage" class="btn btn-custom btn-custom-success"><i class="bi bi-cart-plus"></i> Сделать заказ</a>
            </#if>
            <#if user.isAdmin()>
                <a href="/admin/" class="btn btn-custom btn-custom-warning"><i class="bi bi-gear"></i> Панель администратора</a>
            </#if>
            <#if user.isCarrier()>
                <a href="/carrier" class="btn btn-custom btn-custom-custom"><i class="bi bi-truck"></i> Панель перевозчика</a>
            </#if>
        </div>
        <form action="/logout" method="post">
            <br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Выйти" class="btn btn-danger"/>
        </form>
        <hr>

        <#else>
        <h3>Авторизуйтесь, чтобы сделать заказ на перевозку!</h3>
        <br>
        <a href="/login" class="btn btn-primary">Войти</a>
    </#if>