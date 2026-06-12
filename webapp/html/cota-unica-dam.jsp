<%@ include file="init.jsp"%>
<portlet:defineObjects />
<html>
<head>
<title>Inscrição Imobiliária ${numInscricao} - Dívida Ativa: Pagamento à Vista</title>
</head>

<body>
	<div class="mensagens">
		<liferay-ui:error key="cfcInvocation" message="mensagem.soapfault" />
	</div>
	<div class="mensagens">
		<liferay-ui:error key="errorservicemessage"
			message="mensagem.soapfault" />
	</div>

	<c:if test="${erro == true}">
		<h1>${mensagemErro}</h1>
	</c:if>
	<c:if test="${erro == false}">
		<c:if test="${fault != true}">
			<div
				style="FONT-STYLE: normal; MARGIN: 2px 5px 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-SIZE: 12px; TEXT-ALIGN: left">
				<table>
					<tr>
						<td>
							<table>
								<tr>
									<td style="valign: top">
										<table>
											<tr>
												<td
													style="border-top: #001 1px solid; border-right: #001 1px solid; border-left: #001 1px solid; border-bottom: #001 1px solid">
													<table style="width: 450px">
														<tr>
															<td><img src="/iptu-consulta/img/LogoRJ.bmp"></td>
															<td><span>PREFEITURA DA CIDADE DO RIO DE
																	JANEIRO</span><br> PROCURADORIA GERAL DO MUNICÍPIO<br>
																PROCURADORIA DA DÍVIDA ATIVA<br> <span>DOCUMENTO
																	DE ARRECADAÇÃO DE RECEITAS<br> MUNICIPAIS
															</span>
																<div style="FONT-STYLE: normal; MARGIN: 2px 5px 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-SIZE: 10px; TEXT-ALIGN: right">
																	<b>${tituloGuia}</b>
																</div></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-left: #001 1px solid; border-bottom: #001 1px solid">
													10. NOME / RAZÃO SOCIAL<br>
													${guiaPagamento.nomeRequerente}
													<div style="TEXT-ALIGN: right">
														<br> <span>INS: ${numInscricao}</span>
													</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-left: #001 1px solid; border-bottom: #001 1px solid">
													11. INFORMAÇÕES COMPLEMENTARES<br>
													<table>
														<c:if test="${not empty saldoPrincipalTotal}">
															<tr>
																<td>Principal:</td>
																<td>${saldoPrincipalTotal}</td>
															</tr>
														</c:if>
														<c:if test="${not empty saldoHonorariosTotal}">
															<tr>
																<td>Honorários:</td>
																<td>${saldoHonorariosTotal}</td>
															</tr>
														</c:if>
														<c:if test="${not empty saldoGRERJsTotal}">														
															<tr>
																<td>Custas Judiciais:</td>
																<td>${saldoGRERJsTotal}</td>
															</tr>
														</c:if>
													</table>
													<br>
													<div>ATENÇÃO! NÃO efetuar o pagamento dos nossos DARMs no Banco Bradesco.</div>
													<br>
													<br>
													<br>
													<br>
													<br>
													<br>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #000 0px solid; border-left: #000 0px solid; border-bottom: #000 0px solid">
													<br> <span>${linhaDigitavel}<br></span>${codigoDeBarras}
												</td>
											</tr>
										</table>
									</td>
									<td valign="top">
										<table style="cellspacing: 01">
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													01. RECEITA<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.codReceita}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%">
												</td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													02. CERTIDÃO<br>
													<div style="TEXT-ALIGN: right">${numeroCda}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													03. DATA DE VENCIMENTO<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.dataVencimento}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													04. COMPETÊNCIA<br>
													<div style="TEXT-ALIGN: right">001/001 - 1</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													05. GUIA (PARA USO DA REPARTIÇÃO)<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.numeroGuia}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid"
													colspan="2">06. VALOR DA RECEITA<br>
													<div style="TEXT-ALIGN: right">*************</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													07. VALOR DA MORA<br>
													<div style="TEXT-ALIGN: right">*************</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													08. VALOR DA MULTA<br>
													<div style="TEXT-ALIGN: right">*************</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid"
													colspan="2">09. VALOR TOTAL<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.valorTotalGuia}</div>
												</td>
											</tr>
											<tr>
												<td colspan="2"
													style="BORDER-RIGHT: #000 0px solid; BORDER-LEFT: #000 0px solid; border-bottom: #000 0px solid">
													<div style="">AUTENTICAÇÃO MECÂNICA (PARA USO DO
														BANCO)</div>
												</td>
											</tr>
											<tr>
												<td style="width: 40%"></td>
												<td style="TEXT-ALIGN: center"><br>
												<br>
												<br> <span>1ª VIA - CONTRIBUINTE</span></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<br>
							<table style="width: 700px">
								<tr>
									<td
										style="border-style: dotted; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 5px; border-left-width: 0px;"
										colspan=2></td>
								</tr>
							</table>
							<br>
						</td>
					</tr>
					<tr>
						<td>
							<table>
								<tr>
									<td style="valign: top">
										<table>
											<tr>
												<td
													style="border-top: #001 1px solid; border-right: #001 1px solid; border-left: #001 1px solid; border-bottom: #001 1px solid">
													<table style="width: 450px">
														<tr>
															<td><img src="/iptu-consulta/img/LogoRJ.bmp"></td>
															<td><span>PREFEITURA DA CIDADE DO RIO DE
																	JANEIRO</span><br> PROCURADORIA GERAL DO MUNICÍPIO<br>
																PROCURADORIA DA DÍVIDA ATIVA<br> <span>DOCUMENTO
																	DE ARRECADAÇÃO DE RECEITAS<br> MUNICIPAIS
															</span>
																<div style="FONT-STYLE: normal; MARGIN: 2px 5px 0px; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-SIZE: 10px; TEXT-ALIGN: right">
																	<b>${tituloGuia}</b>
																</div></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-left: #001 1px solid; border-bottom: #001 1px solid">
													10. NOME / RAZÃO SOCIAL<br>
													${guiaPagamento.nomeRequerente}
													<div style="TEXT-ALIGN: right">
														<br> <span>INS: ${numInscricao}</span>
													</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-left: #001 1px solid; border-bottom: #001 1px solid">
													11. INFORMAÇÕES COMPLEMENTARES<br>
													<table>
														<c:if test="${not empty saldoPrincipalTotal}">
															<tr>
																<td>Principal:</td>
																<td>${saldoPrincipalTotal}</td>
															</tr>
														</c:if>
														<c:if test="${not empty saldoHonorariosTotal}">
															<tr>
																<td>Honorários:</td>
																<td>${saldoHonorariosTotal}</td>
															</tr>
														</c:if>
														<c:if test="${not empty saldoGRERJsTotal}">														
															<tr>
																<td>Custas Judiciais:</td>
																<td>${saldoGRERJsTotal}</td>
															</tr>
														</c:if>
													</table>
													<br>
													<div>ATENÇÃO! NÃO efetuar o pagamento dos nossos DARMs no Banco Bradesco.</div>
													<br>
													<br>
													<br>
													<br>
													<br>
													<br>
											</td>
											</tr>
											<tr>
												<td
													style="border-right: #000 0px solid; border-left: #000 0px solid; border-bottom: #000 0px solid">
													<br> <span>${linhaDigitavel}<br></span>${codigoDeBarras}
												</td>
											</tr>
										</table>
									</td>
									<td valign="top">
										<table style="cellspacing: 01">
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													01. RECEITA<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.codReceita}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%">
												</td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													02. CERTIDÃO<br>
													<div style="TEXT-ALIGN: right">${numeroCda}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													03. DATA DE VENCIMENTO<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.dataVencimento}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													04. COMPETÊNCIA<br>
													<div style="TEXT-ALIGN: right">001/001 - 1</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													05. GUIA (PARA USO DA REPARTIÇÃO)<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.numeroGuia}</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid"
													colspan="2">06. VALOR DA RECEITA<br>
													<div style="TEXT-ALIGN: right">*************</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													07. VALOR DA MORA<br>
													<div style="TEXT-ALIGN: right">*************</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid; width: 40%"></td>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid">
													08. VALOR DA MULTA<br>
													<div style="TEXT-ALIGN: right">*************</div>
												</td>
											</tr>
											<tr>
												<td
													style="border-right: #001 1px solid; border-top: #001 1px solid; border-bottom: #001 1px solid"
													colspan="2">09. VALOR TOTAL<br>
													<div style="TEXT-ALIGN: right">
														${guiaPagamento.valorTotalGuia}</div>
												</td>
											</tr>
											<tr>
												<td colspan="2"
													style="BORDER-RIGHT: #000 0px solid; BORDER-LEFT: #000 0px solid; border-bottom: #000 0px solid">
													<div style="">AUTENTICAÇÃO MECÂNICA (PARA USO DO
														BANCO)</div>
												</td>
											</tr>
											<tr>
												<td style="width: 40%"></td>
												<td style="TEXT-ALIGN: center"><br>
												<br>
												<br> <span>2ª VIA - BANCO</span></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</c:if>
	</c:if>
</body>
</html>