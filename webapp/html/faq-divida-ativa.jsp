<%@ include file="init.jsp" %>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="action" value="voltarOrigem" />
</liferay-portlet:renderURL>

<div class="subhome-content" id="iptu-home">
<h1>Perguntas Frequentes - Dívida Ativa</h1>
<iframe src="https://daminternet.rio.rj.gov.br/faq-divida-ativa/index.html" style="overflow:hidden;width:100%;height: 1000pt;"></iframe>
<br>
<a class="submit" href="<%=actionVoltar%>">Voltar</a>
</div>
