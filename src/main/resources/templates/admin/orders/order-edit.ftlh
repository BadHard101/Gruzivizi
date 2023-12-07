<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="mt-4">GruziVizi</h1>
    <hr>
    <h3 class="mt-4">Редактирование заказа №${order.id}</h3>
    <form action="/admin/order/edit" method="post">
        <div class="form-group">
            <label for="orderStatus"><b>Статус заказа:</b></label><br>
            <#list status as st>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" id="${st}" name="orderStatus"
                           value="${st}" ${order.status?seq_contains(st)?string("checked", "")}>
                    <label class="form-check-label" for="${st}">
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
                            ${st}
                        </#if>
                    </label>
                </div>
            <#--<div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userRole" value="${role}" id="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                <label class="form-check-label" for="${role}">${role}</label>
            </div>-->
            </#list>
        </div>
        <input type="hidden" value="${order.id}" name="orderId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit" class="btn btn-primary">Сохранить</button>
    </form>
</div>
</body>
</html>