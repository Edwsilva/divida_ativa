<%@ include file="/html/init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="acaoVoltar" value="voltar" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="menuDAMURL">
	<portlet:param name="action" value="menuDAM" />
	<portlet:param name="origem" value="dividaativa-consulta.jsp" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="opcaoDAM" value="${opcaoDAM}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultarURL">
	<portlet:param name="action" value="consultar" />
	<portlet:param name="origem" value="dividaativa-consulta.jsp" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="tipoCota" value="${tipoCota}" />
</liferay-portlet:renderURL>

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<div id="wserror" class="portlet-msg-error wserror"	style="display: none;">
	<liferay-ui:message	key="Serviço indisponível no momento. Tente mais tarde." />
</div>

<style type="text/css">
.accordion-toggle.active {
	background-color: #ddd;
	background-position: 98% 15px;
}

.loading {
	float: left;
	font-size: 10px;
	margin: 3px 15px;
	display: none;
}

.combo {
	width: 120px;
}

.combo2 {
	width: 120, 5px;
}

</style>

<div id="dam-funcoes">
	<h1>Dívida Ativa</h1>

	<p id="dados-imovel-selecionado">
		<liferay-ui:message key="mensagem.iptu.consulta.selecao.imovel" />
		<span> ${endereco}</span>
		<liferay-ui:message key="mensagem.iptu.consulta.insc.imob" />
		<span> ${numInscricao}</span>.
		<liferay-ui:message key="mensagem.iptu.consulta.escolha" />
	</p>

	<input type="hidden" class="numInscricao" name="numInscricao" value="${numInscricao}" />
	<input type="hidden" name="endereco" value="${endereco}" />
	<input type="hidden" name="anoExercicio" value="${anoExercicio}" />

	<form action="${menuDAMURL}" method="post">		
		<label class="checkbox"><input type="radio" name="opcaoDAM" value="consultarDam" checked="true" style="vertical-align: top;" />
			<span> <liferay-ui:message key="mensagem.dam.consulta.emissao" /></span>
		</label> 
		<label	class="checkbox"> <input type="radio" name="opcaoDAM" value="emitir2aViaDam" style="vertical-align: top;" />
			<span><liferay-ui:message key="mensagem.dam.consulta.emissao.2avia" /></span>
		</label>
		<!-- 
		<label	class="checkbox"> <input type="radio" name="opcaoDAM" value="certidoes" style="vertical-align: top;" />
			<span><liferay-ui:message key="mensagem.dam.certidao" /></span>
		</label>
 		-->
		<div class="submit-wrapper">
				&nbsp;<input type="submit" id="btnMenuDam" name="menuDAM" value="OK" />
		</div>
	</form>
</div>

<div class="submit-wrapper">
	<a class="submit" href="<%=actionVoltar%>">Voltar à Tela Inicial</a>
</div>