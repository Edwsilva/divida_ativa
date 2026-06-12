<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="voltar" value="voltar" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="enviarRequerimentoCertidaoDamURL" windowState="exclusive">
	<portlet:param name="action" value="enviarRequerimentoCertidaoDam" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="tipoDoc" value="${tipoDoc}" />
	<portlet:param name="nomeContribuinte" value="${nomeContribuinte}" />
	<portlet:param name="dataNascimentoContribuinte" value="${dataNascimentoContribuinte}" />
	<portlet:param name="antigasDenominacoes" value="${antigasDenominacoes}" />
	<portlet:param name="registradoJUCERJA" value="${registradoJUCERJA}" />
	<portlet:param name="registradoRCPJ" value="${registradoRCPJ}" />
	<portlet:param name="cpf" value="${cpf}" />
	<portlet:param name="cnpj" value="${cnpj}" />
	<portlet:param name="inscricaoMunicipal" value="${inscricaoMunicipal}" />
	<portlet:param name="cep" value="${cep}" />										
	<portlet:param name="logradouro" value="${logradouro}" />
	<portlet:param name="numero" value="${numero}" />
	<portlet:param name="complemento" value="${complemento}" />
	<portlet:param name="bairro" value="${bairro}" />
	<portlet:param name="cidade" value="${cidade}" />
	<portlet:param name="uf" value="${uf}" />
	<portlet:param name="nomeRequerente" value="${nomeRequerente}" />
	<portlet:param name="cpfRequerente" value="${cpfRequerente}" />
	<portlet:param name="dataNascimentoRequerente" value="${dataNascimentoRequerente}" />										
	<portlet:param name="telefone" value="${telefone}" />
	<portlet:param name="email" value="${email}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="listarInstrucoesRequerimentoCertidaoDamURL" windowState="exclusive">
	<liferay-portlet:param name="pagina" value="/html/instrucoes_requerimento_certidao_dam.jsp"/>
	<liferay-portlet:param name="action" value="listarInstrucoesRequerimentoCertidaoDam"/>
</liferay-portlet:renderURL>

<portlet:resourceURL var="ajaxResourceUrlCpfCnpj" id="idUrlCpf" />
<portlet:resourceURL var="ajaxResourceUrlCep" id="idUrlCep"/>

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
</style>

<script type="text/javascript" charset="utf-8">

$(document).ready(function(){
	$('.cpf').mask('999.999.999-99');
	$('.cnpj').mask('99.999.999/9999-99');
	$('#cpfRequerente').mask('999.999.999-99');
	$("#dataNascimento").mask("99/99/9999");
    $("#dataNascimentoRequerente").mask("99/99/9999");    
    $("#tbInscricaoMunicipal").mask("9.999.999-9");
    $("#tbCEP").mask("99999-999");

    $('#tbTelefone').focusout(function () {
        var element = $(this);
        element.unmask();
        var phone = element.val().replace(/\D/g, '');
        if (phone.length > 10) {
            element.mask("(99) 99999-999?9");
        } else {
            element.mask("(99) 9999-9999?9");
        }
    }).trigger('focusout');   
    
    $("#nome").blur(function () {
        ValidaCPFReceitaFederal();
    });
    $("#nomeMae").blur(function () {
        ValidaCPFReceitaFederal();
    });
    $("#dataNascimento").blur(function () {
        ValidaCPFReceitaFederal();
    });
    $("#cpf").blur(function () {
        ValidaCPFReceitaFederal();
    });
    $("#cnpj").blur(function () {
        ValidaCPFReceitaFederal();
    });
    $("#nomeRequerente").blur(function () {
        ValidaCPFRequerenteReceitaFederal();
    });
    $("#nomeMaeRequerente").blur(function () {
        ValidaCPFRequerenteReceitaFederal();
    });
    $("#dataNascimentoRequerente").blur(function () {
        ValidaCPFRequerenteReceitaFederal();
    });
    $("#cpfRequerente").blur(function () {
        ValidaCPFRequerenteReceitaFederal();
    });
    
    $("#tbCEP").blur(function () {

        if ($("#tbCEP").val() == '')
            return null;
        PesquisaCEP();
    });    
});

function acionarLink() {
	if($("#nome").val().replace(/^\s+|\s+$/g,"") ==""){ 
    	alert("Preenchimento do Nome do Contribuinte Obrigatório."); 
    	$("#nome").focus();
        return false;
    }
	if ($("input[type=radio][name='tipoDoc']:checked").val()==1) {
		if($("#nomeMae").val().replace(/^\s+|\s+$/g,"")==""){ 
    		alert("Preenchimento do Nome da Mãe do Contribuinte Obrigatório."); 
    		$("#nomeMae").focus();
    		return false;
    	}
    	if($("#dataNascimento").val().replace(/^\s+|\s+$/g,"")==""){ 
    		alert("Preenchimento da Data de Nascimento do Contribuinte Obrigatória."); 
    		$("#dataNascimento").focus();
    		return false;
    	}
    	if ($("#cpf").val().replace(/^\s+|\s+$/g,"")==""){ 
        	alert("Preenchimento do CPF do Contribuinte Obrigatório."); 
        	$("#cpf").focus();
        	return false;
        }
	}
	else {
		if ($("#registradoJUCERJA").is(":checked") == false &&
			$("#registradoRCPJ").is(":checked") == false){ 
        	alert("Selecione algum Registro."); 
        	$("#registradoJUCERJA").focus();
        	return false;
        }
		if ($("#cnpj").val().replace(/^\s+|\s+$/g,"")==""){
    		alert("Preenchimento do CNPJ do Contribuinte Obrigatório");
    		$("#cnpj").focus();
    		return false;
    	}
    }
    if ($("#tbCEP").val().replace(/^\s+|\s+$/g,"")==""){
    	alert("Preenchimento do CEP Obrigatório.");
    	$("#tbCEP").focus();
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

    if($("#nomeRequerente").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento do Nome do Requerente Obrigatório."); 
    	$("#nomeRequerente").focus();
    	return false;
    }
    if($("#nomeMaeRequerente").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento do Nome da Mãe do Requerente Obrigatório."); 
    	$("#nomeMaeRequerente").focus();
    	return false;
    }
    if($("#dataNascimentoRequerente").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento da Data de Nascimento do Requerente Obrigatória."); 
    	$("#dataNascimentoRequerente").focus();
    	return false;
    }
    if ($("#cpfRequerente").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento do CPF do Requerente Obrigatório."); 
    	$("#cpfRequerente").focus();
    	return false;
    }
    if ($("#tbTelefone").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento do Telefone do Requerente Obrigatório."); 
    	$("#tbTelefone").focus();
    	return false;
    }
    if ($("#email").val().replace(/^\s+|\s+$/g,"")==""){ 
    	alert("Preenchimento do Email do Requerente Obrigatório."); 
    	$("#email").focus();
    	return false;
    }
    if ($("#email").val().indexOf("@") == -1){ 
    	alert("Preenchimento do Email do Requerente Inválido."); 
    	$("#email").focus();
    	return false;
    }
    if ($("#email").val().lastIndexOf("@") == $("#email").val().replace(/^\s+|\s+$/g,"").length-1){ 
    	alert("Preenchimento do Email do Requerente Inválido."); 
    	$("#email").focus();
    	return false;
    } 
    
    var query = "&tipoDoc=" + $("input[type=radio][name='tipoDoc']:checked").val();
    query     = query + "&nomeContribuinte=" + $("#nome").val().replace(/ /g,"%20");
    query     = query + "&dataNascimentoContribuinte=" + $("#dataNascimento").val().replace(/ /g,"%20"); 
    query     = query + "&antigasDenominacoes=" + $("#antigasDenominacoes").val().replace(/ /g,"%20");
	query 	  = query + "&registradoJUCERJA="  + $("#registradoJUCERJA").is(":checked"); 
	query 	  = query + "&registradoRCPJ="  + $("#registradoRCPJ").is(":checked"); 
	query 	  = query + "&cpf="  + $("#cpf").val().replace(/ /g,"%20"); 
	query 	  = query + "&cnpj="  + $("#cnpj").val().replace(/ /g,"%20");
	query 	  = query + "&inscricaoMunicipal="  + $("#tbInscricaoMunicipal").val().replace(/ /g,"%20"); 
	query 	  = query + "&cep="  + $("#tbCEP").val().replace(/ /g,"%20");										
	query 	  = query + "&logradouro="  + $("#logradouro").val().replace(/ /g,"%20"); 
	query 	  = query + "&numero="  + $("#numero").val().replace(/ /g,"%20"); 
	query 	  = query + "&complemento="  + $("#complemento").val().replace(/ /g,"%20"); 
	query 	  = query + "&bairro="  + $("#bairro").val().replace(/ /g,"%20"); 
	query 	  = query + "&cidade="  + $("#cidade").val().replace(/ /g,"%20"); 
	query 	  = query + "&uf="  + $("#uf option:selected").text(); 
	query 	  = query + "&nomeRequerente="  + $("#nomeRequerente").val().replace(/ /g,"%20"); 
	query 	  = query + "&cpfRequerente="  + $("#cpfRequerente").val().replace(/ /g,"%20"); 
	query 	  = query + "&dataNascimentoRequerente="  + $("#dataNascimentoRequerente").val().replace(/ /g,"%20"); 										
	query 	  = query + "&telefone="  + $("#tbTelefone").val().replace(/ /g,"%20"); 
	query 	  = query + "&email="  + $("#email").val().replace(/ /g,"%20");
    
    exibirColorbox('${enviarRequerimentoCertidaoDamURL}' + query);
    
	return false;    
}

// URLs Assíncronas
var urlAjaxCpfCnpj = '<%=ajaxResourceUrlCpfCnpj%>';
var urlAjaxCep     = '<%=ajaxResourceUrlCep%>';
</script>

<div id="requerimentoCertidaoDam">

	
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
		<liferay-ui:error key="webServiceError"	message="mensagem.webservice.indisponivel" />

		<table style="width: 100%">
			<tr>
				<td>
					<h1>
						<liferay-ui:message key="mensagem.dam.titulo.requerimento.certidao" />
					</h1>
				</td>
				<td style="text-align: right">
					<aui:form>
						<fieldset class="submit-wrapper">
							<aui:button onClick="exibirColorbox('${listarInstrucoesRequerimentoCertidaoDamURL}')" value="Passo-a-Passo"/>
						</fieldset>
					</aui:form>	
				</td>
			</tr>
		</table>
		
		<br />
		
		<h4>Dados do Contribuinte</h4>
		<table style="background-color: #f5f5f5; width:100%">
			<tr>
				<td>
					<label class="checkbox">Tipo Pessoa:*</label>
				</td>
				<td>
					<label class="checkbox">
						<input type="radio"	id="tipoDoc" name="tipoDoc" value="1" style="vertical-align: top;" onchange="alterarCpfOuCnpj();" checked/>Física
						<input type="radio"	id="tipoDoc" name="tipoDoc" value="2" style="vertical-align: top;" onchange="alterarCpfOuCnpj();"/>Jurídica
					</label>
        		</td>
        		<td style="padding-top: 15px">
					<label class="checkbox">Nome completo do contribuinte:*</label>
				</td>
				<td style="padding-top: 15px">
					<label class="checkbox"><input type="text" size="100" maxlength="100" name="nomeContribuinte" id="nome" style="text-transform:uppercase;"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Nome completo da mãe<sup id="asteristicoNomeMae" style="display:inline">*</sup></label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="100" maxlength="100" name="nomeMaeContribuinte" id="nomeMae" style="text-transform:uppercase;"/></label>
				</td>
        		<td>
					<label class="checkbox">Data de nascimento:<sup id="asteristicoDataNascimento" style="display:inline">*</sup></label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="10" maxlength="10" name="dataNascimentoContribuinte" id="dataNascimento"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Antigas denominações:</label>
				</td>
				<td>
					<label class="checkbox"><textarea rows="4" maxlength="100" name="antigasDenominacoes" id="antigasDenominacoes" style="text-transform:uppercase;"></textarea></label>
				</td>
				<td>
					<label class="checkbox">Registros<sup id="asteristicoRegistros" style="display:none">*</sup></label>
				</td>
				<td>
					<label class="checkbox">
						<input type="checkbox"	id="registradoJUCERJA" name="registradoJUCERJA" value="registradoJUCERJA" style="vertical-align: top;"/>Junta Comercial (JUCERJA):
					</label>
					<label class="checkbox">
						<input type="checkbox"	id="registradoRCPJ" name="registradoRCPJ" value="registradoRCPJ" style="vertical-align: top;"/>Registro Civil de Pessoas Jurídicas (RCPJ):
					</label>
        		</td>
        	</tr>
			<tr>
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
						<label class="checkbox"><input type="text" name="cpf" id="cpf" class="cpf" /></label>
					</div>
					<div id="cnpj_id1" style="display: none">
						<label class="checkbox"><input type="text" name="cnpj" id="cnpj" class="cnpj" /></label>
					</div>
				</td>
				<td>
					<label class="checkbox">Inscrição municipal:</label>
				</td>
					<td>
						<label class="checkbox"><input type="text" name="inscricaoMunicipal" id="tbInscricaoMunicipal"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">CEP:*</label><img src="/iptu-consulta/img/loading.gif" class="loading3" />
				</td>
				<td>
					<label class="checkbox"><input type="text" name="cep" id="tbCEP"/></label>
				</td>
        		<td>
					<label class="checkbox">Logradouro:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="100" maxlength="100" name="logradouro" id="logradouro" style="text-transform:uppercase;"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Número:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="10" maxlength="10" name="numero" id="numero" style="text-transform:uppercase;"/></label>
				</td>
        		<td>
					<label class="checkbox">Complemento:</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="20" maxlength="20" name="complemento" id="complemento" style="text-transform:uppercase;"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Bairro:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="50" maxlength="50" name="bairro" id="bairro" style="text-transform:uppercase;"/></label>
				</td>
        		<td>
					<label class="checkbox">Cidade:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="50" maxlength="50" name="cidade" id="cidade" style="text-transform:uppercase;"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">UF:*</label>
				</td>
				<td>
					<label class="checkbox">
						<select id="uf" name="uf">
                        	<option value=""></option>
                            <option value="1">AC</option>
                            <option value="2">AL</option>
                            <option value="3">AP</option>
                            <option value="4">AM</option>
                            <option value="5">BA</option>
                            <option value="6">CE</option>
                            <option value="7">DF</option>
                            <option value="8">ES</option>
                            <option value="9">GO</option>
                            <option value="10">MA</option>
                            <option value="11">MT</option>
                            <option value="12">MS</option>
                            <option value="13">MG</option>
                            <option value="14">PA</option>
                            <option value="15">PB</option>
                            <option value="16">PR</option>
                            <option value="17">PE</option>
                            <option value="18">PI</option>
                            <option value="19">RJ</option>
                            <option value="20">RN</option>
                            <option value="21">RS</option>
                            <option value="22">RO</option>
                            <option value="23">RR</option>
                            <option value="24">SC</option>
                            <option value="25">SP</option>
                            <option value="26">SE</option>
                            <option value="27">TO</option>
                     	</select>						
					</label>
				</td>
        		<td></td>
				<td></td>
			</tr>
		</table>
		<br>
		<h4>Dados do Requerente</h4>
		<table style="background-color: #f5f5f5; width:100%">
			<tr>
        		<td>
					<label class="checkbox">Nome completo:*</label>
				</td>
				<td style="padding-top: 15px">
					<label class="checkbox"><input type="text" size="100" maxlength="100" name="nomeRequerente" id="nomeRequerente" style="text-transform:uppercase;"/></label>
				</td>
				<td>
					<label class="checkbox">CPF:*</label><img src="/iptu-consulta/img/loading.gif" class="loading2" />
				</td>
				<td style="padding-top: 15px">
					<label class="checkbox"><input type="text" name="cpfRequerente" id="cpfRequerente"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Nome completo da mãe:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="100" maxlength="100" name="nomeMaeRequerente" id="nomeMaeRequerente" style="text-transform:uppercase;"/></label>
				</td>
        		<td>
					<label class="checkbox">Data de nascimento:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" size="10" maxlength="10" name="dataNascimentoRequerente" id="dataNascimentoRequerente"/></label>
				</td>
			</tr>
        	<tr>
        		<td>
					<label class="checkbox">Telefone:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="text" name="telefone" id="tbTelefone"/></label>
				</td>
        		<td>
					<label class="checkbox">Email:*</label>
				</td>
				<td>
					<label class="checkbox"><input type="email" size="100" maxlength="100" name="email" id="email" style="text-transform:lowercase;"/></label>
				</td>
			</tr>
		</table>
	<br>
	<table>
		<tr>
			<td>
				<aui:form>
					<fieldset class="submit-wrapper">
						<aui:button onClick="acionarLink('<%=enviarRequerimentoCertidaoDamURL%>');" value="Emitir"/>
					</fieldset>
				</aui:form>
			</td>
			<td>&nbsp;</td>
			<td>
				<aui:form>
					<fieldset class="submit-wrapper">
						<a href="<%=actionVoltar%>"><aui:button value="Voltar"/></a>
					</fieldset>
				</aui:form>
			</td>
		</tr>
	</table>
</div>