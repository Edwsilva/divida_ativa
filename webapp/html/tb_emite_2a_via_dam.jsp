<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="anoExercicio" value="${objeto.exercicio}" />
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="action" value="voltarOrigemConsulta2aViaDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="prepararEmissao2aViaGuiaDamURL">
	<portlet:param name="action" value="prepararEmissao2aViaGuiaDam" />
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="rdguia" value="${rdguia}" />
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />

<script type="text/javascript" charset="utf-8">
	function acionarDamLink() {
		var vals = "";

		$("input[type=radio][name='rdguia']:checked").each(function() {
			vals = vals + $(this).val() + ",";
		});

		if (vals != "") {
			return true;
		} else {

			$("input[type=radio][name='rdguia']").each(
							function() {
								if (this.checked == false) {
									alert('Por favor, selecione a guia que deseja emitir a segunda via.');
									return false;
								}
							});
		}
		return false;
	}
</script>

<div id="emite2aViaDam">
	<form action="${prepararEmissao2aViaGuiaDamURL}" method="post">
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />
		<input type="hidden" name="numInscricao" value="${numInscricao}" />
		<input type="hidden" name="numCDA" id="numCDA" value="${numCDA}" />
		<input type="hidden" name="numExecucaoFiscal" id="numExecucaoFiscal" value="${numExecucaoFiscal}" />
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
		<c:if test="${totalGuias == null}">
			<p id="dados-imovel-selecionado">Houve um problema no processamento.</p>
		</c:if>
		<c:if test="${totalGuias == 0}">
			<p id="dados-imovel-selecionado">Não há guias de pagamento emitidas, em curso, para a 
				<c:if test="${not empty numInscricao}">
					inscrição imobiliária.
				</c:if>
				<c:if test="${not empty numCDA}">
					certidão.
				</c:if>
				<c:if test="${not empty numExecucaoFiscal}">
					execução fiscal.
				</c:if>			
			</p>
		</c:if>
		<c:if test="${totalGuias > 0}">
			<table class="fancy-table">
				<thead>
					<tr>
						<th colspan="7" class="th">Relação de Guias de Pagamento Emitidas.
							<p style="color: #CF0000; font-size: 12px; line-height: 10px;">*
								Por favor, selecione a guia de pagamento que deseja emitir segunda via.</p>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row" class="tabCel" style="text-align: center;"></th>
						<th scope="row" class="tabCel" style="text-align: center;">Contribuinte</th>
						<th scope="row" class="tabCel" style="text-align: center;">Cotas Pagas/Total</th>
						<th scope="row" class="tabCel" style="text-align: center;">Último Pagamento</th>
						<th scope="row" class="tabCel" style="text-align: center;">Guia</th>
						<th scope="row" class="tabCel" style="text-align: center;">Tipo Guia</th>						
						<th scope="row" class="tabCel" style="text-align: center;">Situação Guia</th>
					</tr>
					<c:forEach var="obj" items="${listaGuias}">
						<tr>
							<td class="tabCel" style="text-align: center;">
								<input class="tabCel rdguia " type="radio" id="idrd" name= "rdguia" value="${obj.numeroGuia}"/>
							</td>
							<td class="tabCel" style="text-align: center;">${obj.nomeRequerente}</td>
							<td class="tabCel" style="text-align: center;">${obj.qtdPagas}/${obj.qtdeParcelas}</td>
							<td class="tabCel" style="text-align: center;">${obj.dataUltimoPagamento}</td>
							<td class="tabCel" style="text-align: center;">${obj.numeroGuia}</td>
							<td class="tabCel" style="text-align: center;">${obj.descTipoGuia}</td>							
							<td class="tabCel" style="text-align: center;">${obj.descSituacaoGuia}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br />
			<div class="submit-wrapper">
				<input type="submit"
					title="Selecione uma guia na tabela acima."
					name="prepararEmissao2aViaGuiaDam"
					value="2ª VIa"
					class="button, idDamEmitir" id="idDamEmitir"
					onclick="return acionarDamLink()">
			</div>
		</c:if>

		<div class="submit-wrapper">
			<a class="submit" href="<%=actionVoltar%>">Voltar</a>
		</div>
	</form>
</div>