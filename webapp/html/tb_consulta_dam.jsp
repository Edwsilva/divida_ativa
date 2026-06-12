<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="anoExercicio" value="${objeto.exercicio}" />
	<portlet:param name="parcelamento" value="${parcelamento}" />
	<portlet:param name="parcelar" value="${parcelar}" />	
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="action" value="voltarOrigemConsultaDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="parcelarOuprepararEmissaoGuiaDamURL">
	<portlet:param name="action" value="parcelarOuprepararEmissaoGuiaDam" />
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="chbcda" value="${chbcda}" />
	<portlet:param name="rdguia" value="${rdguia}" />
	<portlet:param name="segundaVia" value="${segundaVia}" />
	<portlet:param name="dataVencimento" value="${dataVencimento}" />
	<portlet:param name="parcelamento" value="${parcelamento}" />
	<portlet:param name="parcelar" value="${parcelar}" />		
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />

<script type="text/javascript" charset="utf-8">
$(document).ready(function(){

});
function marcarOuDesmarcarTodas() {
	$('#chkTodasNenhuma').change(function() {
		if (this.checked == true) {
			$("input[name=chbcda]").each(function() {
				if (this.disabled == false)
					this.checked = true;
			});
		} else {
			$("input[name=chbcda]").each(function() {
				this.checked = false;
			});
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

function acionarParcelarDamLink() {
	return acionarDamLink("S");
}

function acionarDamLink(parcelar) {
	$("#parcelar").val(parcelar);
	var vals = "";
	$("input[type=checkbox][name='chbcda']:checked").each(function() {
		vals = vals + $(this).val() + ",";
	});

	if (vals == "") {
		$("input[type=checkbox][name='chbcda']").each(function() {
			if (this.checked == false) {
				alert('Por favor, selecione todas as certidões ou somente as certidões que deseja emitir a guia de pagamento.');
				return false;
			}
		});
	}
	
    var stFase = '';
	var stFasePE = '';
    var stFaseOutra = '';
    var ferrou = false;
    var strCDAsParc = "";
    //var temSuspensaParcelar = false;
    //var temLeilaoParcelar = false;
    
    var naoTemSituacaoParcelar = false;
    
    var temRequerimentoParcelamentoAberto = false;

    $("#tbDividas > tbody > tr").each(function () {
    	if ($(this).find("td").find("input:checkbox").is(":checked")) {
    		stFase = $(this).find("td").eq(10).html();
    		stSituacao = $(this).find("td").eq(9).html();
    		stReqParc  = $(this).find("td").eq(11).html();

    		if (stFase.indexOf('xtraj', 0) > 0)
    			stFasePE = stFase;
    		else
    			stFaseOutra = stFase;
            ferrou = (stFasePE != '' && stFaseOutra != '');
		
            /*
            if (stSituacao.indexOf("uspens", 0) > 0 && parcelar=="S")
				temSuspensaParcelar = true;
			if (stSituacao.indexOf("eil", 0) > 0 && parcelar=="S")
				temLeilaoParcelar = true;			
			*/
			
			if (parcelar=="S")
				if (stSituacao.indexOf("obran", 0) > 0 || stSituacao.indexOf("nscrit", 0) > 0)
				{
					if (stSituacao.indexOf("arant", 0) > 0)
						naoTemSituacaoParcelar = true;
				}
				else
					naoTemSituacaoParcelar = true;
			
			if (stReqParc != "" && parcelar=="S"){
				temRequerimentoParcelamentoAberto = true;
				strCDAsParc = strCDAsParc +	", " + $(this).find("td").eq(0).find("input").data('text');
			}
        }
    	if (parcelar=="S" && naoTemSituacaoParcelar) {
        	alert('Só é permitido parcelar CDA na situação Inscrita e Cobrança.');
        	return false;
        }    	
        /*if (temSuspensaParcelar) {
        	alert('Não é permitido parcelar CDAs suspensas.');
        	return false;
        }
        if (temLeilaoParcelar) {
        	alert('Não é permitido parcelar CDAs na situação de Leilão.');
        	return false;
        }
        */
	});

    if (temRequerimentoParcelamentoAberto) {
		strCDAsParc = strCDAsParc.substring(2);
    	alert('Já há requerimento de parcelamento em aberto para a(s) CDA(s) ' + strCDAsParc + ".");
    	return false;
    }  	
    
    //if (vals != "" && !temSuspensaParcelar && !temRequerimentoParcelamentoAberto && !temLeilaoParcelar)
    if (vals != "" && !temRequerimentoParcelamentoAberto && !naoTemSituacaoParcelar)
    	return true;
	return false;
}

function acionarLiquidacaoDamLink() {
	var vals = "";

	$("#segundaVia").val("0");
	
	$("input[type=radio][name='rdguia']:checked").each(function() {
		vals = vals + $(this).val() + ",";
	});

	if (vals != "") {
		return true;
	} else {
		$("input[type=radio][name='rdguia']").each(
			function() {
				if (this.checked == false) {
					alert('Por favor, selecione a guia que deseja emitir a guia de liquidação.');
					return false;
				}
			});
	}
	return false;
}

function acionar2aViaDamLink() {
	var vals = "";

	$("#segundaVia").val("1");

	$("input[type=radio][name='rdguia']:checked").each(function() {
		vals = vals + $(this).val() + ",";
	});

	if (vals != "") {
		return true;
	} else {
		$("input[type=radio][name='rdguia']").each(
			function() {
				if (this.checked == false) {
					alert('Por favor, selecione a guia que deseja emitir a 2ª via.');
					return false;
				}
			});
	}
	return false;
}

</script>

<div id="consultaDam">
	<form action="${parcelarOuprepararEmissaoGuiaDamURL}" method="post">
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />
		
		<input type="hidden" name="numInscricao" value="${numInscricao}" />
		<input type="hidden" name="numCDA" value="${numCDA}" />
		<input type="hidden" name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
		<input type="hidden" name="parcelamento" id="parcelamento" value="${parcelamento}"/>
		<input type="hidden" name="parcelar" id="parcelar" value="${parcelar}"/>	

		<p id="dados-imovel-selecionado">
			<liferay-ui:message key="mensagem.dam.titulo" />.
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
		<c:if test="${totalCDAs == null}">
			<p id="dados-imovel-selecionado">Houve um problema no processamento.</p>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>
		</c:if>
		<c:if test="${totalCDAs == 0}">
			<p id="dados-imovel-selecionado">Não há certidões em aberto.</p>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>
		</c:if>
		<input type="hidden" name="allchkb" value="${allchkb}" />
		<input type="hidden" name="dataVencimento" value="-1"/>
		<c:if test="${totalAVista > 0}">
			<table class="fancy-table" id="tbDividas">
				<thead>
					<tr>
						<th colspan="12" class="th">Relação de Certidões de Dívida Ativa Não Parceladas.
							<p style="color: #CF0000; font-size: 12px; line-height: 10px;">*
								Por favor, selecione as certidões que deseja emitir a guia de pagamento.</p>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:if test="${empty numExecucaoFiscal}">
							<th scope="row" class="tabCel"><input type="checkbox"	name="chbTodasCDAs" id="chkTodasNenhuma" onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" style="vertical-align: middle; margin-bottom: 8px;" />&nbsp;&nbsp;Todas</th>
						</c:if>
						<c:if test="${not empty numExecucaoFiscal}">
							<th scope="row" class="tabCel"><input type="checkbox"	name="chbTodasCDAs" id="chkTodasNenhuma" onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" style="vertical-align: middle; margin-bottom: 8px;" checked disabled />&nbsp;&nbsp;Todas</th>
						</c:if>
						<th scope="row" class="tabCel" style="text-align: center;">Contribuinte</th>
						<th scope="row" class="tabCel" style="text-align: center;">Saldo Principal</th>
						<th scope="row" class="tabCel" style="text-align: center;">Situação Principal</th>
						<th scope="row" class="tabCel" style="text-align: center;">Saldo Honorários</th>
						<th scope="row" class="tabCel" style="text-align: center;">Situação Honorários</th>						
						<th scope="row" class="tabCel" style="text-align: center;">Natureza</th>
						<th scope="row" class="tabCel" style="text-align: center;">Receita</th>						
						<th scope="row" class="tabCel" style="text-align: center;">Exercício</th>	
						<th scope="row" class="tabCel" style="text-align: center;">Situação</th>
						<th scope="row" class="tabCel" style="text-align: center;">Fase de Cobrança</th>
						<th scope="row" class="tabCel" style="text-align: center;">Nº Req. Parcelamento em Aberto</th>
					</tr>
					<c:forEach var="obj" items="${listaAVista}">
						<tr>
							<td class="tabCel">
								<c:choose>
									<c:when test="${obj.habilita ==  0}">
										<input type="checkbox" id="idcheck" name="chbcda" class="chbcda" value="${obj.posicao}" data-text="${obj.numero}" onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" disabled/>&nbsp;&nbsp;${obj.numero}
									</c:when>
									<c:otherwise>
										<c:if test="${empty numExecucaoFiscal}">
											<input type="checkbox" id="idcheck" name="chbcda" class="chbcda" value="${obj.posicao}" data-text="${obj.numero}"  onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" />&nbsp;&nbsp;${obj.numero}
										</c:if>
										<c:if test="${not empty numExecucaoFiscal}">
											<input type="checkbox" id="idcheck" name="chbcda" class="chbcda" value="${obj.posicao}" data-text="${obj.numero}"  onfocus="marcarOuDesmarcarTodas();" onclick="marcarOuDesmarcarTodas();" checked disabled />&nbsp;&nbsp;${obj.numero}
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="tabCel" style="text-align: center;">${obj.nome}</td>
							<td class="tabCel" style="text-align: center;">${obj.saldo}</td>
							<td class="tabCel" style="text-align: center;">${obj.situacao}</td>
							<td class="tabCel" style="text-align: center;">${obj.valHonorarios}</td>
							<td class="tabCel" style="text-align: center;">${obj.situacaoHon}</td>							
							<td class="tabCel" style="text-align: center;">${obj.descNaturezaDivida}</td>
							<td class="tabCel" style="text-align: center;">${obj.receita}</td>							
							<td class="tabCel" style="text-align: center;">${obj.anoExercicio}</td>		
							<td class="tabCel" style="text-align: center;">${obj.situacao}</td>
							<td class="tabCel" style="text-align: center;">${obj.faseCobranca}</td>
							<td class="tabCel" style="text-align: center;">${obj.numProtocoloRequerimentoParcelamentoEmAberto}</td>							
							<td class="tabCel" style="display:none;">${obj.grupo}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br />
			<div class="submit-wrapper">
				<c:if test="${empty parcelamento || parcelamento != 'S'}">
				<input type="submit"
					title="Selecione ao menos uma certidão na tabela acima."
					name="prepararEmissaoGuiaDam"
					value="Emitir Guia de Pagamento à Vista"
					class="button, idDamEmitir" id="idDamEmitir"
					onclick="return acionarDamLink('N')">
				</c:if>
				<input type="submit"
					title="Selecione ao menos uma certidão na tabela acima."
					name="parcelarOuprepararEmissaoGuiaDam"
					value="Parcelar"
					class="button, idDamEmitir" id="idDamEmitirParcelamento"
					onclick="return acionarParcelarDamLink()">
			</div>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>			
		</c:if>
		
		<hr>
		
		<c:if test="${totalParcelado > 0}">
			<table class="fancy-table">
				<thead>
					<tr>
						<th colspan="7" class="th">Relação de Certidões de Dívida Ativa Parceladas.
							<p style="color: #CF0000; font-size: 12px; line-height: 10px;">*
								Por favor, selecione as guias de pagamento que deseja liquidar.</p>
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
					<c:forEach var="obj" items="${listaParcelado}">
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
			<input type="hidden" id="segundaVia" name="segundaVia" value="0">
			<br />
			<div class="submit-wrapper">
				<input type="submit"
					title="Selecione uma guia na tabela acima."
					name="prepararEmissaoLiquidacaoGuiaDam"
					value="Liquidar"
					class="button, idDamEmitir" id="idDamEmitirLiquidacao"
					onclick="return acionarLiquidacaoDamLink()">
			</div>
    		<div class="submit-wrapper">
				<input type="submit"
					title="Selecione uma guia na tabela acima."
					name="prepararEmissao2aViaGuiaDam"
					value="2ª Via"
					class="button, idDamEmitir" id="idDamEmitir2aVia"
					onclick="return acionar2aViaDamLink()">
			</div>
			<div class="submit-wrapper">
				<a class="submit" href="<%=actionVoltar%>">Voltar</a>
			</div>
		</c:if>		
	</form>
</div>