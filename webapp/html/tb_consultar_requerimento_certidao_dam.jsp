<%@ include file="/html/init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="voltar" value="voltar" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultarCertidaoDamURL">
	<portlet:param name="action" value="consultarCertidaoDam" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="numProtocolo" value="${numProtocolo}" />
</liferay-portlet:renderURL>

<script type="text/javascript" charset="utf-8">

function acionarLink() {
	if($("#numProtocolo").val().replace(/^\s+|\s+$/g,"") ==""){ 
    	alert("Preencha o Número do Protocolo."); 
    	$("#numProtocolo").focus();
        return false;
    }

	return true;    
}

</script>

<div id="consultarRequerimentoCertidaoDam">
	<form action="${consultarCertidaoDamURL}" method="post">	
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />

		<h1>
			<liferay-ui:message key="mensagem.dam.consulta.requerimento.emissao" />
		</h1>
		
		<br />
		
		<h4>Dados para Consulta</h4>
		<table style="background-color: #f5f5f5; width:100%">
			<tr>
				<td>
					<label class="checkbox">Número do Protocolo</label>
				</td>
				<td style="padding-top: 15px">
					<label class="checkbox"><input type="text" size="14" maxlength="14" name="numProtocolo" id="numProtocolo"/></label>
				</td>
			</tr>
        </table>
        
		<div class="submit-wrapper">
			<table>
				<tr>
					<td>
						<input type="submit"
		                       title="Informe o número do protocolo."
							   name="consultarDam"
							   value="Consulta"
							   class="button" id="btnConsultarDam"
							   onclick="return acionarLink()"/>
					</td>
					<td>&nbsp;</td>
					<td>
						<a class="submit" href="<%=actionVoltar%>">Voltar</a>
					</td>
				</tr>
			</table>
		</div>        
	</form>        
</div>