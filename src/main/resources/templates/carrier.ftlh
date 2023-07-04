<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1>
<hr>
<h2>Панель перевозчика</h2>
<hr>
<h4>Занятые Вами ТС</h4>
<#list vehicles as vehicle>
    <#if vehicle.busy && vehicle.carrierId == user.id>
        / <a href="/carrier/vehicle/${vehicle.id}">${vehicle.registerNumber} </a>
    </#if>
</#list>
<hr>
<h4>Все занятые ТС</h4>
<#list vehicles as vehicle>
    <#if vehicle.busy>
        / <a href="/carrier/vehicle/${vehicle.id}">${vehicle.registerNumber} </a>
    </#if>
</#list>
<hr>
<h4>Все свободные ТС</h4>
<#list vehicles as vehicle>
    <#if !vehicle.busy>
        / <a href="/carrier/vehicle/${vehicle.id}">${vehicle.registerNumber}</a>
    </#if>
</#list>
<hr>
<h4>Принятые заказы</h4>
<table border="1">
    <tr>
        <#--<th>ID</th>
        <th>Дата создания</th>-->
        <th>Пользователь</th>
        <th>Телефон</th>
        <th>Загрузка</th>
        <th>Выгрузка</th>
        <#--<th>Высота</th>
        <th>Ширина</th>
        <th>Вес</th>-->
        <th>Пассажиры</th>
        <#--<th>Гидроборд</th>
        <th>Термозащита</th>
        <th>Статус</th>-->
        <th>Подробнее</th>
        <th>Отмена</th>
        <th>Доступные ТС</th>
        <th>Стутус</th>
    </tr>
    <#list orders as order>
        <#if !order.isCreated() && order.carrierId == user.getId()>
            <tr>
                <#--<th>${order.id}</th>
                <th>${order.dateOfCreated}</th>-->
                <th>${order.user.name}</th>
                <th>${order.user.phoneNumber}</th>
                <th>${order.pointA}</th>
                <th>${order.pointB}</th>
                <#--<th>${order.height}</th>
                <th>${order.width}</th>
                <th>${order.weight}</th>-->
                <th>${order.passengers}</th>
                <#--<th><#if order.hydroboard>true<#else>false</#if></th>
                <th><#if order.thermalProtection>true<#else>false</#if></th>
                <th><#list order.status as status>${status}<br></#list></th>-->
                <th><a href="/order/${order.id}">Подробнее</a></th>
                <th>
                    <form action="/carrier/order/cancel/${order.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Отменить">
                    </form>
                </th>
                <th>
                    <#list order.getValidateVehicles() as vehicle>
                        <#if !vehicle.busy || vehicle.carrierId == user.id>
                            / <a href="/carrier/vehicle/${vehicle.id}">${vehicle.registerNumber} </a>
                        </#if>
                    </#list>
                </th>
                <#if !order.isProcess()>
                    <th>
                        <form action="/carrier/order/process/${order.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" value="'Уже везу'">
                        </form>
                    </th>
                <#else>
                    <th>
                    <form action="/carrier/order/decline/${order.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Отменить">
                    </form>
                    </th>
                </#if>
            </tr>
        </#if>
    <#else>
        <h3>Заказов нет</h3>
    </#list>
</table>
<hr>
<h4>Доступные заказы</h4>
<table border="1">
    <tr>
        <#--<th>ID</th>
        <th>Дата создания</th>-->
        <th>Пользователь</th>
        <th>Телефон</th>
        <th>Загрузка</th>
        <th>Выгрузка</th>
        <#--<th>Высота</th>
        <th>Ширина</th>
        <th>Вес</th>-->
        <th>Пассажиры</th>
        <#--<th>Гидроборд</th>
        <th>Термозащита</th>
        <th>Статус</th>-->
        <th>Подробнее</th>
        <th>Принять</th>
        <th>Доступные ТС</th>
        <th>Все подходящие ТС</th>
    </tr>
    <#list orders as order>
        <#if order.isCreated()>
            <tr>
                <#--<th>${order.id}</th>
                <th>${order.dateOfCreated}</th>-->
                <th>${order.user.name}</th>
                <th>${order.user.phoneNumber}</th>
                <th>${order.pointA}</th>
                <th>${order.pointB}</th>
                <#--<th>${order.height}</th>
                <th>${order.width}</th>
                <th>${order.weight}</th>-->
                <th>${order.passengers}</th>
                <#--<th><#if order.hydroboard>true<#else>false</#if></th>
                <th><#if order.thermalProtection>true<#else>false</#if></th>
                <th><#list order.status as status>${status}<br></#list></th>-->
                <th><a href="/order/${order.id}">Подробнее</a></th>
                <th>
                    <form action="/carrier/order/accept/${order.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Принять">
                    </form>
                </th>
                <th>
                    <#list order.getValidateVehicles() as vehicle>
                        <#if !vehicle.busy>
                            / <a href="/carrier/vehicle/${vehicle.id}">${vehicle.registerNumber} </a>
                        </#if>
                    <#--<#else>
                        Нет-->
                    </#list>
                </th>
                <th>
                    <#list order.getValidateVehicles() as vehicle>
                        / <a href="/carrier/vehicle/${vehicle.id}">${vehicle.registerNumber} </a>
                    <#--<#else>
                        Нет-->
                    </#list>
                </th>
            </tr>
        </#if>
    <#else>
        <h3>Заказов нет</h3>
    </#list>
</table>

</body>
</html>