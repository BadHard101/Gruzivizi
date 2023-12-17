<#include "../header.ftlh">

<#if user.isActive()>
    <div class="container mt-4">
        <h4 class="mb-4">Ваши заказы на перевозку:</h4>

        <#if user.isEnabled()>
            <form action="/" method="get" class="mb-4">
                <div class="input-group">
                    <input type="number" name="id" class="form-control" placeholder="Поиск заказа по id">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-primary">Поиск</button>
                    </div>
                </div>
            </form>
        </#if>

        <#if orders?size == 0>
            <div class="alert alert-info">
                <h5>У Вас пока нет заказов</h5>
                <a href="/order/getAddingOrderPage" class="btn btn-primary">Сделать заказ</a>
            </div>
        <#else>
            <div class="list-group">
                <#list orders as order>
                        <#if user.isEnabled() && order.user.getId() == user.getId()>
                            <a href="/order/${order.id}" class="list-group-item list-group-item-action">
                                <p class="mb-1">Заказ <strong>${order.id}</strong> из <strong>${order.pointA}</strong> в <strong>${order.pointB}</strong> от ${order.user.name}</p>
                            </a>
                        </#if>
                </#list>
            </div>
        </#if>
    </div>
</#if>

<#include "../footer.ftlh">
