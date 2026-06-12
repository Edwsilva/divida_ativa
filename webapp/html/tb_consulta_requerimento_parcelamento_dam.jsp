<%@page import="br.gov.rj.rio.iplanrio.portalcarioca.dividaativaconsulta.vo.RequerimentoParcelamentoDamVO"%>

<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
   <portlet:param name="origem" value="${origem}" />
   <portlet:param name="numInscricao" value="${numInscricao}" />
   <portlet:param name="numCDA" value="${numCDA}" />
   <portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
   <portlet:param name="action" value="voltarOrigem" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="menuConsulaRequerimentoParcelamentoDamURL">
   <portlet:param name="action" value="menuConsulaRequerimentoParcelamentoDam" />
   <portlet:param name="origem" value="informativo-divida-ativa.jsp" />
   <portlet:param name="numInscricao" value="${numInscricao}" />
   <portlet:param name="endereco" value="${endereco}" />
   <portlet:param name="numProtocoloRequerimento" value="${numProtocoloRequerimento}" />
   <%--<portlet:param name="opcaoDAM" value="${opcaoDAM}" />--%>
   <portlet:param name="numProtocoloRequerimentoCancelar" value="${numProtocoloRequerimentoCancelar}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="emitirFormularioGuiaDam" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
   <portlet:param name="numInscricao" value="${numInscricao}" />
   <portlet:param name="endereco" value="${endereco}" />
   <portlet:param name="numCDA" value="${numCDA}" />
   <portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
   <portlet:param name="emitirFormularioGuiaDam" value="emitirFormularioGuiaDam" />
</liferay-portlet:renderURL>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {

		$("input:radio[name=opcaoDAM]").on("change", function() {
			if ($(this).val() != "consultarRequerimentosParcelamentoPorNumero") {
				$("#numProtocoloRequerimento").val("");
			}
		});

		$("#numProtocoloRequerimento").on('keydown', function(e) {
			var keyCode = e.keyCode || e.which, pattern = /\d/, keys = [ 46, 8, 9, 37, 39, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105 ];

			if (!pattern.test(String.fromCharCode(keyCode)) && $.inArray(keyCode, keys) === -1) {
				return false;
			}
		});

		$("#numProtocoloRequerimento").on('click', function(e) {
			$('input:radio[name=opcaoDAM][value=consultarRequerimentosParcelamentoPorNumero]').click();
			$(this).select();
		});
	});

	function acionarLink() {
		if ($("input[name='opcaoDAM']:checked").val() == "consultarRequerimentosParcelamentoPorNumero")
			if ($("#numProtocoloRequerimento").val() == "") {
				alert("Preencha o nº do protocolo, para consulta.");
				$("#numProtocoloRequerimento").focus();
				return false;
			}

		return true;
	}

	function acionarCancelarLink(elem) {
		$("#numProtocoloRequerimentoCancelar").val(elem.id.substring(8));
		return true;
	}

	function acionarDamLink(elem) {
		var query = "&<portlet:namespace/>numGuiaPagamento=" + elem.id;
		$('#' + elem.id).click(window.open($('#linkDamEmitir' + elem.id).attr("href") + query, '_blank'));
		return false;
	}
</script>

<div id="menuConsulaRequerimentoParcelamentoDam">
   <form action="${menuConsulaRequerimentoParcelamentoDamURL}" method="post">
      <liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
      <liferay-ui:error key="webServiceError" message="mensagem.webservice.indisponivel" />
      <input type="hidden" name="numExecucaoFiscal" id="numExecucaoFiscal" /> <input type="hidden" name="numProtocoloRequerimentoCancelar" id="numProtocoloRequerimentoCancelar" />
      <h1>Acompanhar Requerimento de Parcelamento</h1>
      <br />
      <table style="background-color: #f5f5f5; width: 75%">
         <tr>
            <td style="padding-top: 5px; padding-left: 15px" width="30%">
            
               <label class="checkbox"> 
                     <c:if test="${empty opcaoDAM || opcaoDAM == 'consultarRequerimentoParcelamentoPorCPF' || opcaoDAM == 'consultarRequerimentosParcelamentoDam'}">
                        <input type="radio" name="opcaoDAM" value="consultarRequerimentoParcelamentoPorCPF" checked style="vertical-align: top;" />
                     </c:if> 
                     <c:if test="${opcaoDAM == 'consultarRequerimentosParcelamentoPorNumero'}">
                        <input type="radio" name="opcaoDAM" value="consultarRequerimentoParcelamentoPorCPF" style="vertical-align: top;" />
                     </c:if> 
                     <span>Listar todos os requerimentos</span>
               </label> 
               
               <label class="checkbox"> 
                     <c:if test="${opcaoDAM == 'consultarRequerimentosParcelamentoPorNumero'}">
                        <input type="radio" name="opcaoDAM" value="consultarRequerimentosParcelamentoPorNumero" checked style="vertical-align: top;" />
                     </c:if> 
                     <c:if test="${empty opcaoDAM || opcaoDAM == 'consultarRequerimentoParcelamentoPorCPF' || opcaoDAM == 'consultarRequerimentosParcelamentoDam'}">
                        <input type="radio" name="opcaoDAM" value="consultarRequerimentosParcelamentoPorNumero" style="vertical-align: top;" />
                     </c:if> 
                     <span>Consultar pelo nº do protocolo (sem o ano)&nbsp;<input type="text" name="numProtocoloRequerimento" id="numProtocoloRequerimento" value="${numProtocoloRequerimento}" /></span>
               </label>

            </td>
         </tr>
      </table>
      <br>
      <div class="submit-wrapper">
         <table>
            <tr>
               <td><input type="submit" title="Informe uma das opções acima." name="menuConsulaRequerimentoParcelamentoDam" value="Consulta" class="button" id="btnConsultarDam" onclick="return acionarLink()" /></td>
               <td>&nbsp;</td>
               <td><a class="submit" href="<%=actionVoltar%>">Voltar</a></td>
            </tr>
         </table>
      </div>
      <br>
      <br>
      <br>
      <div>
         <c:if test="${not empty mensagemErro}">
            <h1>Erro: ${mensagemErro}</h1>
         </c:if>
         <c:if test="${empty mensagemErro && not empty requerimentos}">
            <c:if test="${not empty numProtocoloRequerimento}">
               <h1>Nº do Requerimento: ${numProtocoloRequerimento}</h1>
            </c:if>
            <c:if test="${empty numProtocoloRequerimento}">
               <h1>Requerente: ${nome}</h1>
            </c:if>
            <table class="fancy-table tabela">
               <thead>
                  <tr>
                     <th colspan="9" class="th">Lista de Requerimentos de Parcelamento</th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <th scope="row" class="tabCel" style="text-align: center;">Nº Protocolo</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Contribuinte</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Abertura</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Previsão de Retorno</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Data da Resposta</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Andamento</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Descrição</th>
                     <th scope="row" class="tabCel" style="text-align: center;">Guia de Pagamento</th>
                     <th scope="row" class="tabCel" style="text-align: center;"></th>
                  </tr>
                  <c:forEach var="req" items="${requerimentos}">
                     <tr>
                        <td class="tabCel" style="text-align: center;">${req.numProtocoloRequerimentoParcelamento}/${req.anoRequerimento}</td>
                        <td class="tabCel" style="text-align: center;">${req.nomeContribuinte}</td>
                        <td class="tabCel" style="text-align: center;">${req.dataSolicitacao}</td>
                        <td class="tabCel" style="text-align: center;">${req.datPrevisaoEntrega}</td>
                        <td class="tabCel" style="text-align: center;">${req.datResposta}</td>
                        <td class="tabCel" style="text-align: center;">${req.situacaoId}</td>
                        <td class="tabCel" style="text-align: center;">${req.txtMotivoRejeicao}</td>
                        <td class="tabCel" style="text-align: center;">
                           <c:if test="${not empty req.requerimentoGuiaPagamentoId}">
                              <div class="submit-wrapper" style="margin: 10px;">
                                 <input type="submit" title="Impressão das guias de pagamento." name="prepararEmissaoGuiaDam" value="Imprimir" class="button, idDamEmitir" id="${req.requerimentoGuiaPagamentoId}" onclick="acionarDamLink(this);return false" /> 
                                 <a id="linkDamEmitir${req.requerimentoGuiaPagamentoId}" href="<%=emitirFormularioGuiaDam%>"></a>
                              </div>
                           </c:if>
                        </td>
                        <td class="tabCel" style="text-align: center;">
                           <c:if test="${empty req.datResposta}">                        
                              <div class="submit-wrapper" style="margin: 10px;">
                                 <input type="submit" title="Cancelar requerimento de parcelamento." name="CancelarDam" value="Cancelar" id="Cancelar${req.numProtocoloRequerimentoParcelamento}" class="button" id="btnCancelarDam" onclick="return acionarCancelarLink(this)" />
                              </div>
                           </c:if>
                        </td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
         </c:if>
      </div>
   </form>
</div>