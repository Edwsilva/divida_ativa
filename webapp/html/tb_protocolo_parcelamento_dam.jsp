<%@ include file="/html/init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="action" value="voltarOrigem" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="emitirComprovanteEntregaRequerimentoParcelamentoDam"
windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="emitirComprovanteEntregaRequerimentoParcelamentoDam" value="emitirComprovanteEntregaRequerimentoParcelamentoDam" />
</liferay-portlet:renderURL>
<body  onload="acionarDamLink2();">
<div class="mensagens">
	<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
</div>
<div class="mensagens">
	<liferay-ui:error key="errorservicemessage"	message="mensagem.soapfault" />
</div>

<div id="protocoloRequerimentoParcelamentoDam" class="container-fluid">
 <form  method="post">
 	<input type="hidden" name="nomeArquivoPdf" id="nomeArquivoPdf" value="${nomeArquivoPdf}" />
    <div align="center">
    	<h4>Protocolo de Requerimento de Parcelamento</h4>
    </div>
	<br>
	<table style="widht:50%;text-align: center;">
		<tr>
			<td>
				<p><label class="checkbox">Requerimento de parcelamento nº ${numProtocoloRequerimentoParcelamento}/${anoRequerimento} efetivado com sucesso.</label></p>
				<p><label class="checkbox">Sua requisição será analisada e a PGM entrará em contato com V.S.ª até o dia ${datPrevisaoEntrega}.</label></p>
				<p><label class="checkbox">A situação de seus requerimentos também poderá ser consultada neste Portal, acessando <font style="text-decoration: underline;">Dívida Ativa</font> e selecionando a opção <font style="text-decoration: underline;">Consultar Andamento de Requisição de Parcelamento</font>.</label></p>
			</td>
        </tr>
   </table>
   <br>
     <table>
     	<tr>
     		<td>
				<div class="submit-wrapper" style="margin: 10px;">
					<input type="submit"
							title="Impressão do protocolo de rquerimento de parcelamento."
							name="prepararEmissaoGuiaDam" value="Clique aqui para emitir o comprovante de entrega"
							class="button, idDamEmitir" id="idDamEmitir"
							onclick="acionarDamLink('<%=emitirComprovanteEntregaRequerimentoParcelamentoDam%>');return false" /> <a
							id="linkDamEmitir" href="<%=emitirComprovanteEntregaRequerimentoParcelamentoDam%>"></a>
				</div>
			</td>
			<td>
				<div class="submit-wrapper">
					<a class="submit" id="idVoltar" href="<%=actionVoltar%>">Voltar à Tela Inicial</a>
				</div>
			</td>
		</tr>
	</table>
 	<br>
  </form>
</div>
</body>
<script type="text/javascript" charset="utf-8">
function acionarDamLink2(){
	var vals = $("#nomeArquivoPdf").val();
	var query = "&<portlet:namespace/>nomeArquivoPdf=" + vals;
	window.open($('#linkDamEmitir').attr("href") + query, '_blank');
}
function acionarDamLink(){
	var vals = $("#nomeArquivoPdf").val();
	var query = "&<portlet:namespace/>nomeArquivoPdf=" + vals;
	$('#idDamEmitir').click(window.open($('#linkDamEmitir').attr("href") + query, '_blank'));
	return false;
}
</script>