<%@page
	import="br.gov.rj.rio.iplanrio.portalcarioca.dividaativaconsulta.vo.DamVO"%>
<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="parcelamento" value="${parcelamento}"/>	
	<portlet:param name="parcelar" value=""/>
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="action" value="voltarOrigemDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="prepararEmissaoGuiaDamURL">
	<portlet:param name="action" value="prepararEmissaoGuiaDam" />
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="parcelamento" value="${parcelamento}"/>
	<portlet:param name="parcelar" value="N"/>		
	<portlet:param name="chbcda" value="${chbcda}" />
	<portlet:param name="rdguia" value="${rdguia}" />
	<portlet:param name="dataVencimento" value="${dataVencimento}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="emitirGuiaDam"
	windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="emitirGuiaDam" value="emitirGuiaDam" />
	<portlet:param name="chbcda" value="${chbcda}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="parcelarOuprepararEmissaoGuiaDamURL">
	<portlet:param name="action" value="parcelarOuprepararEmissaoGuiaDam" />
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="parcelamento" value="${parcelamento}"/>	
	<portlet:param name="parcelar" value="N"/>		
	<portlet:param name="cdas" value="${cdas}"/>
	<portlet:param name="rdguia" value="${rdguia}" />
	<portlet:param name="segundaVia" value="${segundaVia}" />	
	<portlet:param name="dataVencimento" value="${dataVencimento}" />
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />


<div id="dam">
  <form action="${emissaoGuiaDamURL}" method="post">
	<p id="dados-imovel-selecionado">
		<c:if test="${tipoGuia == 'V'}">		
			<liferay-ui:message key="mensagem.dam.titulo1.aVista" />.
		</c:if>
		<c:if test="${tipoGuia == 'L'}">		
			<liferay-ui:message key="mensagem.dam.titulo1.liquidacao" />.
		</c:if>
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
	<br /> 
		<input type="hidden" name="numInscricao" value="${numInscricao}" />
		<input type="hidden" name="dataVencimento" id="dataVencimento" value="${dataVencimento}" />			
		<input type="hidden" name="numCDA" value="${numCDA}" />
		<input type="hidden" name="rdguia" value="${rdguia}" />
		<input type="hidden" name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
		<input type="hidden" name="tipoGuia" value="${tipoGuia}" />		
		<input type="hidden" name="numeroGuia" value="${numeroGuia}" />		
		<input type="hidden" name="parcelamento" value="${parcelamento}"/>
		<input type="hidden" name="cdas"	id="cdas" value="${cdas}" />		
	
	<c:if test="${erro == true}">
		<font color="#ff0000"> <b>${mensagemErro}</b></font>
		<br><br><br>
	</c:if>
	<c:if test="${erro == false}">
		<c:forEach var = "listaInscricoes" items="${listaInscricaoCDAs}">
			<br/><br/>
			<c:if test="${not empty listaInscricoes.codInscricaoImobiliaria}">
				<b>
					<liferay-ui:message key="mensagem.iptu.consulta.insc.imob" />
					<span><font color="blue">${listaInscricoes.codInscricaoImobiliariaFormatada}</font></span>.
				</b>
			</c:if>
			<c:if test="${tipoGuia == 'V'}">
				<table class="fancy-table tabela">
					<thead>
						<tr>
							<th colspan="7" class="th">Lista de dívidas</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<th scope="row" class="tabCel"style="text-align: center;"><input type="checkbox" style="display:none" id="chkTodasNenhuma${listaInscricoes.codInscricaoImobiliaria}" name="chkTodasNenhuma${listaInscricoes.codInscricaoImobiliaria}" onfocus="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');" onclick="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');"
								style="vertical-align: middle; margin-bottom: 8px;" />&nbsp;&nbsp;Certidões</th>
							<th scope="row" class="tabCel" style="text-align: center;">Saldo Principal</th>
							<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">Desconto Principal</th>				
							<th scope="row" class="tabCel" style="text-align: center;">Honorários</th>
							<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">Desconto Honorários</th>
							<th scope="row" class="tabCel" style="text-align: center;">Natureza</th>
							<th scope="row" class="tabCel" style="text-align: center;">Situação</th>
						</tr>

						<c:forEach var="obj" items="${listaInscricoes.cdas}">
							<tr>
								<td class="tabCel" style="vertical-align: middle;text-align:center;">
									<c:choose>
										<c:when test="${obj.habilita == '0'}">
											<input type="checkbox" style="display:none" class="chbcda${listaInscricoes.codInscricaoImobiliaria}" name="chbcda${listaInscricoes.codInscricaoImobiliaria}" value="${obj.posicao}" disabled/><input class="tabCel indiceCda" type="hidden" id="idIndiceCda"
												name="indiceCda" value="${obj.posicao}" />&nbsp;&nbsp;${obj.numero}
										</c:when>
										<c:otherwise>
											<input type="checkbox" style="display:none" class="chbcda${listaInscricoes.codInscricaoImobiliaria}" name="chbcda${listaInscricoes.codInscricaoImobiliaria}" value="${obj.posicao}" onfocus="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');" onclick="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');" checked/><input class="tabCel indiceCda" type="hidden" id="idIndiceCda"
												name="indiceCda" value="${obj.posicao}"/>&nbsp;&nbsp;${obj.numero}
										</c:otherwise>
									</c:choose>
								</td>
								<c:choose>
									<c:when test="${(obj.codSituacaoCDA ==  2) || (obj.codSituacaoCDA ==  7) ||	(obj.codSituacaoCDA == 13) || 
												(obj.codSituacaoCDA == 30) || (obj.codSituacaoCDA == 45) || (obj.codSituacaoCDA  > 92) || 
												(obj.codSituacaoCDA == 0) ||
									          ( (obj.codSituacaoCDA ==  3)&& (obj.flgCampanha == 35) )}">
										<td class="tabCel" style="text-align: center;">${obj.situacao}</td>
									</c:when>
									<c:otherwise>
										<td class="tabCel" style="text-align: center;">${obj.saldo}</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${obj.desconto == 'R$ 0,00'}">
										<td class="tabCel" style="text-align: center;background-color:#92D8F1;font-weight: bold;">-</td>
									</c:when>
									<c:otherwise>
										<td class="tabCel" style="text-align: center;background-color:#92D8F1;font-weight: bold;">${obj.desconto}</td>
									</c:otherwise>					
								</c:choose>
								<c:choose>
									<c:when test="${(obj.codSituacaoHon ==  0) || (obj.codSituacaoHon == 20) || (obj.codSituacaoHon == 30) ||
							                	(obj.codSituacaoHon == 40) || (obj.codSituacaoHon == 50) || (obj.codSituacaoHon == 70)}">
										<td class="tabCel" style="text-align: center;">${obj.situacaoHon}</td>
									</c:when>
									<c:otherwise>
										<td class="tabCel" style="text-align: center;">${obj.valHonorarios}</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${obj.descontoHonorarios == 'R$ 0,00'}">
										<td class="tabCel" style="text-align: center;background-color:#92D8F1;font-weight: bold;">-</td>
									</c:when>
									<c:otherwise>
										<td class="tabCel" style="text-align: center;background-color:#92D8F1;font-weight: bold;">${obj.descontoHonorarios}</td>
									</c:otherwise>
								</c:choose>
								<td class="tabCel" style="text-align: center;">${obj.descNaturezaDivida}</td>
								<td class="tabCel" style="text-align: center;">${obj.situacao}	${obj.faseCobranca}</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
						<th scope="row" class="tabCel" style="text-align: center;">TOTAL</th>
						<th scope="row" class="tabCel" style="text-align: center;">${listaInscricoes.guiaPagamento.valorSaldoTotalPrincipal}</th>
						<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">${listaInscricoes.guiaPagamento.valorTotalDescontoPrincipal}</th>
						<th scope="row" class="tabCel" style="text-align: center;">${listaInscricoes.guiaPagamento.valorSaldoTotalHonorario}</th>
						<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">${listaInscricoes.guiaPagamento.valorTotalDescontoHonorario}</th>
						<th scope="row" class="tabCel" style="text-align: center" colspan=3></th>
					</tfoot>
				</table>
			</c:if>
			<c:if test="${tipoGuia == 'L'}">
				<table class="fancy-table tabela">
					<thead>
						<tr>
							<th colspan="3" class="th">Lista de dívidas</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<th scope="row" class="tabCel"style="text-align: center;">CDA(s)</th>
							<th scope="row" class="tabCel" style="text-align: center;">Saldo Restante</th>
							<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">Valor Desconto</th>				
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<th scope="row" class="tabCel" style="text-align: center;">
								<c:forEach var="obj" items="${listaInscricoes.cdas}">
									${obj.numero}<BR>
								</c:forEach>
							</th>
							<th scope="row" class="tabCel" style="text-align: center;">${listaInscricoes.guiaPagamento.valorSaldoTotal}</th>
							<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">${listaInscricoes.guiaPagamento.valorTotalDesconto}</th>
					</tfoot>
				</table>
			</c:if>
			<c:if test="${not empty listaInscricoes.guiaPagamento.execucoesFiscais}">		
				<br/>
				<table>
					<tr>
						<td>
							<table class="fancy-table tabela" style="width: 40%" align="left">
								<thead>
									<tr>
										<th colspan="2" class="th">Lista de GRERJ</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<th scope="row" class="tabCel" style="text-align: center;">Execução Fiscal</th>
										<th scope="row" class="tabCel" style="text-align: center;">Valor</th>				
									</tr>

									<c:forEach var="ef" items="${listaInscricoes.guiaPagamento.execucoesFiscais}">
										<tr>
											<td class="tabCel" style="text-align: center;">
												<input class="tabCel indiceEf" type="hidden" id="idIndiceEf" name="indiceEf" value="${ef.numExecucaoFiscal}" />${ef.numExecucaoFiscal}
											</td>
											<td class="tabCel" style="text-align: center;">${ef.valGrerj}</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<th scope="row" class="tabCel" style="text-align: center;">TOTAL</th>
										<th scope="row" class="tabCel" style="text-align: center;">${listaInscricoes.guiaPagamento.valorTotalPagarGrerj}</th>
									</tr>
								</tfoot>
							</table>
						</td>
					</tr>
				</table>
			</c:if>
			<br>
			<table class="fancy-table tabela" style="width:25%">
				<thead>
					<tr>
						<th class="th"><font style="font-size: 120%">Valor Total da Guia(*)</font></th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<c:if test="${empty listaInscricoes.guiaPagamento.valorTotalGuia}">
							<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1"><font style="font-size:140%">-</font></th>
						</c:if>
						<c:if test="${not empty listaInscricoes.guiaPagamento.valorTotalGuia}">
							<th scope="row" class="tabCel" style="text-align: center;background-color:#0A5889;color: #FFFFFF;"><font style="font-size:140%">${listaInscricoes.guiaPagamento.valorTotalGuia}</font></th>
						</c:if>
					</tr>
				</tfoot>
			</table>
			<br>
			<p id = "dados-imovel-selecionado"><span>(*) Para guias que vencem no mês que vem, serão acrescidos juros.</span></p>
			<hr>
		</c:forEach>
		
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td valign="top"><label for="vencimento" style="float: left; margin: 3px 7px 0 0;"><liferay-ui:message key="mensagem.dam.vencimento" /></label> 
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
				</td>
				<td>&nbsp;</td>
				<td valign="top">
					<div class="submit-wrapper">
							<input type="submit" name="simular" style="display:none" value="" class="button, idDamEmitir" id="idDamSimular" onclick="return acionarSimularDamLink()">
					</div>
					<div class="submit-wrapper">
						<input type="submit"
							title="Impressão das guias de pagamento."
							name="prepararEmissaoGuiaDam" value="Imprimir Guia"
							class="button, idDamEmitir" id="idDamEmitir"
							onclick="acionarDamLink('<%=emitirGuiaDam%>');return false" /> <a
							id="linkDamEmitir" href="<%=emitirGuiaDam%>"></a>
					</div>
				</td>
			</tr>
		</table>
	</c:if>
	<div class="submit-wrapper">
		<a class="submit" id="idVoltar" href="<%=actionVoltar%>">Voltar</a>
	</div>
  </form>
</div>
<br>
<c:if test="${tipoGuia == 'V'}">
	<!-- 
	<div>
		<p id = "dados-imovel-selecionado">Caso deseje parcelar o seu débito, dirija-se à Procuradoria da Dívida Ativa na Rua Sete de Setembro, nº 58-A, no horário das 9h às 16h, ou a um de nossos postos de atendimento, cuja localização e horário se encontram <a href="http://www.rio.rj.gov.br/web/pgm/divida-ativa" target="_blank"><span>aqui</span></a>.</p>
		<p id = "dados-imovel-selecionado">Documentação necessária: fotocópia da identidade e CPF.</p>
	</div>
	 -->
</c:if>
<script type="text/javascript">
	function marcarOuDesmarcarTodas(inscricaoImobiliaria) {
	$('#chkTodasNenhuma'+inscricaoImobiliaria).change(function() {
		if (this.checked == true) {
			$("input[name=chbcda"+inscricaoImobiliaria+"]").each(function() {
				if (this.disabled == false)
					this.checked = true;
			});
		} else {
			$("input[name=chbcda"+ inscricaoImobiliaria +"]").each(function() {
				this.checked = false;
			});
		}
	});
	
	$('.chbcda'+inscricaoImobiliaria).change(function() {
		var todas = true;
		var este  = this.checked;
		if (this.checked == true) {
			$("input[name=chbcda"+inscricaoImobiliaria+"]").each(function() {
				if (this.checked == false)
					todas = false;
			});
		} else {
			$("input[name=chbcda"+ inscricaoImobiliaria +"]").each(function() {
				if (this.checked == true)
					todas = false;
			});
		}
		if (!todas)
        	este = false;
		$("input[name=chkTodasNenhuma"+inscricaoImobiliaria+"]").each(function() {
			this.checked = este;
		});
	});
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

		$("#dataVencimento").val(vals);
		
		return true;
	}
	
	
	function acionarDamLink() {
		var vals = "";
		$("select[name='optDataVencimento']").each(function() {
			vals = $(this).val();
		});
		if (vals == "-1") {
			$("select[name='optDataVencimento']").each(function() {
				alert('Por favor, selecione a data de vencimento da guia.');
				return false;
			});
		} else 
		if ($("input[type=hidden][name='tipoGuia']").val() == "L"){
			var query = "&<portlet:namespace/>allcda=" + checkBox();
			$('#idDamEmitir').click(window.open($('#linkDamEmitir').attr("href") + query, '_blank'));
			return false;
		}
		else {
			var vals = "";
			
			$("input[type=checkbox][name*='chbcda']:checked").each(function() {
				vals = vals + $(this).val() + ",";
			});
			if (vals == "") 
				$("input[type=checkbox]").each(function() {
					if (this.checked == false) {
						alert('Não há certidões em situação permitida para a emissão de guia de pagamento cota única.');
						return false;
					}
				});
			else {
					var inscricao     = "";
					var qtdInscricoes = 0;
					$("input[type=checkbox][name*='chbcda']:checked").each(function() {
						if (inscricao != this.name) {
							qtdInscricoes = qtdInscricoes + 1;
							inscricao = this.name;
						}							
					});
					if (qtdInscricoes > 1) 
						$("input[type=checkbox]").each(function() {
							if (this.checked == false) {
								alert('Não é permitida a emissão de guia para mais de uma inscrição.');
								return false;
							}
						});
					else
		    			$("input[type=hidden][name='indiceCda']").each(function() {
							var query = "&<portlet:namespace/>allcda=" + checkBox();
							$('#idDamEmitir').click(window.open($('#linkDamEmitir').attr("href") + query, '_blank'));
							return false;
						});
			}
		}
	}

	function checkBox() {
		var tipoGuia = $("input[type=hidden][name='tipoGuia']").val();
		var vals = tipoGuia + ", ";
		$("select[name='optDataVencimento']").each(function() {
			vals = vals + $(this).val() + ",";
		});

		if (tipoGuia == "L") // Todas as CDAs
			vals = vals + $("input[type=hidden][name='numeroGuia']").val();
		else
			$("input[type=checkbox][name*='chbcda']:checked").each(function() {
				vals = vals + $(this).val() + ",";
			});
		
		return vals;
	}

</script>