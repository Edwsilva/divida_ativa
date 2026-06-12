<%@ include file="init.jsp" %>
<portlet:defineObjects />
<html>

<head>
<title>Inscrição Imobiliária ${numInscricao} - Dívida Ativa: Emissão de 2ª Via</title>
</head>

<body onload="window.print();">
	<div class="mensagens">
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
	</div>
	<div class="mensagens">
		<liferay-ui:error key="errorservicemessage"
			message="mensagem.soapfault" />
	</div>
	<c:forEach var="cota" items="${listaCotas}">
		<table style="page-break-inside:avoid;" style="width:850px;">
			<tr>
				<td valign="top">
					<table style="width:350px;">
						<tr>
							<td colspan="4" style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px;">
								<table style="width:100%;">
									<tr>
										<td style="text-align:center;"><img width="30px" height="30px" src="/iptu-consulta/img/LogoRJ.bmp"></td>
										<td style="FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
											<span>PREFEITURA DA CIDADE DO RIO DE JANEIRO</span><br> 
						          				  PROCURADORIA GERAL DO MUNICÍPIO<br>
						          		 	  	  PROCURADORIA DA DÍVIDA ATIVA<br>
						     				<span>DOCUMENTO DE ARRECADAÇÃO DE RECEITAS MUNICIPAIS</span>
						     			</td>
						     		</tr>
						     	</table>
							</td>
						</tr>
						<tr>
							<td colspan=4 style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							&nbsp;Contribuinte: ${guiaPagamento.nomeRequerente}
							<BR>
							<div>&nbsp;ATENÇÃO! NÃO efetuar o pagamento dos nossos DARMs no Banco Bradesco.</div>
							<BR>
							</td>
						</tr>
						<tr>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							CÓD RECEITA<br>${guiaPagamento.codReceita}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							GUIA<br>${guiaPagamento.numeroGuia}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							INSC.IMOB.<br>${numInscricao}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							VENCIMENTO<br>${cota.dataVencimento}
							</td>
						</tr>
						<tr>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							COMPETÊNCIA<br>${cota.numero}/${guiaPagamento.qtdeParcelas}-2
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							SITUAÇÃO<br>${guiaPagamento.faseCobranca}
							</td>
							<td colspan="2" style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							VALOR<br>${cota.valorPrincipal}
							</td>
						</tr>
						<tr>
							<td colspan="2" style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							JUROS<br>${cota.valorJuros}
							</td>
							<td colspan="2" style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							VALOR A PAGAR<Br>${cota.valorTotal}
							</td>
						</tr>
						<tr>
							<td colspan="4" style="border-style: solid; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-top-width: 1px; text-align:center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
								NÃO RECEBER APÓS VENCIMENTO<BR>
						       	AUTENTICAÇÃO MECÂNICA(PARA USO DO BANCO)
							</td>
						</tr>
					</table>
				</td>
				
				<td valign="top">
					<table style="width:500px;">
						<tr>
							<td colspan="4" style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 0px;border-bottom-width: 0px;">
								<table style="width:100%;">
									<tr>
										<td style="text-align:center;"><img width="30px" height="30px" src="/iptu-consulta/img/LogoRJ.bmp"></td>
										<td style="FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
											<span>PREFEITURA DA CIDADE DO RIO DE JANEIRO</span><br> 
						          				  PROCURADORIA GERAL DO MUNICÍPIO<br>
						          		  	  	  PROCURADORIA DA DÍVIDA ATIVA<br>
						     				<span>DOCUMENTO DE ARRECADAÇÃO DE RECEITAS MUNICIPAIS</span>
						     			</td>
						     		</tr>
						     	</table>
							</td>
						</tr>
						<tr>
							<td colspan=4 style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 0px;border-bottom-width: 0px; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							&nbsp;Contribuinte: ${guiaPagamento.nomeRequerente}
							<BR>
							<div>&nbsp;ATENÇÃO! NÃO efetuar o pagamento dos nossos DARMs no Banco Bradesco.</div>
							<BR>
							</td>
						</tr>
						<tr>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 0px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							CÓD RECEITA<br>${guiaPagamento.codReceita}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							INSC.IMOB.<br>${numInscricao}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							CERTIDÃO<br>${numeroCDA}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							VENCIMENTO<br>${cota.dataVencimento}
							</td>
						</tr>
						<tr>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 0px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							COMPETÊNCIA<br>${cota.numero}/${guiaPagamento.qtdeParcelas}-2
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							SITUAÇÃO<br>${guiaPagamento.faseCobranca}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							GUIA<br>${guiaPagamento.numeroGuia}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 0px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							COTA<br>${cota.numero}
							</td>
						</tr>
						<tr>
							<td colspan="2" style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 0px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							VALOR<br>${cota.valorPrincipal}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							JUROS<br>${cota.valorJuros}
							</td>
							<td style="border-style: solid; border-right-width: 1px; border-top-width: 1px; border-left-width: 1px;border-bottom-width: 0px; text-align: center; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt">
							VALOR A PAGAR<Br>${cota.valorTotal}
							</td>
						</tr>
						<tr>
							<td colspan="4" style="border-style: solid; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;border-top-width:1px; FONT-STYLE: normal; font-family: Arial, Helvetica, sans-serif; FONT-SIZE: 8pt;">
								<br>
									<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${cota.linhaDigitavel}</span>
									<p>${cota.codigoDeBarras}</p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<br>
				</td>
			</tr>
			
			<tr>
				<td style="border-style: dotted; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 3px; border-left-width: 0px;"	colspan=2>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<br>
				</td>
			</tr>
		</table>
	</c:forEach>
</body>
</html>