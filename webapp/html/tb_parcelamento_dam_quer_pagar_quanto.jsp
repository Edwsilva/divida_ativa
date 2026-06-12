<%@page
	import="br.gov.rj.rio.iplanrio.portalcarioca.dividaativaconsulta.vo.DamVO"%>
<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="tipoPessoa" value="${tipoPessoa}" />
	<portlet:param name="nomeContribuinte" value="${nomeContribuinte}" />		
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="parcelamento" value="${parcelamento}"/>
	<portlet:param name="parcelar" value="" />		
	<portlet:param name="action" value="voltarOrigemDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="prepararEmissaoGuiaDamURL">
	<portlet:param name="action" value="parcelarOuprepararEmissaoGuiaDam" />
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="tipoPessoa" value="${tipoPessoa}" />	
	<portlet:param name="nomeContribuinte" value="${nomeContribuinte}" />		
	<portlet:param name="chbcda" value="${chbcda}" />
	<portlet:param name="rdguia" value="${rdguia}" />
	<portlet:param name="segundaVia" value="${segundaVia}" />
	<portlet:param name="dataVencimento" value="${#dataVencimento}" />
	<portlet:param name="formaParcelamento" value="${formaParcelamento}" />	
	<portlet:param name="valor1aParcela" value="${valor1aParcela}" />	
	<portlet:param name="parcelamento" value="${parcelamento}" />
	<portlet:param name="parcelar" value="${parcelar}" />	
	<portlet:param name="qtdtParcelasFinalTabela" value="${qtdtParcelasFinalTabela}"/>
	<portlet:param name="radioSelecionado" value="${radioSelecionado}"/>	
	<portlet:param name="cdas" value="${cdas}"/>
	<portlet:param name="ehEnvio" value="${ehEnvio}"/>	
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="emitirGuiaDam"
	windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="emitirGuiaDam" value="emitirGuiaDam" />
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />


<div id="dam">
 	<p id="dados-imovel-selecionado">
		<liferay-ui:message key="mensagem.dam.consulta.parcelamento" />
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
	
	<c:if test="${erro == true}">
		<font color="#ff0000"> <b>${mensagemErro}</b></font>
		<br><br><br>
	</c:if>

	<c:if test="${erro == false}">
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
	
		<c:forEach var = "listaInscricoes" items="${listaInscricaoCDAs}">
			<br/><br/>
			<c:if test="${not empty listaInscricoes.codInscricaoImobiliaria}">
				<b>
					<liferay-ui:message key="mensagem.iptu.consulta.insc.imob" />
					<span><font color="blue">${listaInscricoes.codInscricaoImobiliariaFormatada}</font></span>.
				</b>
			</c:if>
			<table>
				<tr>
					<td>
						<table class="fancy-table tabela">
						<thead>
							<tr>
								<th colspan="8" class="th">Lista de dívidas</th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<th scope="row" class="tabCel"style="text-align: center;"><input type="checkbox" style="display:none" id="chkTodasNenhuma${listaInscricoes.codInscricaoImobiliaria}" name="chkTodasNenhuma${listaInscricoes.codInscricaoImobiliaria}" onfocus="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');" onclick="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');"
									style="vertical-align: middle; margin-bottom: 8px;" />&nbsp;&nbsp;Certidões</th>
								<th scope="row" class="tabCel" style="text-align: center;">Contribuinte</th>
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
												<input type="checkbox" style="display:none" class="chbcda" name="chbcda" value="${obj.posicao}" disabled/><input class="tabCel indiceCda" type="hidden" id="idIndiceCda"
													name="indiceCda" value="${obj.posicao}" />&nbsp;&nbsp;${obj.numero}
											</c:when>
											<c:otherwise>
												<input type="checkbox" style="display:none" class="chbcda" name="chbcda" value="${obj.posicao}" onfocus="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');" onclick="marcarOuDesmarcarTodas('${listaInscricoes.codInscricaoImobiliaria}');" checked/><input class="tabCel indiceCda" type="hidden" id="idIndiceCda"
													name="indiceCda" value="${obj.posicao}"/>&nbsp;&nbsp;${obj.numero}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tabCel" style="text-align: center;">${obj.nome}</td>
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
								<th scope="row" class="tabCel" style="text-align: center;" colspan=2>TOTAL</th>
								<th scope="row" class="tabCel" style="text-align: center;">${listaInscricoes.guiaPagamento.valorSaldoTotalPrincipal}</th>
								<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">${listaInscricoes.guiaPagamento.valorTotalDescontoPrincipal}</th>
								<th scope="row" class="tabCel" style="text-align: center;">${listaInscricoes.guiaPagamento.valorSaldoTotalHonorario}</th>
								<th scope="row" class="tabCel" style="text-align: center;background-color:#92D8F1;">${listaInscricoes.guiaPagamento.valorTotalDescontoHonorario}</th>
								<th scope="row" class="tabCel" style="text-align: center" colspan=3></th>
						</tfoot>
						</table>
					</td>
					<td style="padding-left: 15px">
						<c:if test="${not empty listaInscricoes.guiaPagamento.execucoesFiscais}">		
							<table>
								<tr>
									<td>
										<table class="fancy-table tabela" style="width: 40%;text-align:left;">
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
					</td>
				</tr>
			</table>
			<br>
			<table style="widht:100%">
				<tr>
					<td>
						<table class="fancy-table tabela" style="width:100%">
						<thead>
							<tr>
								<th class="th"><font style="font-size: 120%">Valor Total à Vista</font></th>
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
					</td>
					<td>
						<c:if test="${not empty listaInscricoes.guiaPagamento.valorTotalGuia}">
							<div class="submit-wrapper" style="margin: 10px;">
								<input type="submit"
									title="Impressão das guias de pagamento."
									name="prepararEmissaoGuiaDam" value="Imprimir Guia à Vista"
									class="button, idDamEmitir" id="idDamEmitir"
									onclick="acionarDamLink('<%=emitirGuiaDam%>');return false" /> <a
									id="linkDamEmitir" href="<%=emitirGuiaDam%>"></a>
							</div>
						</c:if>
					</td>
				</tr>
			</table>
  		</c:forEach>
  		<hr>
  	</c:if>
	<form action="${prepararEmissaoGuiaDamURL}" method="post">
 	  <c:if test="${erro == false}">	
 		<input type="hidden" name="numInscricao" value="${numInscricao}" />
		<input type="hidden" name="tipoPessoa"   id="tipoPessoa" value="${tipoPessoa}"/>
		<input type="hidden" name="nomeContribuinte"   id="nomeContribuinte" value="${nomeContribuinte}"/>		
		<input type="hidden" name="dataVencimento" id="dataVencimento" value="${dataVencimento}" />		
		<input type="hidden" name="qtdtParcelasFinalTabela" id="qtdtParcelasFinalTabela" value="${qtdtParcelasFinalTabela}" />	
		<input type="hidden" name="radioSelecionado"	id="radioSelecionado" value="${radioSelecionado}" />	
		<input type="hidden" name="cdas"	id="cdas" value="${cdas}" />	
		<input type="hidden" name="formaParcelamento" id="formaParcelamento" value="${formaParcelamento}" />		
		<input type="hidden" name="valor1aParcela" id="valor1aParcela" value="${valor1aParcela}" />	
		<input type="hidden" name="numCDA" value="${numCDA}" />
		<input type="hidden" name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
		<input type="hidden" name="numeroGuia" value="${numeroGuia}" />		
		<input type="hidden" name="parcelamento" value="${parcelamento}"/>
		<input type="hidden" name="parcelar" value="S"/>
		<input type="hidden" name="ehEnvio" id="ehEnvio" value="${ehEnvio}"/>
		<table>
			<tr>
				<td>
					<table class="fancy-table tabela" style="width: 100%; text-align: left">
					<thead>
						<tr>
							<th colspan="5" class="th">Formas de Pagamento</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row" class="tabCel" style="text-align: center;" width="23%">Nº de Parcelas</th>
							<th scope="row" class="tabCel" style="text-align: center;" width="23%">Valor 1ª Cota</th>
							<th scope="row" class="tabCel" style="text-align: center;" width="23%">Juros Totais</th>
							<th scope="row" class="tabCel" style="text-align: center;" width="23%">Descontos Totais</th>
							<th scope="row" class="tabCel" style="text-align: center;"></th>				
						</tr>
						<c:if test="${not empty primeirasParcelas}">
							<c:forEach var="prime" items="${primeirasParcelas}">
								<c:if test="${not empty prime.qtdeParcelas && prime.qtdeParcelas==12}">
									<tr>
										<td class="tabCel" style="text-align: center;font-weight: bold;">12</td>
										<td class="tabCel" style="text-align: center;">${prime.valor1aParcela}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorJuros}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorDescontos}</td>
										<td class="tabCel" style="text-align: center;">
											<input class="tabCel rdqtdeParcelas " type="radio" id="idrd" name= "rdqtdeParcelas" value="${prime.qtdeParcelas}"/>
										</td>								
									</tr>
								</c:if>
								<c:if test="${not empty prime.qtdeParcelas && prime.qtdeParcelas==24}">
									<tr>
										<td class="tabCel" style="text-align: center;font-weight: bold;">24</td>
										<td class="tabCel" style="text-align: center;">${prime.valor1aParcela}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorJuros}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorDescontos}</td>
										<td class="tabCel" style="text-align: center;">
											<input class="tabCel rdqtdeParcelas " type="radio" id="idrd" name= "rdqtdeParcelas" value="${prime.qtdeParcelas}"/>
										</td>								
									</tr>
								</c:if>
								<c:if test="${not empty prime.qtdeParcelas && prime.qtdeParcelas==36}">
									<tr>
										<td class="tabCel" style="text-align: center;font-weight: bold;">36</td>
										<td class="tabCel" style="text-align: center;">${prime.valor1aParcela}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorJuros}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorDescontos}</td>
										<td class="tabCel" style="text-align: center;">
											<input class="tabCel rdqtdeParcelas " type="radio" id="idrd" name= "rdqtdeParcelas" value="${prime.qtdeParcelas}"/>
										</td>								
									</tr>
								</c:if>
								<c:if test="${not empty prime.qtdeParcelas && prime.qtdeParcelas==48}">
									<tr>
										<td class="tabCel" style="text-align: center;font-weight: bold;">48</td>
										<td class="tabCel" style="text-align: center;">${prime.valor1aParcela}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorJuros}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorDescontos}</td>
										<td class="tabCel" style="text-align: center;">
											<input class="tabCel rdqtdeParcelas " type="radio" id="idrd" name= "rdqtdeParcelas" value="${prime.qtdeParcelas}"/>
										</td>								
									</tr>
								</c:if>
								<c:if test="${not empty prime.qtdeParcelas && prime.qtdeParcelas==84}">
									<tr>
										<td class="tabCel" style="text-align: center;font-weight: bold;">84</td>
										<td class="tabCel" style="text-align: center;">${prime.valor1aParcela}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorJuros}</td>
										<td class="tabCel" style="text-align: center;">${prime.valorDescontos}</td>
										<td class="tabCel" style="text-align: center;">
											<input class="tabCel rdqtdeParcelas " type="radio" id="idrd" name= "rdqtdeParcelas" value="${prime.qtdeParcelas}"/>
										</td>								
									</tr>
								</c:if>
							</c:forEach>
							<tr>
								<td class="tabCel" style="text-align: center;"><input type="text" name="qtdeParcelas" id="tbQtdepracelas" maxlength="2" style="width:15px;height:10px;"/>&nbsp;<sup><font style="size:300pt">*</font></sup></td>
								<!--td class="tabCel" style="text-align: center;"><div id="valorPrimaParcela"></div></td-->
								<td class="tabCel" style="text-align: center;"><input type="text" name="valorPrimaParcela" id="valorPrimaParcela" style="height:10px;"/>&nbsp;<sup><font style="size:300pt">*</font></sup></td>
								<td class="tabCel" style="text-align: center;"><div id="valorJurosParcela"></div></td>
								<td class="tabCel" style="text-align: center;"><div id="valorDescontosParcela"></div></td>
								<td class="tabCel" style="text-align: center;">
									<input class="tabCel rdqtdeParcelas " type="radio" id="idrd" name= "rdqtdeParcelas" value="escolhaDoUsuario"/>
								</td>									
							</tr>
							<tr>
								<td colspan="5"><h5>* Informar nº de parcelas (${minimoParcelas} a ${maximoParcelas}) ou o valor aproximado que deseja pagar por parcela.</h5></td>
							</tr>
						</c:if>
					</tbody>
					</table>
       			</td>
       			<td style="width:50%">
       				<table class="fancy-table tabela" style="vertical-align: top;margin: 0 0 0 10px;border-style:none">
       					<tr>
       						<td style="border-style:none;">
       							<h5 style="margin: 10px;">No caso de parcelamento, incidirá 1% a.m. de juros simples sobres as parcelas, além da correção monetária anual pelo IPCA-E.</h5>
       						</td>
       					</tr>
       				</table>
       			</td>
    		</tr>
    	</table>
       
		<select id="formaPagamento" name="formaPagamento" style="visibility: hidden;">
			<option value="0" selected>Selecione a forma de pagamento...</option>
			<c:if test="${not empty primeirasParcelas}">
				<c:forEach var="prime" items="${primeirasParcelas}">
					<option id="opt${prime.qtdeParcelas}" value="${prime.valor1aParcela}">${prime.valorJuros};${prime.valorDescontos}</option>
				</c:forEach>
			</c:if>
		</select>

	</c:if>
		<table style="border-collapse: separate; border-spacing: 1px;padding: 1px;border: 0">
			<tr>
				<td valign="top">
					<c:if test="${erro == false}">
						<div class="submit-wrapper">
							<input type="submit" name="simular" style="display:none" value="" class="button, idDamEmitir" id="idDamSimular" onclick="return acionarSimularDamLink()">
						</div>
						<div class="submit-wrapper">
							<input type="submit" title="Finalizar requerimento." name="finalizarRequerimentoParcelamentoDam" value="Requerer Parcelamento" class="button, idDamEmitir" id="idDamEmitir" onclick="return acionarParcelarDamLink()">
						</div>
					</c:if>
				</td>
				<td>&nbsp;</td>
				<td>	
					<div class="submit-wrapper">
						<a class="submit" id="idVoltar" href="<%=actionVoltar%>">Voltar</a>
					</div>
				</td>
			</tr>
		</table>
  </form>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		$("#tbQtdepracelas").val($("#qtdtParcelasFinalTabela").val());
		if ($("#tbQtdepracelas").val() > "")
			$('#tbQtdepracelas').keyup();
		
		$('input:radio[name=rdqtdeParcelas][value=' + $("#radioSelecionado").val() + ']').click();
		
		//$('#valorPrimaParcela').mask("#.##0,00", { reverse: true });
		$("#valorPrimaParcela").mask("9.999,99");
		
		//$("#tbQtdepracelas").focus();
		$("#vencimento").focus();		
	});
	
	/*
	Quer pagar quanto? x
menorDiferença = valor[1]
menorPrestação = 1
Para i de 1 a parcela_máxima
início
	se absoluto(valor[i] - x) < menorDiferença
	inicio
		menorDiferença = absoluto(valor(i) - x
		menorPrestação = i
	fim
	se não
	    sai
	fim se
fim para
	*/
	
	$('#tbQtdepracelas').click(function(){
		$('input:radio[name=rdqtdeParcelas][value=escolhaDoUsuario]').click();
		$('#tbQtdepracelas').select();
	});
	
	$('#tbQtdepracelas').keyup(function(){
		$('input:radio[name=rdqtdeParcelas][value=escolhaDoUsuario]').click();
		var val = parseInt($(this).val());
		var valorOpcao = $("[id='opt" + val + "']").val();
		var textoOpcao = $("[id='opt" + val + "']").text();
		var textoJuros = textoOpcao.substring(0, textoOpcao.indexOf(";"));
		
		var textoDescontos = "";
		if (textoOpcao.lastIndexOf(";") < textoOpcao.length - 1)
			textoDescontos = textoOpcao.substring(textoOpcao.indexOf(";")+1);

		if (textoOpcao == "")
			$("#valorPrimaParcela").val("");
		else
			$("#valorPrimaParcela").val(valorOpcao);
		$("#valorJurosParcela").text(textoJuros);
		$("#valorDescontosParcela").text(textoDescontos);
	});	
	
	$("#tbQtdepracelas").on('keydown', function(e) {
		    var keyCode = e.keyCode || e.which,
		      pattern = /\d/,
		      // Permite somente Backspace, Delete e as setas direita e esquerda, números do teclado numérico - 96 a 105 - (além dos números)
		      keys = [ 46, 8, 9, 37, 39, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105 ];
		  
		    if( ! pattern.test( String.fromCharCode( keyCode ) ) && $.inArray( keyCode, keys ) === -1 ) {
		      return false;
		    }
		  });
	
	
	/*$(function(){
		  $("#valorPrimaParcela").bind("change keyup input", function () {
		    var position = this.selectionStart - 1;
		    //remove all but number and .
		    var fixed = this.value.replace(/[^0-9\,]/g, '');
		    if (fixed.charAt(0) === ',') //can't start with .
		      fixed = fixed.slice(1);

		    var pos = fixed.indexOf(",") + 1;
		    if (pos >= 0) //avoid more than one .
		      fixed = fixed.substr(0, pos) + fixed.slice(pos).replace(',', '');

		    if (this.value !== fixed) {
		      this.value = fixed;
		      this.selectionStart = position;
		      this.selectionEnd = position;
		    }
		  });
		});*/
	
	function marcarOuDesmarcarTodas(inscricaoImobiliaria) {
	$('#chkTodasNenhuma'+inscricaoImobiliaria).change(function() {
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
				if (this.checked == false)
					todas = false;
			});
		} else {
			$("input[name=chbcda]").each(function() {
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
		
		$("#ehEnvio").val("N");
		
		$("#qtdtParcelasFinalTabela").val($("#tbQtdepracelas").val());
		$("#radioSelecionado").val($('input[name="rdqtdeParcelas"]:checked').val());

		return true;
	}
	
	function acionarParcelarDamLink() {
		var vals           = "";
		var valor1aParcela = "";
	
		$("input[type=radio][name='rdqtdeParcelas']:checked").each(function() {
			vals = vals + $(this).val();
			valor1aParcela = valor1aParcela + $(this).text();
		});

		if (vals == "escolhaDoUsuario") {
			vals = $('#tbQtdepracelas').val();
			if(vals==""){
				alert('Por favor, informe o nº de parcelas.');
				return false;
			}
		}
	
		if (vals == "") {
			$("input[type=radio][name='rdqtdeParcelas']").each(
				function() {
					if (this.checked == false) {
						alert('Por favor, selecione a forma de pagamento.');
						return false;
					}
				});
		}
	
		if (vals == "")
			return false;
		
		vals = parseInt(vals); // Para quem digitar '01',' 02'... não dar erro ao comparar com '1', '2'... 
		
		// Emissão guia à vista
		if (vals == "1"){
			if (confirm("Você escolheu pagar em uma parcela. Confirma a emissão de guia à vista?"))
				acionarDamLink();
				return false;
		}
		
		valor1aParcela = $("[id='opt" + vals + "']").val();
		
		if (valor1aParcela == "" || (typeof valor1aParcela == "undefined")){
			alert ('Quantidade de parcelas não disponível para pagamento desse valor.');
			return false;
		}
		
		$("#formaParcelamento").val(vals);
		$("#valor1aParcela").val(valor1aParcela);
		
		vals = "";
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

		$("#dataVencimento").val(vals);
		$("#ehEnvio").val("S");		

		$("#qtdtParcelasFinalTabela").val($("#tbQtdepracelas").val());
		$("#radioSelecionado").val($('input[name="rdqtdeParcelas"]:checked').val());		

		return true;
}

	function acionarDamLink() {
		var vals = "";
		$("select[name='dataVencimento']").each(function() {
			vals = $(this).val();
		});
		if (vals == "-1") {
			$("select[name='dataVencimento']").each(function() {
				alert('Por favor, selecione a data de vencimento da guia.');
				return false;
			});
		} else {
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
		var vals = "V, ";
		$("select[name='optDataVencimento']").each(function() {
			vals = vals + $(this).val() + ",";
		});

		$("input[type=checkbox][name*='chbcda']:checked").each(function() {
				vals = vals + $(this).val() + ",";
			});
		
		return vals;
	}

</script>