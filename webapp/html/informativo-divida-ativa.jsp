<%@ include file="init.jsp" %>

<portlet:defineObjects />

<liferay-portlet:renderURL var="menuDAMURL">
	<portlet:param name="action" value="menuDAM" />
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />	
	<portlet:param name="numInscricao" value="${numInscricao}" />
	<portlet:param name="endereco" value="${endereco}" />
	<portlet:param name="opcaoDAM" value="${opcaoDAM}" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultarAvulsaDamURL">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="parcelamento" value="N" />	
	<portlet:param name="action" value="consultarAvulsaDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultarParcelamentoDamURL">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="parcelamento" value="S" />
	<portlet:param name="action" value="consultarParcelamentoDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultarRequerimentosParcelamentoDamURL">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="parcelamento" value="S" />	
	<portlet:param name="action" value="consultarRequerimentosParcelamentoDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="consultar2aViaGuiaDamURL">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="action" value="consultar2aViaGuiaDam" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="faqDividaAtivaURL">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="action" value="faqDividaAtiva" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="faqConciliaURL">
	<portlet:param name="origem" value="informativo-divida-ativa.jsp" />
	<portlet:param name="action" value="faqConcilia" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL var="listarInstrucoesRequerimentoParcelamentoDamURL" windowState="exclusive">
	<liferay-portlet:param name="pagina" value="/html/instrucoes_requerimento_parcelamento_dam.jsp"/>
	<liferay-portlet:param name="action" value="listarInstrucoesRequerimentoParcelamentoDam"/>
</liferay-portlet:renderURL>

<style type="text/css">
 .versao{
	text-align: right !important;
    font-size: 3px !important;
    color: lightgrey !important;
    padding-top: 0px !important;
    margin: 0px !important;
}

</style>
<div class="subhome-content" id="iptu-home">
	<h1>Dívida Ativa: entenda como funciona</h1>
	<div class="boxed-content" id="iptu-home-box-casa">
		<img alt="" src="/carioca-digital-theme/images/custom/casa-grande.png" />
		<p>
			Acesse o <a href="https://daminternet.rio.rj.gov.br/" target="_blank">DAM - SISTEMA DE D&Iacute;VIDA ATIVA MUNICIPAL</a> para maiores informações sobre débitos de taxas municipais e certidões de situação fiscal, ou dirija-se à Procuradoria da Dívida Ativa ou a um de nossos Postos de Atendimento.</p>
	</div>	
	<p>
		Quando o Município não recebe a comprovação do pagamento de determinado tributo ou multa administrativa, a dívida permanece registrada nos arquivos do órgão lançador, em geral, a Secretaria Municipal de Fazenda. Transcorrido o prazo para pagamento no órgão de origem, o cadastro dos devedores é encaminhado à Procuradoria para que a dívida seja cobrada. É aí que esse débito passa a estar inscrito em dívida ativa (débitos relativos a IPTU, taxas municipais, ISS, ITBI e multas). A PGM dispõe de uma equipe dedicada à cobrança desses débitos, a Procuradoria da Dívida Ativa (PG/PDA). Em primeiro lugar, a PDA cobra amigavelmente a dívida, mediante o envio de cartas aos contribuintes. As cartas informam a existência do débito e fornecem os meios e/ou instruções para o seu pagamento.
	</p>
	<p>
		Para ter acesso aos serviços relacionados à dívida ativa imobiliária, <strong>cadastre seus imóveis, na seção "Meus Imóveis" presente na lateral esquerda desta tela.</strong>
	</p> 
    <!--
	<form action="${consultarAvulsaDamURL}" method="post">
		Pra emitir guia à vista, liquidar débitos ou tirar segunda via, clique <a href="#" onclick="consultarAvulsaDam()"><font style="color: blue;font-weight:bold;">aqui</font></a>.
		<input type="submit" id="btnConsultaAvulsaDam" name="consultarAvulsaDam" style="visibility:hidden;"/>
	</form>
	<form action="${consultarParcelamentoDamURL}" method="post">
		Para <font style="text-decoration:underline;font-weight: bold">parcelar seus débitos</font>, clique <a href="#" onclick="consultarParcelamentoDam()"><font style="color: blue;font-weight:bold;">aqui</font></a>.
		<input type="submit" id="btnConsultaParcelamentoDam" name="consultarParcelamentoDam" style="visibility:hidden;"/>
	</form>
	-->
	<form action="${menuDAMURL}" method="post">		
		<label class="checkbox"><input type="radio" name="opcaoDAM" value="consultarAvulsaDam" onchange="MandaPraDaminternetSeForAdiantamento();" checked style="vertical-align: top;" />
			<span>Emitir guia à vista ou liquidar débitos</span>
		</label>
		<label class="checkbox"><input type="radio" name="opcaoDAM" value="consultarRegularizacaoDam" onchange="MandaPraDaminternetSeForAdiantamento();" style="vertical-align: top;" />
			<span>Emitir guias - parcela em atraso (regularização)</span>
		</label>		
		<label class="checkbox"><input type="radio" name="opcaoDAM" value="consultar2aViaGuiaDam" onchange="MandaPraDaminternetSeForAdiantamento();" style="vertical-align: top;" />
			<span>Emitir segunda via de guia de parcelamento</span>
		</label>

		<label class="checkbox"><input type="radio" name="opcaoDAM" value="consultarAdiantamentoDam" onchange="MandaPraDaminternetSeForAdiantamento();" style="vertical-align: top;" />
			<span>Emitir adiantamento de cotas de parcelamento</span>
		</label>

		<div class="submit-wrapper">
			<label	class="checkbox"> <input type="radio" name="opcaoDAM" value="consultarParcelamentoDam" onchange="MandaPraDaminternetSeForAdiantamento();" style="vertical-align: top;" />
				<span>Parcelar débitos
					<input type="submit" class="submit" onClick="exibirColorbox('${listarInstrucoesRequerimentoParcelamentoDamURL}'); return false;" value="Veja os documentos necessários para realizar o parcelamento"/>
				</span>
			</label>
		</div>

		<label	class="checkbox"> <input type="radio" name="opcaoDAM" value="consultarRequerimentosParcelamentoDam" onchange="MandaPraDaminternetSeForAdiantamento();" style="vertical-align: top;" />
			<span>Acompanhar requerimento de parcelamento</span>
		</label>
		
		<div id="OKAdiantamento" style="display: none">
			&nbsp;<a href="https://daminternet.rio.rj.gov.br/GuiaPagamento/Adiantamento"><input type="button" value="OK" /></a>
		</div>
		<div id="OK" style="display:block">
			<div class="submit-wrapper">
				&nbsp;<input type="submit" id="btnMenuDam" name="menuDAM" value="OK" />
			</div>
		</div>
	</form>
	    <p>
		Clique <a href="https://daminternet.rio.rj.gov.br/FAQ/DividaAtiva" target="_blank"><font style="color: blue;font-weight:bold;">aqui</font></a> para acessar perguntas frequentes relacionadas à dívida ativa.
		</p> 
</div>

<p class="versao">4.4.7</p>

<script>
	function faqDividaAtiva()
	{
		$("#btnFaqDividaAtiva").click();
	}
	function faqConcilia()
	{
		$("#btnFaqConcilia").click();
	}
	function consultarAvulsaDam()
	{
		$("#btnConsultaAvulsaDam").click();
	}	
	function consultarParcelamentoDam()
	{
		$("#btnConsultaParcelamentoDam").click();
	}
</script>