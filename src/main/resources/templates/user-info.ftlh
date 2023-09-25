<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            padding: 0 5% 2% 5%;
        }
    </style>
</head>
<body>
<h1 class="mt-3">GruziVizi</h1>
<hr>
<h2>Пользователь ${user.name}</h2>
<#if user.hasAvatar()>
    <img src="/images/${user.avatar.id}" height="250px"/><br><br>
</#if>
<#if admin.isAdmin()>
    <form action="/user/photo/update/${user.id}" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Фотография:</label><br>
            <input class="form-control" type="file" name="file1"/>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Изменить" class="btn btn-primary">
    </form>
</#if>
<hr>
<h3>Подробная информация:</h3>
<p><b>ID:</b> ${user.id}</p>
<p><b>Email:</b> ${user.email}</p>
<p><b>Номер телефона:</b> ${user.phoneNumber}</p>
<p><b>Дата создания аккаунта:</b> ${user.dateOfCreated.toLocalDate()}</p>
<hr>
<h2>Заказы пользователя ${user.name}:</h2>
<#list orders as order>
    <hr>
    <div>
        <p><b>Дата создания заказа:</b>
            ${order.dateOfCreated.toLocalDate()} /
            ${order.dateOfCreated.getHour()}:${order.dateOfCreated.getMinute()}:${order.dateOfCreated.getSecond()}
        </p>
        <p><b>Откуда/Куда:</b> ${order.pointA} / ${order.pointB}</p>
        <p><b>Статус заказа:</b>
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
            </#list></p>
        <a href="/order/${order.id}" class="btn btn-primary">Подробнее...</a>
    </div>
<#else>
    <h3>Заказов нет</h3>
</#list>
<#if errorMessage??>
    <h2 style="color: red">${errorMessage}</h2>
</#if>
</body>
</html>