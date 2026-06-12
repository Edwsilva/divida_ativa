<%@ include file="/html/init.jsp"%>

<div class="mensagens">
	<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
</div>
<div class="mensagens">
	<liferay-ui:error key="errorservicemessage"	message="mensagem.soapfault" />
</div>

<c:if test="${certidao.erro != null}">
	<h1>${certidao.erro}</h1>
</c:if>

<c:if test="${certidao.erro == null}">

<div id="enviarrequerimentocertidaodam" class="container-fluid">
  	<table>
    	<tr>
        	<td>
				<img src="/carioca-digital-theme/images/custom/logo-prefeitura.png" width="210" class="tomador-logotipo"/>
            </td>
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>
            	<h6>Procuradoria Geral do Município
            	   <br>
                   Procuradoria da Dívida ativa
                </h6>
            </td>
        </tr>
    </table>
    <div align="center">
    	<h4>Protocolo de Requerimento de Certidão de Situação Fiscal</h4>
    </div>
	<br>
	<table>
		<tr>
			<td><label class="checkbox">Nº protocolo:</label></td>
        	<td><label class="checkbox">${certidao.numProtocolo}</label></td>
        </tr>
        <tr>
        	<td><label class="checkbox">Andamento:</label></td>
        	<td><label class="checkbox">${certidao.andamento}</label></td>
        </tr>
        <tr>
        	<td><label class="checkbox">Data da solicitação:</label></td>
        	<td><label class="checkbox">${certidao.datSolicitacao}</label></td>
        </tr>
        <tr>
        	<td><label class="checkbox">Previsão entrega:</label></td>
        	<td><label class="checkbox">${certidao.datPrevisaoEntrega}</label></td>
        </tr>
        <tr>      
        	<td><label class="checkbox">Data da Emissão:</label></td>
        	<td><label class="checkbox">${certidao.datEmissao}</label></td>
        </tr>
        <tr>
        	<td><label class="checkbox">Data da entrega:</label></td>
        	<td><label class="checkbox">${certidao.datEntrega}</label></td>
       </tr>
       <tr>    
        	<td><label class="checkbox">Tipo Pessoa:</label></td>
        	<td><label class="checkbox">${certidao.tipoPessoa}</label></td>
	   </tr>
	   <tr>
       		<td><label class="checkbox">Contribuinte:</label></td>
        	<td><label class="checkbox">${certidao.nomeContribuinte}</label></td>
        </tr>
        <tr>
        	<td><label class="checkbox">CPF:</label></td>
        	<td><label class="checkbox">${certidao.numCPFContribuinte}</label></td>
        </tr>
        <tr>
        	<td><label class="checkbox">CNPJ:</label></td>
        	<td><label class="checkbox">${certidao.numCNPJContribuinte}</label></td>
		</tr>
		<tr>
			<td><label class="checkbox">Requerente:</label></td>
        	<td><label class="checkbox">${certidao.nomRequerente}</label></td>
     	</tr>
     </table>
		<span class="imprimir" style="text-align: right;float: right;">
			<a href="javascript:printDivRequerimentoCertidaoDam();">
				<img src="/carioca-digital-theme/images/common/print.png">&nbsp;Imprimir
			</a>
		</span>
 </div>
 </c:if>