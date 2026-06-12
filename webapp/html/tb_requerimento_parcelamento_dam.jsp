<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="tipoPessoa" value="${tipoPessoa}" />
	<portlet:param name="nomeContribuinte" value="${nomeContribuinte}" />	
	<portlet:param name="numCDA" value="${numCDA}" />
	<portlet:param name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
	<portlet:param name="endereco" value="${endereco}" />	
	<portlet:param name="origem" value="${origem}" />	
	<portlet:param name="parcelamento" value="${parcelamento}"/>
	<portlet:param name="parcelar" value="S"/>	
	<portlet:param name="dataVencimento" value="${dataVencimento}" />
	<portlet:param name="qtdtParcelasFinalTabela" value="${qtdtParcelasFinalTabela}"/>	
	<portlet:param name="radioSelecionado" value="${radioSelecionado}"/>	
	<portlet:param name="cdas" value="${cdas}"/>
	<portlet:param name="action" value="voltarRequerimentoParcelamentoDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="listarInstrucoesRequerimentoParcelamentoDamURL" windowState="exclusive">
	<liferay-portlet:param name="pagina" value="/html/instrucoes_requerimento_parcelamento_dam.jsp"/>
	<liferay-portlet:param name="action" value="listarInstrucoesRequerimentoParcelamentoDam"/>
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="reautenticarURL" windowState="exclusive">
	<liferay-portlet:param name="pagina" value="/html/reautenticar.jsp"/>
	<liferay-portlet:param name="action" value="reautenticar"/>
</liferay-portlet:renderURL>

<liferay-portlet:actionURL var="enviarRequerimentoParcelamentoDamURL" name="enviarRequerimentoParcelamentoDam" />

<liferay-portlet:resourceURL var="cepAjax" id="consultarCep"/>

<style type="text/css">
.loading {
	float: left;
	font-size: 10px;
	margin: 3px 15px;
	display: none;
}
.loading2 {
	float: left;
	font-size: 10px;
	margin: 3px 15px;
	display: none;
}
.loading3 {
	float: left;
	font-size: 10px;
	margin: 3px 15px;
	display: none;	
}
.loading4 {
	float: left;
	font-size: 10px;
	margin: 3px 15px;
	display: "Enviando Requisição...";	
}
</style>

<script type="text/javascript" charset="utf-8">

$(document).ready(function(){
	$(".loading4").hide();
	
	$("#cep").mask("99999-999");
	$('.cpf').mask('999.999.999-99');
	$('.cnpj').mask('99.999.999/9999-99');
	
	$('#uploadFields').css('display', 'inline-block');
	
	var cdas = $('#cdas').val().split(',');
	var cdasFormosas =  "";
	
	for(i = 0; i < cdas.length; i++)
	 {
	   cdasFormosas =  cdasFormosas +  cdas[i] + ", ";
	   if (((i+1) % 4 == 0) && (i!= cdas.lenght))
		   cdasFormosas = cdasFormosas + "<br>"; 
	 }
	
	cdasFormosas  = cdasFormosas.slice(0, cdasFormosas.lastIndexOf(", "));
	
	$('#cdasFormosas').append('<label class="checkbox">' + cdasFormosas + '.</label>');	
	
	alterarCpfOuCnpj();
	
    $('#telefone').focusout(function () {
        var element = $(this);
        element.unmask();
        var phone = element.val().replace(/\D/g, '');
        if (phone.length > 10) {
            element.mask("(99) 99999-999?9");
        } else {
            element.mask("(99) 9999-9999?9");
        }
    }).trigger('focusout'); 
    
    $('#telefoneRequerente').focusout(function () {
        var element = $(this);
        element.unmask();
        var phone = element.val().replace(/\D/g, '');
        if (phone.length > 10) {
            element.mask("(99) 99999-999?9");
        } else {
            element.mask("(99) 9999-9999?9");
        }
    }).trigger('focusout'); 
});

function acionarLink() {
if ($("#tipoVinculo option:selected").val()==""){
	alert("Selecione o Tipo de Vínculo do Requerente.");
	$("#tipoVinculo").focus();
	return false;
}
if ($("#telefoneRequerente").val().replace(/^\s+|\s+$/g,"")==""){ 
	alert("Preenchimento do Telefone do Requerente Obrigatório."); 
	$("#telefoneRequerente").focus();
	return false;
}
if ($("#emailRequerente").val().replace(/^\s+|\s+$/g,"")==""){ 
	alert("Preenchimento do Email do Requerente Obrigatório."); 
	$("#email").focus();
	return false;
}
if ($("#emailRequerente").val().indexOf("@") == -1){ 
	alert("Preenchimento do Email do Requerente Inválido."); 
	$("#email").focus();
	return false;
}
if ($("#emailRequerente").val().lastIndexOf("@") == $("#emailRequerente").val().replace(/^\s+|\s+$/g,"").length-1){ 
	alert("Preenchimento do Email do Requerente Inválido."); 
	$("#email").focus();
	return false;
} 

if($("#nome").val().replace(/^\s+|\s+$/g,"") ==""){ 
	alert("Preenchimento do Nome de Correspondência Obrigatório."); 
	$("#nome").focus();
    return false;
}

if ($("input[type=radio][name='tipoDoc']:checked").val()==1) {
	if ($("#cpf").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento do CPF de Correspondência Obrigatório."); 
    	$("#cpf").focus();
    	return false;
    }
	if (!validarCPF($("#cpf").val())){
		alert("Nº de CPF de Correspondência Inválido.");
		$("#cpf").focus();
		return false;
		}
}
else {
	if ($("#cnpj").val().replace(/^\s+|\s+$/g,"")==""){
		alert("Preenchimento do CNPJ de Correspondência Obrigatório");
		$("#cnpj").focus();
		return false;
	}
	if (!validarCNPJ($("#cnpj").val())){
		alert("Nº de CNPJ de Correspondência Inválido.");
		$("#cnpj").focus();
		return false;
		}	
}

if ($("#cep").val().replace(/^\s+|\s+$/g,"")==""){
	alert("Preenchimento do CEP Obrigatório.");
	$("#cep").focus();
	return false;
}
if ($("#logradouro").val().replace(/^\s+|\s+$/g,"")==""){
	alert("Preenchimento do Logradouro Obrigatório.");
	$("#logradouro").focus();
	return false;
}
if ($("#numero").val().replace(/^\s+|\s+$/g,"")==""){
	alert("Preenchimento do Nº do Logradouro Obrigatório.");
	$("#numero").focus();
	return false;
}
if ($("#bairro").val().replace(/^\s+|\s+$/g,"")==""){
	alert("Preenchimento do Bairro do Logradouro Obrigatório.");
	$("#bairro").focus();
	return false;
}
if ($("#cidade").val().replace(/^\s+|\s+$/g,"")==""){
	alert("Preenchimento da Cidade do Logradouro Obrigatória.");
	$("#cidade").focus();
	return false;
}
if ($("#uf option:selected").val()==""){
	alert("Selecione a Unidade Federativa do Logradouro.");
	$("#uf").focus();
	return false;
}

if ($("#telefone").val().replace(/^\s+|\s+$/g,"")==""){ 
	alert("Preenchimento do Telefone de Correspondência Obrigatório."); 
	$("#telefone").focus();
	return false;
}

if ($("#email").val().replace(/^\s+|\s+$/g,"")==""){ 
	alert("Preenchimento do Email de Correspondência Obrigatório."); 
	$("#email").focus();
	return false;
}
if ($("#email").val().indexOf("@") == -1){ 
	alert("Preenchimento do Email de Correspondência Inválido."); 
	$("#email").focus();
	return false;
}
if ($("#email").val().lastIndexOf("@") == $("#email").val().replace(/^\s+|\s+$/g,"").length-1){ 
	alert("Preenchimento do Email de Correspondência Inválido."); 
	$("#email").focus();
	return false;
} 
       

if($('#arqIdentidade').val().length == 0){
	alert('O envio da Identidade é obrigatório');
	return false;
}
if(!isValidImgFile($('#arqIdentidade').val())){
	alert('O arquivo da Identidade deve ter um dos seguintes formatos: '+msgExtensoes);
	return false;
}
if($('#arqIdentidade').val().length > 0 && getFileSize('arqIdentidade') > _500KB){
	alert('O arquivo da Identidade deve ser menor que 500 KB');
	return false;
}
if($('#arqCPF').val().length == 0){
	alert('O envio do CPF é obrigatório');
	return false;
}
if(!isValidImgFile($('#arqCPF').val())){
	alert('O arquivo do CPF deve ter um dos seguintes formatos: '+msgExtensoes);
	return false;
}
if($('#arqCPF').val().length > 0 && getFileSize('arqCPF') > _500KB){
	alert('O arquivo do CPF deve ser menor que 500 KB');
	return false;
}

if($('#tipoPessoa').val() == "2" && $("#tipoVinculo option:selected").val()!="5" && $('#arqCNPJ').val().length == 0){
	alert('O envio de CNPJ é obrigatório, para Pessoa Jurídica');
	return false;
}
if($('#arqCNPJ').val().length > 0) {
	if(!isValidImgFile($('#arqCNPJ').val())){
		alert('O arquivo de CNPJ deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqCNPJ').val().length > 0 && getFileSize('arqCNPJ') > _500KB){
		alert('O arquivo de CNPJ deve ser menor que 500 KB');
		return false;
	}
}
if($('#tipoPessoa').val() == "2" && $("#tipoVinculo option:selected").val()!="5" && $('#arqRegistro').val().length == 0){
	alert('O envio de Registro de Empresário Individual, Contrato ou EStatuto é obrigatório, para Pessoa Jurídica');
	return false;
}
if($('#arqRegistro').val().length > 0) {
	if(!isValidImgFile($('#arqRegistro').val())){
		alert('O arquivo de Registro de Empresário Individual, Contrato ou EStatuto deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqRegistro').val().length > 0 && getFileSize('arqRegistro') > _1eMeioMB){
		alert('O arquivo de Registro de Empresário Individual, Contrato ou EStatuto deve ser menor que 1,5 MB');
		return false;
	}
}
if($('#arqAta').val().length > 0) {
	if(!isValidImgFile($('#arqAta').val())){
		alert('O arquivo da Ata deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqAta').val().length > 0 && getFileSize('arqAta') > _1eMeioMB){
		alert('O arquivo da Ata deve ser menor que 1,5 MB');
		return false;
	}
}

if ($("#tipoVinculo option:selected").val()=="4" && $('#arqProcuracao').val().length == 0){
	alert('O envio de Procuração é obrigatório, quando requerente for Procurador');
	return false;
}
if($('#arqProcuracao').val().length > 0) {
	if(!isValidImgFile($('#arqProcuracao').val())){
		alert('O arquivo de Procuração deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqProcuracao').val().length > 0 && getFileSize('arqProcuracao') > _1eMeioMB){
		alert('O arquivo de Procuração deve ser menor que 1,5 MB');
		return false;
	}
}
if ($("#tipoVinculo option:selected").val()=="4" && $('#arqIdentidadeDevedor').val().length == 0){
	alert('O envio de Identidade do Outorgante é obrigatório, quando requerente for Procurador');
	return false;
}
if($('#arqIdentidadeDevedor').val().length > 0) {
	if(!isValidImgFile($('#arqIdentidadeDevedor').val())){
		alert('O arquivo de Identidade do Outorgante deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqIdentidadeDevedor').val().length > 0 && getFileSize('arqIdentidadeDevedor') > _500KB){
		alert('O arquivo de Identidade do Outorgante deve ser menor que 500 KB');
		return false;
	}
}
if ($("#tipoVinculo option:selected").val()=="4" && $('#arqCPFDevedor').val().length == 0){
	alert('O envio de CPF do Outorgante é obrigatório, quando requerente for Procurador');
	return false;
}
if($('#arqCPFDevedor').val().length > 0) {
	if(!isValidImgFile($('#arqCPFDevedor').val())){
		alert('O arquivo de CPF do Outorgante deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqCPFDevedor').val().length > 0 && getFileSize('arqCPFDevedor') > _500KB){
		alert('O arquivo de CPF do Outorgante deve ser menor que 500 KB');
		return false;
	}
}

if ($("#tipoVinculo option:selected").val()=="5" && $('#arqEscritura').val().length == 0){
	alert('Item 9 obrigatório. Em se tratando de débitos de IPTU/TCL, as pessoas, que não sejam o contribuinte do tributo na certidão de dívida ativa (CDA) ou não conste como proprietário do imóvel no cadastro do IPTU, devem dos documentos requeridos no item 9 sem o qual o pedido não poderá ser apreciado. Sendo o contribuinte na CDA ou na inscrição do imóvel, escolha a opção "o próprio contribuinte".');
	return false;
}
if($('#arqEscritura').val().length > 0) {
	if(!isValidImgFile($('#arqEscritura').val())){
		alert('O arquivo de Registro de Imóveis, Compra e Venda ou similar deve ter um dos seguintes formatos: '+msgExtensoes);
		return false;
	}
	if($('#arqEscritura').val().length > 0 && getFileSize('arqEscritura') > _1eMeioMB){
		alert('O arquivo de Registro de Imóveis, Compra e Venda ou similar deve ser menor que 1,5 MB');
		return false;
	}
}	

if($('#arqOutros').val().length > 0) {
		if(!isValidImgFile($('#arqOutros').val())){
			alert('O arquivo de Outros Documentos deve ter um dos seguintes formatos: '+msgExtensoes);
			return false;
		}
		if($('#arqOutros').val().length > 0 && getFileSize('arqOutros') > _1eMeioMB){
			alert('O arquivo de Outros Documentos deve ser menor que 1,5 MB');
			return false;
		}	
}

	exibirColorbox('${reautenticarURL}');
	return false;
}

function retornoSenhaOK(){
	$(".loading4").show();
	exibirColorboxSending('Enviando Requisição...');
	$("#frmRequerimentoParcelamento").submit();
	return true;
}
</script>

<liferay-ui:error key="falha-no-upload" message="mensagem.dam.falhaUpload"/>
<liferay-ui:error key="system-error" message="mensagem.dam.systemError"/>

<form name="frmRequerimentoParcelamento" id="frmRequerimentoParcelamento" action="${enviarRequerimentoParcelamentoDamURL}" enctype="multipart/form-data" method="POST">
<div id="requerimentoCertidaoDam">

	
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />

		<table style="width: 100%">
			<tr>
				<td>
					<h1>
						REQUERIMENTO DE PARCELAMENTO DE DÉBITOS
					</h1>
				</td>
			</tr>
		</table>
		
		<input type="hidden" name="tipoAutenticacao" value="${tipoAutenticacao}" />
		
		<input type="hidden" name="numInscricao" value="${numInscricao}" />
		<input type="hidden" name="numCDA" value="${numCDA}" />
		<input type="hidden" name="numExecucaoFiscal" value="${numExecucaoFiscal}" />
		<input type="hidden" name="tipoPessoa"   id="tipoPessoa" value="${tipoPessoa}"/>
		<input type="hidden" name="parcelamento" value="${parcelamento}"/>
		<input type="hidden" name="parcelar" value="${parcelar}"/>
		
		<input type="hidden" name="nomeCompleto" id="nomeCompleto" value="${nomeCompleto}" />
		<input type="hidden" name="cpfRequerente" id="cpfRequerente" value="${cpfRequerente}" />
		<input type="hidden" name="formaParcelamento" id="formaParcelamento" value="${formaParcelamento}" />
		<input type="hidden" name="valor1aParcela" id="valor1aParcela" value="${valor1aParcela}" />
		<input type="hidden" name="dataVencimento" id="dataVencimento" value="${dataVencimento}" />
		<input type="hidden" name="qtdtParcelasFinalTabela" id="qtdtParcelasFinalTabela" value="${qtdtParcelasFinalTabela}" />
		<input type="hidden" name="radioSelecionado" id="radioSelecionado" value="${radioSelecionado}" />
		<input type="hidden" name="cdas" id="cdas" value="${cdas}" />

	<c:if test="${not empty mensagemErro}">
		<font color="#ff0000"> <b>${mensagemErro}</b></font>
		<br><br><br>
	</c:if>
		<div id="dadosRequerimento">
			<h4>Dados do Requerimento</h4>
			<table style="background-color: #f5f5f5; width:100%">
				<c:if test="${not empty numInscricao}">
					<tr>
        				<td width="20%">
							<label class="checkbox">Inscrição Imobiliária:</label>
						</td>
						<td>
							<label class="checkbox">${numInscricao}.</label>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty numExecucaoFiscal}">
					<tr>
        				<td width="20%">
							<label class="checkbox">Execução Fiscal:</label>
						</td>
						<td>
							<label class="checkbox">${numExecucaoFiscal}.</label>
						</td>
					</tr>
				</c:if>
				<tr>		
					<td style="vertical-align: top">
						<label class="checkbox">Contribuinte:</label>
					</td>
					<td>
						<label class="checkbox">${nomeContribuinte}.</label>
					</td>
				</tr>				
				<tr>		
					<td style="vertical-align: top">
						<label class="checkbox">CDAs:</label>
					</td>
					<td>
						<div id="cdasFormosas"></div>
					</td>
				</tr>
				<tr>
        			<td width="20%">
						<label class="checkbox">Forma de Pagamento:</label>
					</td>
					<td>
						<label class="checkbox">${formaParcelamento} parcelas.</label>
					</td>
				</tr>
				<tr>		
					<td>
						<label class="checkbox">Valor da Primeira Cota:</label>
					</td>
					<td>
						<label class="checkbox">${valor1aParcela} com vencimento em ${dataVencimento}.</label>
					</td>
				</tr>
			</table>
		</div>
		<br>
		
		<h4>Dados do Requerente</h4>
		<table style="background-color: #f5f5f5; width:100%">
			<tr>
        		<td colspan="4">
					<label class="checkbox"><b>${nomeCompleto} - CPF nº ${cpfRequerente}</b></label>
				</td>
			</tr>
			<tr>
        		<td>
					<label class="checkbox">Tipo de Vínculo:*</label>
				</td>
				<td colspan="3">
					<label class="checkbox">
						<select id="tipoVinculo" name="tipoVinculo">
                        	<option value=""></option>
                            <c:if test="${tipoVinculo == '2'}">
                            	<option value="2" selected>O próprio contribuinte</option>
                            </c:if>
                            <c:if test="${tipoVinculo != '2'}">	
                            	<option value="2">O próprio contribuinte</option>
                            </c:if>
                            <c:if test="${tipoVinculo == '1'}">	
                            	<option value="1" selected>Sócio Responsável</option>
                            </c:if>
                            <c:if test="${tipoVinculo != '1'}">	
                            	<option value="1">Sócio Responsável</option>
                     		</c:if>
                           <c:if test="${tipoVinculo == '4'}">	
                            	<option value="4" selected>Procurador</option>
                            </c:if>
                            <c:if test="${tipoVinculo != '4'}">	
                            	<option value="4">Procurador</option>
                            </c:if>
                            <c:if test="${tipoVinculo == '5'}">	
                            	<option value="5" selected>Atual Proprietário/Possuidor</option>
                            </c:if>
                            <c:if test="${tipoVinculo != '5'}">	
                            	<option value="5">Atual Proprietário/Possuidor</option>
                            </c:if>
                     	</select>						
					</label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Telefone:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" name="telefoneRequerente" id="telefoneRequerente" value="${telefoneRequerente}" style="width:200px"/></label>
				</td>
        		<td>
					<label class="checkbox">Correio Eletrônico:*</label>
				</td>				
        		<td>
					<label class="checkbox"><input type="email" size="100" maxlength="100" name="emailRequerente" id="emailRequerente" style="width:400px;text-transform:lowercase;" value="${emailRequerente}"/></label>
				</td>
			</tr>
		</table>
		<br>
				
		<h4>Dados de Correspondência</h4>
		<table style="background-color: #f5f5f5; width:100%">
			<tr>
        		<td>
					<label class="checkbox">Nome Completo:*</label>
				</td>
				<td colspan="3">
					<label class="checkbox"><input type="text" maxlength="100" name="nome" id="nome" value="${nome}" style="width:685px;"/></label>
				</td>
			</tr>
			<tr>
				<td>
					<label class="checkbox">Tipo Pessoa:*</label>
				</td>
				<td>
					<label class="checkbox">
						<c:if test="${empty tipoDoc || tipoDoc == '1'}">
							<input type="radio"	id="tipoDoc" name="tipoDoc" value="1" style="vertical-align: top;" onchange="alterarCpfOuCnpj();" checked/>Física
						</c:if>
						<c:if test="${not empty tipoDoc && tipoDoc != '1'}">
							<input type="radio"	id="tipoDoc" name="tipoDoc" value="1" style="vertical-align: top;" onchange="alterarCpfOuCnpj();"/>Física
						</c:if>
						<c:if test="${tipoDoc == '2'}">	
							<input type="radio"	id="tipoDoc" name="tipoDoc" value="2" style="vertical-align: top;" onchange="alterarCpfOuCnpj();" checked/>Jurídica
						</c:if>
						<c:if test="${tipoDoc != '2'}">	
							<input type="radio"	id="tipoDoc" name="tipoDoc" value="2" style="vertical-align: top;" onchange="alterarCpfOuCnpj();"/>Jurídica
						</c:if>
					</label>
        		</td>
				<td>
					<div id="cpf_id">
						<label class="checkbox">CPF:*</label><img src="/iptu-consulta/img/loading.gif" class="loading" />
					</div>
					<div id="cnpj_id" style="display: none">
						<label class="checkbox">CNPJ:*</label>
					</div>
				</td>
				<td>
					<div id="cpf_id1">
						<label class="checkbox"><input type="text" name="cpf" id="cpf" class="cpf" value="${cpf}" /></label>
					</div>
					<div id="cnpj_id1" style="display: none">
						<label class="checkbox"><input type="text" name="cnpj" id="cnpj" class="cnpj" value="${cnpj}" /></label>
					</div>
				</td>
			</tr>
			<tr>				
        		<td>
					<label class="checkbox">CEP:*</label><img src="/dividaativa-consulta/img/loading.gif" class="loading3" />
				</td>
				<td>
					<label class="checkbox"><input type="text" name="cep" id="cep" value="${cep}" onblur="atualizacep('${cepAjax}',this.value)" style="width:100px"/></label>
				</td>
				<td colspan="2">
					<div id="infoCepNotFound" class="portlet-msg-error" style="display: none;">
						<liferay-ui:message key="O CEP informado é inválido ou não existe" />
					</div>
				</td>
			</tr>
			<tr>
        		<td>
					<label class="checkbox">Logradouro:*</label>
				</td>
				<td colspan="3">
					<label class="checkbox"><input type="text" maxlength="105" name="logradouro" id="logradouro" value="${logradouro}" style="width:685px;"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Número:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="6" maxlength="6" name="numero" id="numero" value="${numero}" style="width:70px;"/></label>
				</td>
        		<td>
					<label class="checkbox">Complemento:</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="85" maxlength="85" name="complemento" id="complemento" value="${complemento}"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Bairro:*</label>
				</td>
				<td colspan="3">
					<label class="checkbox"><input type="text" size="72" maxlength="72" name="bairro" id="bairro" value="${bairro}" style="width:250px;"/></label>
				</td>
			</tr>
			<tr>
        		<td>
					<label class="checkbox">Município:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="72" maxlength="72" name="cidade" id="cidade" value="${cidade}" style="width:250px"/></label>
				</td>
        		<td>
					<label class="checkbox">UF:*</label>
				</td>
				<td>
					<label class="checkbox">
						<select id="uf" name="uf">
                        	<c:if test="${empty uf}">
                        		<option value="" selected></option>
                        	</c:if>
                        	<c:if test="${not empty uf}">
                            	<option value=""></option>
                            </c:if>
                            
                            <c:if test="${uf == 'AC'}">
                            	<option value="AC" selected>AC</option>
                            </c:if>
                            <c:if test="${uf != 'AC'}">
                            	<option value="AC">AC</option>
                            </c:if>
                            
                            <c:if test="${uf == 'AL'}">
                            	<option value="AL" selected>AL</option>
                            </c:if>
                            <c:if test="${uf != 'AL'}">
                            	<option value="AL">AL</option>
                            </c:if>
                            
                            <c:if test="${uf == 'AM'}">
                            	<option value="AM" selected>AM</option>
                            </c:if>
                            <c:if test="${uf != 'AM'}">
                            	<option value="AM">AM</option>
                            </c:if>
                            
                            <c:if test="${uf == 'AP'}">
                            	<option value="AP" selected>AP</option>
                            </c:if>
                            <c:if test="${uf != 'AP'}">
                            	<option value="AP">AP</option>
                            </c:if>
                            
                            <c:if test="${uf == 'BA'}">
                            	<option value="BA" selected>BA</option>
                            </c:if>
                            	<c:if test="${uf != 'BA'}">
                            <option value="BA">BA</option>
                            </c:if>
                            
                            <c:if test="${uf == 'CE'}">
                            	<option value="CE" selected>CE</option>
                            </c:if>
                            <c:if test="${uf != 'CE'}">
                            	<option value="CE">CE</option>
                            </c:if>
                            
                            <c:if test="${uf == 'DF'}">
                            	<option value="DF" selected>DF</option>
                            </c:if>
                            <c:if test="${uf != 'DF'}">
                            	<option value="DF">DF</option>
                            </c:if>
                            
                            <c:if test="${uf == 'ES'}">
                            	<option value="ES" selected>ES</option>
                            </c:if>
                            <c:if test="${uf != 'ES'}">
                            	<option value="ES">ES</option>
                            </c:if>
                            
                            <c:if test="${uf == 'GO'}">
                            	<option value="GO" selected>GO</option>
                            </c:if>
                            <c:if test="${uf != 'GO'}">
                            	<option value="GO">GO</option>
                            </c:if>
                            
                            <c:if test="${uf == 'MA'}">
                            	<option value="MA" selected>MA</option>
                            </c:if>
                            <c:if test="${uf != 'MA'}">
                            	<option value="MA">MA</option>
                            </c:if>
                            
                            <c:if test="${uf == 'MG'}">
                            	<option value="MG" selected>MG</option>
                            </c:if>
                            <c:if test="${uf != 'MG'}">
                            	<option value="MG">MG</option>
                            </c:if>
                            
                            <c:if test="${uf == 'MT'}">
                            	<option value="MT" selected>MT</option>
                            </c:if>
                            <c:if test="${uf != 'MT'}">
                            	<option value="MT">MT</option>
                            </c:if>
                            
                            <c:if test="${uf == 'MS'}">
                            	<option value="MS" selected>MS</option>
                            </c:if>
                            <c:if test="${uf != 'MS'}">
                            	<option value="MS">MS</option>
                            </c:if>
                            
                            <c:if test="${uf == 'PA'}">
                            	<option value="PA" selected>PA</option>
                            </c:if>
                            <c:if test="${uf != 'PA'}">
                            	<option value="PA">PA</option>
                            </c:if>
                            
                            <c:if test="${uf == 'PB'}">
                            	<option value="PB" selected>PB</option>
                            </c:if>
                            <c:if test="${uf != 'PB'}">
                            	<option value="PB">PB</option>
                            </c:if>
                            
                            <c:if test="${uf == 'PE'}">
                            	<option value="PE" selected>PE</option>
                            </c:if>
                            <c:if test="${uf != 'PE'}">
                            	<option value="PE">PE</option>
                            </c:if>
                            
                            <c:if test="${uf == 'PI'}">
                            	<option value="PI" selected>PI</option>
                            </c:if>
                            <c:if test="${uf != 'PI'}">
                            	<option value="PI">PI</option>
                            </c:if>
                            
                            <c:if test="${uf == 'PR'}">
                            	<option value="PR" selected>PR</option>
                            </c:if>
                            <c:if test="${uf != 'PR'}">
                            	<option value="PR">PR</option>
                            </c:if>
                            
                            <c:if test="${uf == 'RJ'}">
                            	<option value="RJ" selected>RJ</option>
                            </c:if>
                            <c:if test="${uf != 'RJ'}">
                            	<option value="RJ">RJ</option>
                            </c:if>
                            
                            <c:if test="${uf == 'RN'}">
                            	<option value="RN" selected>RN</option>
                            </c:if>
                            <c:if test="${uf != 'RN'}">
                            	<option value="RN">RN</option>
                            </c:if>
                            
                            <c:if test="${uf == 'RO'}">
                            	<option value="RO" selected>RO</option>
                            </c:if>
                            <c:if test="${uf != 'RO'}">
                            	<option value="RO">RO</option>
                            </c:if>
                            
                            <c:if test="${uf == 'RR'}">
                            	<option value="RR" selected>RR</option>
                            </c:if>
                            <c:if test="${uf != 'RR'}">
                            	<option value="RR">RR</option>
                            </c:if>
                            
                            <c:if test="${uf == 'RS'}">
                            	<option value="RS" selected>RS</option>
                            </c:if>
                            <c:if test="${uf != 'RS'}">
                            	<option value="RS">RS</option>
                            </c:if>

                            <c:if test="${uf == 'SC'}">
                            	<option value="SC" selected>SC</option>
                            </c:if>
                            <c:if test="${uf != 'SC'}">
                            	<option value="SC">SC</option>
                            </c:if>
                            
                            <c:if test="${uf == 'SE'}">
                            	<option value="SE" selected>SE</option>
                            </c:if>
                            <c:if test="${uf != 'SE'}">
                            	<option value="SE">SE</option>
                            </c:if>
                            
                            <c:if test="${uf == 'SP'}">
                            	<option value="SP" selected>SP</option>
                            </c:if>
                            <c:if test="${uf != 'SP'}">
                            	<option value="SP">SP</option>
                            </c:if>
                            
                            <c:if test="${uf == 'TO'}">
                            	<option value="TO" selected>TO</option>
                            </c:if>
                            <c:if test="${uf != 'TO'}">
                            	<option value="TO">TO</option>
                            </c:if>
                     	</select>						
					</label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Telefone:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" name="telefone" id="telefone" value="${telefone}" style="width:200px"/></label>
				</td>
        		<td>
					<label class="checkbox">Correio Eletrônico:*</label>
				</td>				
        		<td>
					<label class="checkbox"><input type="email" size="100" maxlength="100" name="email" id="email" value="${email}" style="width:300px;text-transform:lowercase;" value="${email}"/></label>
				</td>
			</tr>
		</table>
		<br>
			<span class="submit-wrapper">
					<input type="submit" class="submit" onClick="exibirColorbox('${listarInstrucoesRequerimentoParcelamentoDamURL}'); return false;" value="Veja os documentos necessários para realizar o parcelamento"/>
			</span>
		<br>
		<div class="troca-real-infrator-upload">
			<div id="uploadFields" class="troca-real-infrator-upload-fields">
				<div class="row-fluid">
					<div class="span10">
						<span class="troca-real-infrator-upload-texto1">
							<font style="text-align:center; font-weight: bold;margin-left: 250px"><b>FAÇA O UPLOAD DOS DOCUMENTOS NECESSÁRIOS</b></font>
						</span>
					</div>
				</div>
						
				<font style="color: gray;margin-left:20px;font-weight: bold;">
					Os arquivos devem estar em formato PDF ou JPG.<br>
				</font>
				<font style="color: gray;margin-left:20px;font-weight: bold;">
				   	Arquivos de Identidade, CPF e CNPJ não podem ultrapassar 500 KB e os demais não devem ultrapassar 1,5 MB.
				</font>

				<hr style="color: #A3BF28;border-width:3px;">
				<font style="text-decoration: underline;text-decoration: bold;">OBRIGATÓRIOS - REQUERENTE (O próprio contribuinte, Sócio Responsável, Procurador ou Atual Proprietário/Possuidor)</font><br><br>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							1. Identidade do requerente com foto *
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqIdentidade" id="arqIdentidade" value="${arqIdentidade}" />
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							2. CPF do requerente *
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqCPF" id="arqCPF" value="${arqCPF}" />
					</div>
				</div>
				
				<hr style="color: #A3BF28;border-width:3px;">
				<font style="text-decoration: underline;text-decoration: bold;">OBRIGATÓRIOS, CASO DEVEDOR SEJA PESSOA JURÍDICA</font><br><br>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							3. CNPJ da empresa
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqCNPJ" id="arqCNPJ" value="${arqCNPJ}" />
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							4. Registro de empresário individual, contrato ou estatuto social (última alteração consolidada)
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqRegistro" id="arqRegistro" value="${arqRegistro}" />
					</div>
				</div>

				<hr style="color: #A3BF28;border-width:3px;">
				<font style="text-decoration: underline;text-decoration: bold;">OBRIGATÓRIOS, CASO DEVEDOR SEJA SOCIEDADE ANÔNIMA</font><br><br>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							5. Ata de eleição da atual diretoria
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqAta" id="arqAta" value="${arqAta}" />
					</div>
				</div>
				
				<hr style="color: #A3BF28;border-width:3px;">
				<font style="text-decoration: underline;text-decoration: bold;">OBRIGATÓRIOS, CASO PROCURADOR</font><br><br>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							6. Procuração com firma reconhecida
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqProcuracao" id="arqProcuracao" value="${arqProcuracao}" />
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							 7. Identidade do Outorgante com foto
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqIdentidadeDevedor" id="arqIdentidadeDevedor" value="${arqIdentidadeDevedor}" />
					</div>
				</div>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							8. CPF do Outorgante
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqCPFDevedor" id="arqCPFDevedor" value="${arqCPFDevedor}" />
					</div>
				</div>
			
				<hr style="color: #A3BF28;border-width:3px;">
				<font style="text-decoration: underline;text-decoration: bold;">OBRIGATÓRIO, QUANDO ATUAL PROPRIETÁRIO DO IMÓVEL É DIFERENTE DO CONSTANTE NA CDA OU INSCRIÇÃO IMOBILIÁRIA</font><br><br>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							9. Registro de Imóveis, Compra e Venda ou promessa, Sentença Judicial, Termo de Inventariança, Auto de Arrematação ou Petição Inicial de Usucapião, ou documento comprovando a posse com ânimo de dono
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqEscritura" id="arqEscritura" value="${arqEscritura}" />
					</div>
				</div>
				
				<hr style="color: #A3BF28;border-width:3px;">
				<font style="text-decoration: underline;text-decoration: bold;">OUTROS DOCUMENTOS</font><br><br>
				<div class="row-fluid">
					<div class="span5">
						<span class="troca-real-infrator-upload-texto3">
							10. Outros documentos que o contribuinte achar necessários, para adquirir algum benefício a que tem direito
						</span>
					</div>
					<div class="span7">
						<input type="file" name="arqOutros" id="arqOutros" value="${arqOutros}" />
					</div>
				</div>				
			</div>
		</div>
</div>

 	<table>
		<tr>
			<td>
				<input type="submit" name="enviarRequerimentoParcelamentoDamURL" style="float:right;" value="Enviar Requerimento" onclick="return acionarLink()">
			</td>
			<td>&nbsp;<img src="/dividaativa-consulta/img/loading.gif" class="loading4" /></td>
			<td>
				<form>
					<div class="submit-wrapper">
						<a class="submit" id="idVoltar" href="<%=actionVoltar%>">Voltar</a>
					</div>
				</form>
			</td>
		</tr>
	</table>
</form>