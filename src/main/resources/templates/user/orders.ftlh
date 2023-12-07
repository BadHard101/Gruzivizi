<#include "../header.ftlh">

<#if user.isActive()>
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
                <p>Заказ <b>${order.id}</b> из <b>${order.pointA}</b> в <b>${order.pointB}</b> от ${order.user.name} |
                    <a
                            href="/order/${order.id}">Подробнее...</a></p>
            </div>
        </#if>
    <#else>
        <h3>У Вас пока нет заказов</h3>
        <a href="/order/getAddingOrderPage" class="btn btn-primary">Сделать заказ</a>
    </#list>
</#if>

<#include "../footer.ftlh">