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
    <h2>Панель перевозчика</h2>
    <hr>
    <h4>Занятые Вами ТС</h4>
    <div>
        <#list vehicles as vehicle>
            <#if vehicle.busy && vehicle.carrierId == user.id>
                <a href="/carrier/vehicle/${vehicle.id}" class="btn btn-primary">${vehicle.registerNumber}</a>
            </#if>
        </#list>
    </div>
    <hr>
    <h4>Все занятые ТС</h4>
    <div>
        <#list vehicles as vehicle>
            <#if vehicle.busy>
                <a href="/carrier/vehicle/${vehicle.id}" class="btn btn-primary">${vehicle.registerNumber}</a>
            </#if>
        </#list>
    </div>
    <hr>
    <h4>Все свободные ТС</h4>
    <div>
        <#list vehicles as vehicle>
            <#if !vehicle.busy>
                <a href="/carrier/vehicle/${vehicle.id}" class="btn btn-primary">${vehicle.registerNumber}</a>
            </#if>
        </#list>
    </div>
    <hr>
    <h4>Принятые заказы</h4>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Пользователь</th>
            <th>Телефон</th>
            <th>Загрузка</th>
            <th>Выгрузка</th>
            <th>Пассажиры</th>
            <th>Подробнее</th>
            <th>Отмена</th>
            <th>Доступные ТС</th>
            <th>Статус "Везу"</th>
            <th>Статус "Выполнен"</th>
        </tr>
        </thead>
        <tbody>
        <#list orders as order>
            <#if !order.isCompleted() && !order.isCreated() && order.carrierId == user.getId()>
                <tr>
                    <td>${order.user.name}</td>
                    <td>${order.user.phoneNumber}</td>
                    <td>${order.pointA}</td>
                    <td>${order.pointB}</td>
                    <td>${order.passengers}</td>
                    <td><a href="/order/${order.id}" class="btn btn-primary">Подробнее</a></td>
                    <td>
                        <form action="/carrier/order/cancel/${order.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" value="Отменить" class="btn btn-danger">
                        </form>
                    </td>
                    <td>
                        <#list order.getValidateVehicles() as vehicle>
                            <#if !vehicle.busy || vehicle.carrierId == user.id>
                                <a href="/carrier/vehicle/${vehicle.id}" class="btn btn-primary">${vehicle.registerNumber}</a>
                            </#if>
                        </#list>
                    </td>
                    <td>
                        <#if !order.isProcess()>
                            <form action="/carrier/order/process/${order.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" value="Уже везу" class="btn btn-success">
                            </form>
                        <#else>
                            <form action="/carrier/order/decline/${order.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" value="Отменить" class="btn btn-danger">
                            </form>
                        </#if>
                    </td>
                    <td>
                        <#if order.isProcess()>
                            <form action="/carrier/order/complete/${order.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" value="Выполнен" class="btn btn-success">
                            </form>
                        </#if>
                    </td>
                </tr>
            </#if>
        <#else>
            <tr>
                <td colspan="10"><h3>Заказов нет</h3></td>
            </tr>
        </#list>
        </tbody>
    </table>
    <hr>
    <h4>Доступные заказы</h4>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Пользователь</th>
            <th>Телефон</th>
            <th>Загрузка</th>
            <th>Выгрузка</th>
            <th>Пассажиры</th>
            <th>Подробнее</th>
            <th>Принять</th>
            <th>Доступные ТС</th>
            <th>Все подходящие ТС</th>
        </tr>
        </thead>
        <tbody>
        <#list orders as order>
            <#if order.isCreated()>
                <tr>
                    <td>${order.user.name}</td>
                    <td>${order.user.phoneNumber}</td>
                    <td>${order.pointA}</td>
                    <td>${order.pointB}</td>
                    <td>${order.passengers}</td>
                    <td><a href="/order/${order.id}" class="btn btn-primary">Подробнее</a></td>
                    <td>
                        <form action="/carrier/order/accept/${order.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" value="Принять" class="btn btn-success">
                        </form>
                    </td>
                    <td>
                        <#list order.getValidateVehicles() as vehicle>
                            <#if !vehicle.busy>
                                <a href="/carrier/vehicle/${vehicle.id}" class="btn btn-primary">${vehicle.registerNumber}</a>
                            </#if>
                        </#list>
                    </td>
                    <td>
                        <#list order.getValidateVehicles() as vehicle>
                            <a href="/carrier/vehicle/${vehicle.id}" class="btn btn-primary">${vehicle.registerNumber}</a>
                        </#list>
                    </td>
                </tr>
            </#if>
        <#else>
            <tr>
                <td colspan="9"><h3>Заказов нет</h3></td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>

<!-- Add Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
