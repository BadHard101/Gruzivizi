<!DOCTYPE html>
<html>
<head>
    <title>GruziVizi</title>
</head>
<body>
<h1>GruziVizi</h1><hr>
<h3>Редактирование заказа ${order.id}</h3>
<form action="/admin/order/edit" method="post">
    <#list status as st>
        <div>
            <label><input type="radio" name="orderStatus" value="${st}" ${order.status?seq_contains(st)?string("checked", "")}>${st}</label>
        </div>
    </#list>
    <input type="hidden" value="${order.id}" name="orderId">
    <input type="hidden" value="${_csrf.token}" name="_csrf">
    <button type="submit">Сохранить</button>
</form>
</body>
</html>