<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="numGuiaPagamento" value="${numGuiaPagamento}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="anoExercicio" value="${objeto.exercicio}" />
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="action" value="voltarOrigemDamRegularizacao" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="simularRegularizacaoGuiaDamURL">
	<portlet:param name="action" value="prepararEmissaoRegularizacaoGuiaDam" />
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />	
	<portlet:param name="chbcda" value="${chbcda}" />
	<portlet:param name="todas" value="${#todas}" />
	<portlet:param name="rdguia" value="${rdguia}" />
	<portlet:param name="dataVencimento" value="${#dataVencimento}" />	
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="emitirRegularizacaoGuiaDam"
	windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="emitirRegularizacaoGuiaDam" value="emitirRegularizacaoGuiaDam" />
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />

<script type="text/javascript" charset="utf-8">
$(document).ready(function(){
	calcularTotal(false);
	marcarOuDesmarcarTodas();
});

function marcarOuDesmarcarTodas() {
	$('#chkTodasNenhuma').change(function() {
		if (this.checked == true) {
			$("input[name=chbcda]").each(function() {
				if (this.disabled == false)
					this.checked = true;
			});
			calcularTotal(true);
		} else {
			$("input[name=chbcda]").each(function() {
				this.checked = false;
			});
			calcularTotal(false);
		}
	});
	
	$('.chbcda').change(function() {
		var todas = true;
		var este  = this.checked;
		if (this.checked == true) {
			$("input[name=chbcda]").each(function() {
				if (this.disabled == false)
					if (this.checked == false)
						todas = false;
			});
		} else {
			$("input[name=chbcda]").each(function() {
				if (this.disabled == false)
					if (this.checked == true)
						todas = false;
			});
		}
        if (!todas)
            este = false;
		$("input[name=chbTodasCDAs]").each(function() {
			this.checked = este;
		});
	});
}	

function calcularTotal(todas){
    var total = 0;
    $("#tbDividas > tbody > tr").each(function () {
    	if ($(this).find("td").find("input:checkbox").is(":checked") || todas) {
    		var valorTotal = $(this).find("td").eq(0).find("input").data('text');
			if (valorTotal != null) {
				valor = parseFloat(valorTotal.replace("R$ ", "").replace(".", "").replace(",", "."));    	
 	       		total = total + valor;
			}
		}
	});	
	
	$("#total").text("TOTAL: " + total.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }));
}

function acionarSimularDamLink() {
	var vals = "";

	$("select[name='optDataVencimento']").each(function() {
		vals = $(this).val();
	});
	if (vals == "-1") {
		$("select[name='optDataVencimento']").each(function() {
			return false;
		});
	}

	if (vals == "-1")
		return false;
	
	$('#todas').val("0");
	if ($('#chkTodasNenhuma').is(":checked"))
		$('#todas').val("1");
	
	$("#dataVencimento").val(vals);
	vals = "";
	
	$("input[type=checkbox][name='chbcda']:checked").each(function() {
		vals = vals + $(this).val() + ",";
	});	

	//if (vals == "")
	//	return false;
	
	return true;
}

function acionarDamLink() {
	var vals = "";
	
	$("select[name='optDataVencimento']").each(function() {
		vals = $(this).val();
	});
	if (vals == "-1") {
		$("select[name='optDataVencimento']").each(function() {
			alert('Por favor, selecione a data de vencimento.');
			return false;
		});
	}

	if (vals == "-1")
		return false;
	
	vals = "";
	
	$("input[type=checkbox][name='chbcda']:checked").each(function() {
		vals = vals + $(this).val() + ",";
	});
	
	if (vals == "") {
		$("input[type=checkbox][name='chbcda']").each(function() {
			if (this.checked == false) {
				alert('Por favor, selecione as cotas que deseja emitir a guia de pagamento.');
				return false;
			}
		});
	}
	
    if (vals == "")
    	return false;
    
    vals = "";
	
	$("select[name='optDataVencimento']").each(function() {
		vals = vals + $(this).val() + ",";
	});

	vals = vals + $('#rdguia').val() + ",";
	
	$("input[type=checkbox][name*='chbcda']:checked").each(function() {
			vals = vals + $(this).val() + ",";
		});
	
	var query = "&<portlet:namespace/>allcda=" + vals;
	$('#idDamEmitir').click(window.open($('#linkDamEmitir').attr("href") + query, '_blank'));

	$("#dataVencimento").val("666"); // Ao esse código à data de vencimento, irá redirecionar à tela inicial. Entende?
	return true;
}

</script>

<div id="simularRegularizacaoDam">
	<form action="${simularRegularizacaoGuiaDamURL}" method="post">
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />
		
		<input type="hidden" name="numInscricao" value="${numInscricao}" />
		<input type="hidden" name="numCDA" value="${numCDA}" />
		<input type="hidden" name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
		<input type="hidden" name="numGuiaPagamento" value="${numGuiaPagamento}"/>
		<input type="hidden" name="rdguia" id="rdguia" value="${rdguia}"/>
		<input type="hidden" name="todas" id="todas" value="${todas}"/>

		<p id="dados-imovel-selecionado">
			<liferay-ui:message key="mensagem.dam.titulo.regularizacao" />.
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
			<c:if test="${not empty numExecucaoFiscal}">
				<liferay-ui:message key="mensagem.dam.consulta.guiapagamento" />
				<span> ${numGuiaPagamento}</span>.
			</c:if>			
		</p>
		<c:if test="${empty mensagemErro && listaCotas == null}">
			<p id="dados-imovel-selecionado">Houve um problema no processamento.</p>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>
		</c:if>
		<c:if test="${totalCotas == 0}">
			<p id="dados-imovel-selecionado">Não há cotas de pagamento em atraso para a guia.</p>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>
		</c:if>
		<c:if test="${not empty mensagemErro}">
			<p id="dados-imovel-selecionado">${mensagemErro}</p>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>
		</c:if>		
		<input type="hidden" name="allchkb" value="${allchkb}" />
		<input type="hidden" name="dataVencimento" id="dataVencimento" value="${dataVencimento}"/>

		<c:if test="${empty mensagemErro && listaCotas != null}">
       		<table>
       			<tr>
       				<td>
       					<div>
							<label for="vencimento" style="float: left; margin: 3px 7px 0 0;"><liferay-ui:message key="mensagem.dam.vencimento" /></label> 
							<select id="vencimento"	name="optDataVencimento" style="float: left;" onchange="$('#idDamSimular').click();">
								<option value="-1">Selecione uma data...</option>
									<c:forEach var="obj" items="${datasVencimento}" varStatus="id">
										<c:if test="${obj == dataVencimento}">	
											<option value="${obj}" selected>${obj}</option>
										</c:if>
										<c:if test="${obj != dataVencimento}">
											<option value="${obj}" >${obj}</option>
										</c:if>		
									</c:forEach>
							</select>
						</div>
       				</td>
       			</tr>
       		</table>		
			<table class="fancy-table" id="tbDividas" style="width:50%;margin-left:10px;">
				<thead>
					<tr>
						<th colspan="4" class="th">Relação de Cotas de Pagamento em Atraso - Guia de Pagamento nº ${rdguia}.
							<!-- p style="color: #CF0000; font-size: 9px; line-height: 10px;">
								Por favor, selecione as cotas que deseja simular a regularização do pagamento.</p-->
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row" class="tabCel">
							<c:if test="${todas == '1'}">
								<input type="checkbox" name="chbTodasCDAs" id="chkTodasNenhuma" onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" checked="checked" style="vertical-align: middle; margin-bottom: 8px;" />&nbsp;&nbsp;Todas
							</c:if>
							<c:if test="${empty todas || todas != '1'}">
								<input type="checkbox" name="chbTodasCDAs" id="chkTodasNenhuma" onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" style="vertical-align: middle; margin-bottom: 8px;" />&nbsp;&nbsp;Parcela
							</c:if>
						</th>
						<th scope="row" class="tabCel" style="text-align: center;">Data Vencimento</th>
						<th scope="row" class="tabCel" style="text-align: center;">Valor da Cota</th>					
						<th scope="row" class="tabCel" style="text-align: center;">Valor da Cota Atualizado</th>
					</tr>
					<c:forEach var="obj" items="${listaCotas}">
						<tr>
							<td class="tabCel">
								<c:if test="${obj.selecionada == true}">
									<input type="checkbox" id="idcheck" name="chbcda" class="chbcda" value="${obj.numCotaPagamento}" data-text="${obj.valorTotalRegularizacao}" checked="checked"  onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" onchange="	calcularTotal();" />&nbsp;&nbsp;${obj.numCotaPagamento}
								</c:if>
								<c:if test="${obj.selecionada == false}">
									<input type="checkbox" id="idcheck" name="chbcda" class="chbcda" value="${obj.numCotaPagamento}" data-text="${obj.valorTotalRegularizacao}" onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" onchange="	calcularTotal();" />&nbsp;&nbsp;${obj.numCotaPagamento}
								</c:if>
							</td>
							<td class="tabCel" style="text-align: center;">${obj.dataVencimento}</td>
							<td class="tabCel" style="text-align: center;">${obj.valorDaCota}</td>						
							<td class="tabCel" style="text-align: center;">${obj.valorTotalRegularizacao}</td>
						</tr>
					</c:forEach>
					<tr>
						<td class="tabCel" style="text-align: left; font-weight: bold;" colspan="4"><div id="total">TOTAL: R$ 0,00</div></td>
					</tr>	
				</tbody>
			</table>
			<!-- 
			<br>
				<div style="text-align: left; color: red; font-weight: bold;">* Na emissão da guia, os valores serão atualizados para a data do vencimento selecionada.</div>
   			-->
   			<br />
   			<div class="submit-wrapper">
				<input type="submit" name="simular" style="display:none" value="" class="button, idDamEmitir" id="idDamSimular" onclick="return acionarSimularDamLink()">
			</div>
   			<div class="submit-wrapper">
				<input type="submit"
					title="Impressão das guias de pagamento."
					name="prepararEmissaoGuiaDam" value="Emitir Guia"
					class="button, idDamEmitir" id="idDamEmitir"
					onclick="return acionarDamLink('<%=emitirRegularizacaoGuiaDam%>')" /> <a
					id="linkDamEmitir" href="<%=emitirRegularizacaoGuiaDam%>"></a>
			</div>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>			
		</c:if>
		
	</form>
</div>