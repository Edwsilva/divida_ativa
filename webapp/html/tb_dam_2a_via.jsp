<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="anoExercicio" value="${objeto.exercicio}" />
	<portlet:param name="parcelamento" value="${parcelamento}"/>
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="action" value="voltarOrigemDam" />
</liferay-portlet:renderURL>


<liferay-portlet:renderURL var="emitir2aViaGuiaDam"
	windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="parcelamento" value="${parcelamento}"/>
	<portlet:param name="emitir2aViaGuiaDam" value="emitir2aViaGuiaDam" />
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />


<div id="dam">
	<p id="dados-imovel-selecionado">
		<liferay-ui:message key="mensagem.2avia.dam.titulo" />.
		<c:if test="${not empty numInscricao}">
			<liferay-ui:message key="mensagem.iptu.consulta.insc.imob" />
			<span> ${numInscricao}</span>.
		</c:if>
		<c:if test="${not empty numCDA}">
			<liferay-ui:message key="mensagem.dam.consulta.cda" />
			<span> ${numCDA}</span>.
		</c:if>
		<c:if test="${not empty numExecucaoFiscal}">
			<liferay-ui:message key="mensagem.dam.consulta.execucao" />
			<span> ${numExecucaoFiscal}</span>.
		</c:if>
	</p>
	<br/><br/>
	<input type="hidden" name="numInscricao" value="${numInscricao}" />
	<input type="hidden" name="numCDA" value="${numCDA}" />
	<input type="hidden" name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<input type="hidden" name="parcelamento" value="${parcelamento}" />
	
	<table class="fancy-table tabela">
		<thead>
			<tr>
				<th colspan="4" class="th">Dados da Guia</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<th scope="row" class="tabCel" style="text-align: center;">Nº da Guia</th>
				<th scope="row" colspan="3" class="tabCel" style="text-align: left;">
					<input class="tabCel numeroGuia" type="hidden" id="idNumeroGuia" name="numeroGuia" value="${numeroGuia}" />
					${numeroGuia}</th>
				</tr>
				<tr>
					<th scope="row" class="tabCel" style="text-align: center;">CDA(s)</th>
					<th scope="row" colspan="3" class="tabCel" style="text-align: left;">
						<c:forEach var="obj" items="${listaCDAs}">	
							${obj.numero}<BR>	
						</c:forEach>			
					</th>					
				</tr>
				<tr>
					<th scope="row" class="tabCel" style="text-align: center;">Nº da Cota</th>					
					<th scope="row" class="tabCel" style="text-align: center;">Valor</th>
					<th scope="row" class="tabCel" style="text-align: center;">Data de Vencimento</th>				
					<th scope="row" class="tabCel" style="text-align: center;">Situação</th>
				</tr>

				<c:forEach var="obj" items="${listaCotas}">
					<tr>
						<td class="tabCel" style="text-align: center;">${obj.numero}</td>
						<td class="tabCel" style="text-align: center;">${obj.valorTotal}</td>
						<td class="tabCel" style="text-align: center;">${obj.dataVencimento}</td>					
						<td class="tabCel" style="text-align: center;">${obj.descSituacao}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br> <br>
		<div class="submit-wrapper">
			<input type="submit" title="Confirmar"	name="prepararEmissao2aViaGuiaDam" value="Confirmar" class="button, idDamEmitir" id="idDamEmitir"	onclick="acionar2aViaDamLink('<%=emitir2aViaGuiaDam%>');return false" /> 
				<a	id="linkDamEmitir" href="<%=emitir2aViaGuiaDam%>"></a>
		</div>
		<div class="submit-wrapper">
			<a class="submit" href="<%=actionVoltar%>">Voltar</a>
		</div>
</div>

<script type="text/javascript">
	function acionar2aViaDamLink() {
		var vals = "";
		$("input[type=hidden][name='numeroGuia']")
					.each(
							function() {
								var query = "&<portlet:namespace/>numeroGuia="
										+ input();
								$('#idDamEmitir').click(
										window.open($('#linkDamEmitir').attr(
												"href")
												+ query, '_blank'));

								return false;
							});
	}

	function input() {
		var vals = ""
		$("input[type=hidden][name='numeroGuia']").each(function() {
			vals = vals + $(this).val() + ",";
		});
		return vals;
	}

</script>