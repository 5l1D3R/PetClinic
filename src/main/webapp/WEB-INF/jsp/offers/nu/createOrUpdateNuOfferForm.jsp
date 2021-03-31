<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cheapy" tagdir="/WEB-INF/tags" %>

<cheapy:layout pageName="NumOffers">
    <h2>
        <c:if test="${nuOffer['new']}">Nueva </c:if> Oferta por n�mero de comensales
    </h2>
    <form:form modelAttribute="nuOffer" class="form-horizontal" id="add-nuOffer-form">
        <div class="form-group has-feedback">
            <form:hidden path="id"/>
            <form:hidden path="code"/>
            <form:hidden path="status"/>
            <cheapy:inputField label="Fecha de inicio" placeholder="15/06/2021 14:00" name="start"/>
            <cheapy:inputField label="Fecha de fin" placeholder="15/06/2021 16:00" name="end"/>
            
            <cheapy:inputField label="Oro" name="gold"/>
            <cheapy:inputField label="Descuento de oro" name="discountGold"/>
            <cheapy:inputField label="Plata" name="silver"/>
            <cheapy:inputField label="Descuento de plata" name="discountSilver"/>
            <cheapy:inputField label="Bronce" name="bronze"/>
			<cheapy:inputField label="Descuento de bronce" name="discountBronze"/>

            </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <c:choose>
                    <c:when test="${nuOffer['new']}">
                        <button class="btn btn-default" type="submit">Crear oferta</button>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-default" type="submit">Modificar</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form:form>
</cheapy:layout>
