<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="origem" value="${origem}" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="action" value="informativo-divida-ativa.jsp" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="emitir2aViaDamURL">
	<portlet:param name="origem" value="tb_consulta_2a_via_guia_dam.jsp" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="action" value="emitir2aViaDam" />
	<portlet:param name="numInscricao" value="${numInscricao}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
</liferay-portlet:renderURL>

<script type="text/javascript" charset="utf-8">

$(document).ready(function(){
	$('.numInscricao').mask('9999999-9');
	
	$('.numCDA').mask('99/999.999/9999');

	$('.numExecucaoFiscalAntiga').mask('9999.999.999999-9');
	$('.numExecucaoFiscalNova').mask('9999999-99.9999.9.99.9999');
	
    $('#numInscricao').focusout(function () {
        var element = $(this);
       	element.unmask();
       	if (element.val().replace(/\D/g,'') > '') {
       		var numero = "00000000" + element.val().replace(/\D/g, '');
			element.val(numero.substring(numero.length-8, numero.length));
        }
        element.mask('9999999-9');
    }).trigger('focusout');   

    $('#numCDA').focusout(function () {
        var element = $(this);
       	//element.unmask();
       	//if (element.val().replace(/\D/g,'') > '') {
       	//	var numero = "00000000" + element.val().replace(/\D/g, '');
		//	element.val(numero.substring(numero.length-8, numero.length));
        //}
        element.mask('99/999.999/9999');
    }).trigger('focusout');   

    $('#numExecucaoFiscalNova').focusout(function () {
        var element = $(this);
       	element.unmask();
       	if (element.val().replace(/\D/g,'') > '') {
       		var numero = "00000000000000000000" + element.val().replace(/\D/g, '');
			element.val(numero.substring(numero.length-20, numero.length));
        }
        element.mask('9999999-99.9999.9.99.9999');
    }).trigger('focusout');   
});

function acionarLink() {
	if($("#numCDA").val().replace(/^\s+|\s+$/g,"") =="" && 
	   $("#numInscricao").val().replace(/^\s+|\s+$/g,"") == "") 
		if ($("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==1 && $("#numExecucaoFiscalAntiga").val().replace(/^\s+|\s+$/g,"") == "" ||
			$("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==0 && $("#numExecucaoFiscalNova").val().replace(/^\s+|\s+$/g,"") == "")
	{ 
    	alert("Preencha um dos campos para consulta."); 
    	$("#numInscricao").focus();
        return false;
    }

	if($("#numCDA").val().replace(/^\s+|\s+$/g,"")                  > "" &&
	   $("#numInscricao").val().replace(/^\s+|\s+$/g,"") > "")
	{ 
	   	alert("Preencha apenas um dos campos para consulta."); 
	   	$("#numInscricao").focus();
	    return false;
	}

	if(
	   ($("#numCDA").val().replace(/^\s+|\s+$/g,"")                  > "" ||
	   $("#numInscricao").val().replace(/^\s+|\s+$/g,"") > "") &&
	   (
	    ($("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==1 && $("#numExecucaoFiscalAntiga").val().replace(/^\s+|\s+$/g,"") > "") ||
	  	($("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==0 && $("#numExecucaoFiscalNova").val().replace(/^\s+|\s+$/g,"") > "")
	   )
	  )
	{ 
    	alert("Preencha apenas um dos campos para consulta."); 
    	$("#numInscricao").focus();
        return false;
    }
	
	if (($("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==1 && $("#numExecucaoFiscalAntiga").val().replace(/^\s+|\s+$/g,"") > "") ||
	   ($("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==0 && $("#numExecucaoFiscalNova").val().replace(/^\s+|\s+$/g,"") > ""))
 		if ($("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val()==1){
 			$("#numExecucaoFiscal").val($("#numExecucaoFiscalAntiga").val());
			$("#numExecucaoFiscalNova").val("");
 		}
		else {
 			$("#numExecucaoFiscal").val($("#numExecucaoFiscalNova").val());
			$("#numExecucaoFiscalAntiga").val("");
		}
	else
	{
		$("#numExecucaoFiscalNova").val("");
		$("#numExecucaoFiscalAntiga").val("");	
	}
    
	return true;    
}

</script>

<div id="consulta2aViaGuiaDam">

	<form action="${emitir2aViaDamURL}" method="post">	
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />
		<input type="hidden" name="numExecucaoFiscal" id="numExecucaoFiscal"/>
		<h1>
			<liferay-ui:message key="mensagem.dam.consulta.emissao.2avia" />
		</h1>
		
		<br />
		
		<h4>Selecione uma das informações para consulta</h4>
		<table style="background-color: #f5f5f5; width:75%">
			<tr>
				<td style="padding-top: 5px; padding-left: 15px" width="30%">
					<select id="filtroConsulta" name="filtroConsulta" onchange="selecionarFiltroParaConsulta();">
						<option value="0" selected>Pesquisar por</option>
						<option value="1">Nº da Inscrição Imobililária</option>
						<option value="2">Nº da Certidão de Dívida Ativa</option>
						<option value="3">Nº da Execução Fiscal</option>
					</select>
				</td>
				<td style="padding-top: 5px;" >
					<div id="numInscricao_id" style="display: none">
						<label class="checkbox"><input type="text" name="numInscricao" id="numInscricao"/></label>
					</div>

					<div id="numCDA_id" style="display: none">
						<label class="checkbox"><input type="text" name="numCDA" id="numCDA"/></label>
					</div>

					<div id="tipoNumExecucaoFiscal_id" style="display: none">
						<label class="checkbox">
							<input type="radio"	id="tipoNumExecucaoFiscal" name="tipoNumExecucaoFiscal" value="1" style="vertical-align: top;" onchange="alterarNumExecucaoFiscalAntigaOuNova();"/>Antigo
							<input type="radio"	id="tipoNumExecucaoFiscal" name="tipoNumExecucaoFiscal" value="0" style="vertical-align: top;" onchange="alterarNumExecucaoFiscalAntigaOuNova();" checked="true"/>Novo
						</label>
					</div>
					<div id="numExecucaoFiscalAntiga_id" style="display: none">
						<label class="checkbox"><input type="text" name="numExecucaoFiscalAntiga" id="numExecucaoFiscalAntiga" class="numExecucaoFiscalAntiga"/></label>
					</div>
					<div id="numExecucaoFiscalNova_id" style="display:none">
						<label class="checkbox"><input type="text" name="numExecucaoFiscalNova" id="numExecucaoFiscalNova" class="numExecucaoFiscalNova"/></label>
					</div>
				</td>
			</tr>
		</table>

		<br>
		
		<div class="submit-wrapper">
			<table>
				<tr>
					<td>
						<input type="submit"
		                       title="Informe uma das informações acima."
							   name="consultarDam"
							   value="Consulta"
							   class="button" id="btnConsultarDam"
							   onclick="return acionarLink()"/>
					</td>
					<td>&nbsp;</td>
					<td>
						<a class="submit" href="<%=actionVoltar%>">Voltar</a>
					</td>
					<td>
						<div id="textoExplicativoExecucaoFiscal" style="display: none">
							<label class="checkbox">Execuções Ficais a partir de 2010, informar o número do CNJ; anteriores a 2010, antigo número TJRJ.</label>
						</div>
					</td>					
				</tr>
			</table>
		</div>
	</form>	
</div>