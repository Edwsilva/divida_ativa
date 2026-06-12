<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:resourceURL var="senhaAjax" id="validarSenha"/>

<style type="text/css">
.loading3 {
	float: left;
	font-size: 10px;
	margin: 3px 15px;
	display: none;	
}
</style>

<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	$("#dadosRequerimentoSenha").append(parent.$("#dadosRequerimento").html());
	
	 if ($("#tipoAutenticacao").val()!="senha"){
		 $("#mostraSenha").hide();
		 $("#senha").css({
				display : "none"
			});
	 }
	
	  $(window).keydown(function(event){
	    if(event.keyCode == 13) {
	      event.preventDefault();
	      return false;
	    }
	  });
	});
	
function validarSenha(){
	if(!$("#checar").is(":checked")){
		alert("Declaração não selecionada.");
		return false;
	}
	
	if ($("#tipoAutenticacao").val()!="senha"){
		$.fn.colorbox.close();
		parent.retornoSenhaOK();
		return false;
	}
	
	if ($("#senha").val() == ""){
		alert("Por favor, informe a senha.");
		return false;
	}
		
	validaSenha("${senhaAjax}", $("#senha").val());	
}
</script>

<form name="frmReautenticar" enctype="multipart/form-data" method="POST" onsubmit="return false;">
<div id="reautenticar">

	
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />
		
		<div id="dadosRequerimentoSenha"></div>
		<br>
		<table style="width: 100%">
		</table>
		
		<br><input type="hidden" name="tipoAutenticacao" id="tipoAutenticacao" value="${tipoAutenticacao}" />
		
		<table style="background-color: #f5f5f5; width:100%">
			<tr>
				<td colspan="2">
					<label class="checkbox"><input type="checkbox"	name="checar" id="checar" style="margin-left: 3px;" />&nbsp;<b>Declaro, sob as penas da lei, que os documentos anexados e informações apresentadas são autênticos e conferem com os originais.</b></label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label class="checkbox"><b>${nomeCompleto} - CPF nº ${cpf}</b></label>
				</td>
			</tr>
			<tr>
       			<td>
					<div id="mostraSenha">
						<label class="checkbox">Informe novamente sua senha:*</label><img src="/dividaativa-consulta/img/loading.gif" class="loading3" />
					</div>
				</td>
       			<td>
       				<label class="checkbox">
						<input size="30" name="senha" id="senha" type="password" />
					</label>
				</td>
			</tr>
		</table>
		<br>
		<table style="width:50%; text-align:center; margin-left: 100pt;">
			<tr>
				<td>
					<span class="submit-wrapper">
						<input type="button" class="submit" name="validarSenhaURL" onclick="validarSenha()" style="float:left;" value="Assinar">
						&nbsp;
						<input type="button" class="submit" name="Fechar" onclick="$.fn.colorbox.close();" style="float:right;" value="Fechar">
					</span>
				</td>
			</tr>
		</table>
</div>
</form>