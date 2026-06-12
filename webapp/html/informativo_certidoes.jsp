<%@ include file="init.jsp"%>

<portlet:defineObjects />

<liferay-portlet:renderURL var="actionVoltar">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="voltar" value="voltar" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="requerimentoCertidaoDamURL">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="action" value="requerimentoCertidaoDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultaCertidaoDamURL">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="action" value="consultaCertidaoDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="imprimeCertidaoDamURL">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="action" value="imprimeCertidaoDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="confirmaAutenticidadeCertidaoDamURL">
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="action" value="confirmaAutenticidadeCertidaoDam" />
</liferay-portlet:renderURL>

<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />

<div id="certidoes">
    <div>
        <div>
            <h4>Informações para o contribuinte:</h4>
            <ul>
                <li>
                    <p align='Justify'>
                        A Certidão de Situação Fiscal gerada pela Procuradoria da Dívida Ativa abrange a existência de débitos, tributários ou não inscritos em dívida ativa do Município do Rio de Janeiro.
                        A situação fiscal do(s) contribuinte(s) quanto a créditos não inscritos em dívida ativa deve ser certificada pelos órgãos responsáveis pelas respectivas apurações.
                    </p>
                </li>
                <li>
                    <p align='Justify'>
                        As solicitações de regularização e retificação da situação fiscal do contribuinte serão recebidas na Rua Sete de Setembro, nº 58-A, mediante a apresentação da documentação
                        comprobatória que justifique a elaboração de nova certidão.
                    </p>
                </li>
                <li>
                    <p align='Justify'>
                        As solicitações de Certidão de Pagamento de ITBI serão recebidas na Rua Sete de Setembro, nº 58-A, mediante a apresentação dos documentos relacionados no modelo de requerimento que pode ser
                        obtido clicando <a href="http://www.rio.rj.gov.br/dlstatic/10112/2123351/DLFE-232641.pdf/Requerimentodecertidaodividaativa.pdf" target="_blank"><font style='color: blue; text-decoration: underline;'>aqui</font></a>.
                    </p>
                </li>
                <li><p align='Justify'>A emissão da 2ª via das certidões negativas poderá ser feita pela Internet.</li></p>
                <li>
                    <p align='Justify'>
                        O prazo para disponibilização da Certidão de Situação Fiscal será de 8 (oito) dias úteis a contar do dia seguinte ao da solicitação.
                        O andamento do pedido poderá ser acompanhado pela Internet.
                    </p>
                </li>
                <li>
                    <p align='Justify'>Para receber informações referentes a emissão de certidão, continuidade e confirmação de pagamento, baixe o app Zap Carioca(*) e cadastre-se no Carioca Digital.</p>
                    <p>(*) Aplicativo disponível para sistemas Android e iPhone.</p>
                </li>
                <li>
                    <p align='Justify'>Eventuais dúvidas poderão ser esclarecidas mediante comparecimento do contribuinte na Rua Sete de Setembro nº 58-A.</p>
                </li>
            </ul>
        </div>
    </div>
    <div>
			<div class="submit-wrapper">
				<table>
					<tr>
						<td>
							<form action="${requerimentoCertidaoDamURL}" method="post">
								<input type="submit" id="btnRequerimentoCertidaoDam" name="requerimentoCertidaoDam" value="Requerimento" />
							</form>
						</td>
						<td>&nbsp;</td>
						<td>
							<form action="${consultaCertidaoDamURL}" method="post">
								<input type="submit" id="btnConsultaCertidaoDam" name="ConsultaCertidaoDam" value="Consulta" />
							</form>
						</td>
						<td>&nbsp;</td>
						<td>
							<form action="${imprimeCertidaoDamURL}" method="post">
								<input type="submit" id="btnImprimeCertidaoDam" name="imprimeCertidaoDam" value="Imprime" />
							</form>
						</td>
						<td>&nbsp;</td>
						<td>
							<form action="${confirmaAutenticidadeCertidaoDamURL}" method="post">
								<input type="submit" id="btnConfirmaAutenticidadeCertidaoDam" name="confirmaAutenticidadeCertidaoDam" value="Confirma Autenticidade" />
							</form>
						</td>
						<td>&nbsp;</td>
						<td>
							<form action="${actionVoltar}" method="post">
								<input type="submit" name="voltar" value="Voltar" />
							</form>
						</td>
					</tr>
				</table>
		</div>
	</div>    
</div>