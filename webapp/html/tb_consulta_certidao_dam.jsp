<%@ include file="/html/init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="voltar" value="voltar" />
	<portlet:param name="numInscricao" value="${numInscricao}" />
</liferay-portlet:renderURL>

<div class="mensagens">
	<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
</div>
<div class="mensagens">
	<liferay-ui:error key="errorservicemessage"	message="mensagem.soapfault" />
</div>

<div id="consultaCertidaoDam" class="container-fluid">
    <div align="center">
    	<h4>Consultar Requerimentos</h4>
    </div>
	<br>

	<c:if test="${certidao.erro != null}">
		<h1>${certidao.erro}</h1>
			<table>
				<tr>
					<td colspan="2">
						<aui:form>
							<fieldset class="submit-wrapper">
								<a href="<%=actionVoltar%>"><aui:button value="Voltar"/></a>
							</fieldset>
						</aui:form>
					</td>
				</tr>
			</table>
	</c:if>

	<c:if test="${certidao.erro == null}">
	<table>
		<tr>
			<td style="text-align: right;"><label class="checkbox">Andamento:</label></td>
        	<td><label class="checkbox">${certidao.andamento}</label></td>
        </tr>
        <tr>
        	<td style="text-align: right;"><label class="checkbox">Situação Fiscal:</label></td>
        	<td><label class="checkbox">${certidao.situacaoFiscal}</label></td>
        </tr>
        <tr>
        	<td style="text-align: right;"><label class="checkbox">Data da solicitação:</label></td>
        	<td><label class="checkbox">${certidao.datSolicitacao}</label></td>
        </tr>
        <tr>
        	<td style="text-align: right;"><label class="checkbox">Previsão entrega:</label></td>
        	<td><label class="checkbox">${certidao.datPrevisaoEntrega}</label></td>
        </tr>
        <tr>      
        	<td style="text-align: right;"><label class="checkbox">Data da Emissão:</label></td>
        	<td><label class="checkbox">${certidao.datEmissao}</label></td>
        </tr>
        <tr>
        	<td style="text-align: right;"><label class="checkbox">Data da entrega:</label></td>
        	<td><label class="checkbox">${certidao.datEntrega}</label></td>
       </tr>
       <tr>    
        	<td style="text-align: right;"><label class="checkbox">Tipo Pessoa:</label></td>
        	<td><label class="checkbox">${certidao.tipoPessoa}</label></td>
	   </tr>
	   <tr>
       		<td style="text-align: right;"><label class="checkbox">Contribuinte:</label></td>
        	<td><label class="checkbox">${certidao.nomeContribuinte}</label></td>
        </tr>
		<c:if test="${certidao.indTipoPessoa == '1'}">
        <tr>
        	<td style="text-align: right;"><label class="checkbox">CPF:</label></td>
        	<td><label class="checkbox">${certidao.numCPFContribuinte}</label></td>
        </tr>
        </c:if>
		<c:if test="${certidao.indTipoPessoa == '2'}">
        <tr>
        	<td style="text-align: right;"><label class="checkbox">CNPJ:</label></td>
        	<td><label class="checkbox">${certidao.numCNPJContribuinte}</label></td>
		</tr>
		</c:if>
		<tr>
			<td style="text-align: right;"><label class="checkbox">Observação:</label></td>
        	<td><label class="checkbox">${certidao.txtObservacaoComplementar}</label></td>
     	</tr>
	</table>
	</c:if>	
	</div>
	<table>
		<tr>
			<td colspan="2">
				<aui:form>
					<fieldset class="submit-wrapper">
						<a href="<%=actionVoltar%>"><aui:button value="Voltar"/></a>
					</fieldset>
				</aui:form>
			</td>
		</tr>
	</table>
	<span class="imprimir" style="text-align: right;float: right;">
		<a href="javascript:printDivCertidaoDam();">
			<img src="/carioca-digital-theme/images/common/print.png">&nbsp;Imprimir
		</a>
	</span>
 </div>