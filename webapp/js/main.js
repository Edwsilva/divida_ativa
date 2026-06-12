var _1MB=1048576;
var _1eMeioMB=1572864;
var _500KB=512000;
var _2MB=2097152;
var msgExtensoes="PDF ou JPG ou PNG ou GIF";

function printDivRequerimentoCertidaoDam() {
    $("#enviarrequerimentocertidaodam").printElement({
        overrideElementCSS: ["/carioca-digital-theme/css/carioca-common.css", "/carioca-digital-theme/css/main.css", "/notacarioca/css/impressao.css"]
    })
}

function printDivCertidaoDam() {
	$("#consultaCertidaoDam").printElement({
        overrideElementCSS: ["/carioca-digital-theme/css/carioca-common.css", "/carioca-digital-theme/css/main.css", "/notacarioca/css/impressao.css"]
    })
}

function alterarCpfOuCnpj() {
	var a = $("input[type=radio][name='tipoDoc']:checked").val();
	if (a == 1) {
		$("#cnpj_id").css({
			display : "none"
		});
		$("#cnpj_id1").css({
			display : "none"
		});		
		$("#cpf_id").css({
			display : "block"
		});
		$("#cpf_id1").css({
			display : "block"
		});
		$("#asteristicoRegistros").hide();
        $("#asteristicoNomeMae").show();
        $("#asteristicoDataNascimento").show();
	} else {
		$("#cnpj_id").css({
			display : "block"
		});
		$("#cnpj_id1").css({
			display : "block"
		});
		$("#cpf_id").css({
			display : "none"
		});
		$("#cpf_id1").css({
			display : "none"
		});
		$("#asteristicoRegistros").show();
        $("#asteristicoNomeMae").hide();
        $("#asteristicoDataNascimento").hide();
	}
}

function alterarCpfOuCnpjAlteracaoDestinatario() {
	var a = $("input[type=radio][name='tipoDocAltDest']:checked").val();
	if (a == 1) {
		$("#cpf_id_alt_dest").css({
			display : "none"
		});
		$("#cnpj_id_alt_dest").css({
			display : "block"
		})
	} else {
		$("#cpf_id_alt_dest").css({
			display : "block"
		});
		$("#cnpj_id_alt_dest").css({
			display : "none"
		})
	}
}

	function selecionarFiltroParaConsulta() {
		var a = $("select[name='filtroConsulta']").val();

		$("#numInscricao").val('');
		$("#numCDA").val('');
		$("#numGuiaPagamento").val('');
		$("#numExecucaoFiscalNova").val('');
		$("#numExecucaoFiscalAntiga").val('');
		$("input[type=radio][name='tipoNumExecucaoFiscal'][value='0']").attr('checked',true);

		$("#numInscricao_id").css({
			display : "none"
		});
		$("#numCDA_id").css({
			display : "none"
		});
		$("#textoExplicativoExecucaoFiscal").css({
			display: "none"
		});
		$("#tipoNumExecucaoFiscal_id").css({
			display : "none"
		});
		$("#numExecucaoFiscalNova_id").css({
			display : "none"
		});
		$("#numExecucaoFiscalAntiga_id").css({
			display : "none"
		});
		$("#numGuiaPagamento_id").css({
			display : "none"
		});		
	
		if (a == 1) {
			$("#numInscricao_id").css({
				display : "block"
			});
		} 
	
		if (a == 2) {
			$("#numCDA_id").css({
				display : "block"
			});
		} 
	
		if (a == 3){
			$("#tipoNumExecucaoFiscal_id").css({
				display : "block"
			});
			$("#textoExplicativoExecucaoFiscal").css({
				display: "block"
			});
			$("#numExecucaoFiscalNova_id").css({
				display : "block"
			});
			$("#numExecucaoFiscalAntiga_id").css({
				display : "none"
			});
		}
		
		if (a == 4) {
			$("#numGuiaPagamento_id").css({
				display : "block"
			});
		} 		
	}

	function alterarNumExecucaoFiscalAntigaOuNova() {
		var a = $("input[type=radio][name='tipoNumExecucaoFiscal']:checked").val();
		if (a == 1) {
			$("#numExecucaoFiscalNova_id").css({
				display : "none"
			});
			$("#numExecucaoFiscalAntiga_id").css({
				display : "block"
			});
		} else {
			$("#numExecucaoFiscalNova_id").css({
				display : "block"
			});
			$("#numExecucaoFiscalAntiga_id").css({
				display : "none"
			});
		}
	}
	
	function MandaPraDaminternetSeForAdiantamento() {
		var a = $("input[type=radio][name='opcaoDAM']:checked").val();
		if (a == "consultarAdiantamentoDam") {
			$("#OK").css({
				display : "none"
			});
			$("#OKAdiantamento").css({
				display : "block"
			});
		} else {
			$("#OK").css({
				display : "block"
			});
			$("#OKAdiantamento").css({
				display : "none"
			});
		}
	}	

	function exibirColorboxSending(msg) {
	    $.colorbox({
	        opacity: 0.3,
	        close: "Fechar",
	        transition: "none",
	        speed: 0,
	        width: "90px",
	        initialWidth: 90,
	        height: "90px",
	        initialHeight: 65,
	        open: true,
	        overlayClose: false,
	        escKey: false,
	    	closeButton: false,
	    	onOpen: function() {
	            $("#cboxLoadingOverlay").html("<div align='center'><br/><p style='font-size:9px;'>"+msg+"</p><img src='/multas-consulta/image/loading.gif'/><p style='font-size:9px;'>Aguarde!</p></div>")
	        }
	    })
	}
	
	function exibirColorbox(a) {
		$.colorbox({
			opacity: 0.3,
			close: "Fechar",
			open: true,
			height: "70%",
			width: "50%",
			href: a
		})
	}	

	function ValidaCPFReceitaFederal() {
		if ($("input[type=radio][name='tipoDoc']:checked").val() != '1')
			return null;
		if (($("#nome").val().replace(/^\s+|\s+$/g,"") == '') || ($("#cpf").val().replace(/^\s+|\s+$/g,"") == '') || ($("#nomeMae").val().replace(/^\s+|\s+$/g,"") == '') || ($("#dataNascimento").val().replace(/^\s+|\s+$/g,"") == ''))
			return null;

		var cpf =$("#cpf").val();

		$(".loading").show();

		var href = urlAjaxCpfCnpj;
    
		$.ajax({
			url : href,
			type : "POST",
			data : {
				cpf : cpf
			},
			success : function(retorno) {
				$(".loading").hide(1000);
			
				var nome           = eval("[" + retorno + "]")[0].lista[0];
				var nomeMae        = eval("[" + retorno + "]")[0].lista[1];
				var dataTemp       = eval("[" + retorno + "]")[0].lista[2];
				var dataNascimento = dataTemp.slice(6) + "/" + dataTemp.slice(4,6) + "/" + dataTemp.slice(0,4);
			
				if (nome == ""){
					alert("CPF do contribuinte não cadastro na Receita Federal.");
					$("#cpf").val('');
				}
				else
					if (
							(nome.replace(/ /g, '') != $("#nome").val().replace(/ /g, '')
                                                     .replace(/[áàãâä]/gi, "a")
                                                     .replace(/[éè¨ê]/gi, "e")
                                                     .replace(/[íìïî]/gi, "i")
                                                     .replace(/[óòöôõ]/gi, "o")
                                                     .replace(/[úùüû]/gi, "u")
                                                     .replace(/[ç]/gi, "c")
                                                     .replace(/[ñ]/gi, "n")
                                                     .replace(/[^a-zA-Z0-9]/g, " ")
                                                     .toUpperCase()) ||
                                                     (nomeMae.replace(/ /g, '') != $("#nomeMae").val().toUpperCase().replace(/ /g, '')
                                                     .replace(/[áàãâä]/gi, "a")
                                                     .replace(/[éè¨ê]/gi, "e")
                                                     .replace(/[íìïî]/gi, "i")
                                                     .replace(/[óòöôõ]/gi, "o")
                                                     .replace(/[úùüû]/gi, "u")
                                                     .replace(/[ç]/gi, "c")
                                                     .replace(/[ñ]/gi, "n")
                                                     .replace(/[^a-zA-Z0-9]/g, " ")
                                                     .toUpperCase()) ||
                                                     (dataNascimento != $("#dataNascimento").val())
					) {

						alert("Dados do contribuinte não coincidem com o cadastro da Receita Federal.");
						limparCamposContribuinte();
					}
					else {
						//alert("CPF Válido!");
					}
			},
			error: function (retorno) {
				$(".loading").hide(1000);
				alert("Consulta ao CPF da Receita Federal indisponível no momento.");
				$("#cpf").val('');
			}//,
			//timeout: 3000
		});
    
    function limparCamposContribuinte(dados) {
        $("#cpf").val('');
        $("#nome").val('');
        $("#nomeMae").val('');
        $("#dataNascimento").val('');
    }
}

function ValidaCPFRequerenteReceitaFederal() {
    if (($("#nomeRequerente").val().replace(/^\s+|\s+$/g,"") == '') || ($("#cpfRequerente").val().replace(/^\s+|\s+$/g,"") == '') || ($("#nomeMaeRequerente").val().replace(/^\s+|\s+$/g,"") == '') || ($("#dataNascimentoRequerente").val().replace(/^\s+|\s+$/g,"") == ''))
        return null;

	var cpf =$("#cpfRequerente").val();

	$(".loading2").show();

    var href = urlAjaxCpfCnpj;
    
    $.ajax({
		url : href,
		type : "POST",
		data : {
			cpf : cpf
		},
		success : function(retorno) {
			$(".loading2").hide(1000);
			
			var nome           = eval("[" + retorno + "]")[0].lista[0];
			var nomeMae        = eval("[" + retorno + "]")[0].lista[1];
			var dataTemp       = eval("[" + retorno + "]")[0].lista[2];
			var dataNascimento = dataTemp.slice(6) + "/" + dataTemp.slice(4,6) + "/" + dataTemp.slice(0,4);
			
			if (nome == ""){
            	alert("CPF do requerente não cadastro na Receita Federal.");
                $("#cpfRequerente").val('');
            }
			else
            if (
                (nome.replace(/ /g, '') != $("#nomeRequerente").val().replace(/ /g, '')
                                                     .replace(/[áàãâä]/gi, "a")
                                                     .replace(/[éè¨ê]/gi, "e")
                                                     .replace(/[íìïî]/gi, "i")
                                                     .replace(/[óòöôõ]/gi, "o")
                                                     .replace(/[úùüû]/gi, "u")
                                                     .replace(/[ç]/gi, "c")
                                                     .replace(/[ñ]/gi, "n")
                                                     .replace(/[^a-zA-Z0-9]/g, " ")
                                                     .toUpperCase()) ||
                (nomeMae.replace(/ /g, '') != $("#nomeMaeRequerente").val().toUpperCase().replace(/ /g, '')
                                                     .replace(/[áàãâä]/gi, "a")
                                                     .replace(/[éè¨ê]/gi, "e")
                                                     .replace(/[íìïî]/gi, "i")
                                                     .replace(/[óòöôõ]/gi, "o")
                                                     .replace(/[úùüû]/gi, "u")
                                                     .replace(/[ç]/gi, "c")
                                                     .replace(/[ñ]/gi, "n")
                                                     .replace(/[^a-zA-Z0-9]/g, " ")
                                                     .toUpperCase()) ||
                (dataNascimento != $("#dataNascimentoRequerente").val())
                ) {

            	alert("Dados do requerente não coincidem com o cadastro da Receita Federal.");
                limparCamposRequerente();
            }
            else {
                //alert("CPF do Requerente Válido!");
            }
        },
        error: function (retorno) {
			$(".loading2").hide(1000);
        	alert("Consulta ao CPF da Receita Federal indisponível no momento.");
            $("#cpfRequerente").val('');
        }//,
        //timeout: 3000
    });
    
    function limparCamposRequerente(dados) {
        $("#cpfRequerente").val('');
        $("#nomeRequerente").val('');
        $("#nomeMaeRequerente").val('');
        $("#dataNascimentoRequerente").val('');
    }

 	function limpa(dados) {
	    $("#logradouro").val('');
	    $("#bairro").val('');
	    $("#cidade").val('');
	    $("#uf").val('');
	}	

	function obterIndiceUF(text)
	{
	if(text == 'AC') return 1; else
	if(text == 'AL') return 2; else
	if(text == 'AP') return 3; else
	if(text == 'AM') return 4; else
	if(text == 'BA') return 5; else
	if(text == 'CE') return 6; else
	if(text == 'DF') return 7; else
	if(text == 'ES') return 8; else
	if(text == 'GO') return 9; else
	if(text == 'MA') return 10; else
	if(text == 'MT') return 11; else
	if(text == 'MS') return 12; else
	if(text == 'MG') return 13; else
	if(text == 'PA') return 14; else
	if(text == 'PB') return 15; else
	if(text == 'PR') return 16; else
	if(text == 'PE') return 17; else
	if(text == 'PI') return 18; else
	if(text == 'RJ') return 19; else
	if(text == 'RN') return 20; else
	if(text == 'RS') return 21; else
	if(text == 'RO') return 22; else
	if(text == 'RR') return 23; else
	if(text == 'SC') return 24; else
	if(text == 'SP') return 25; else
	if(text == 'SE') return 26; else
	if(text == 'TO') return 27;
	}	
}

function getFileSize(fileid) {
	try {
	    var fileSize = 0;
	    
	    //for IE
	    if (navigator.userAgent.match(/msie/i)) {
	        //before making an object of ActiveXObject, 
	        //please make sure ActiveX is enabled in your IE browser
	        var objFSO = new ActiveXObject("Scripting.FileSystemObject"); 
	        var filePath = $("#" + fileid)[0].value;
	        var objFile = objFSO.getFile(filePath);
	        fileSize = objFile.size; //size in bytes
	    }else { //for FF, Safari, Opeara and Others
	        fileSize = $("#" + fileid)[0].files[0].size //size in kb
	    }
	    
	    return fileSize;
	}
	catch (e) {
	    alert("Error is :" + e);
	}
}

function isValidImgFile(filename){
	var isValidFile=false;

	if(filename!==null && filename.toUpperCase().indexOf(".PDF")>0){
	    isValidFile=true;
	} else if(filename!==null && filename.toUpperCase().indexOf(".JPG")>0){
	    isValidFile=true;
	} else if(filename!==null && filename.toUpperCase().indexOf(".JPEG")>0){
	    isValidFile=true;
	} else if(filename!==null && filename.toUpperCase().indexOf(".PNG")>0){
	    isValidFile=true;
	} else if(filename!==null && filename.toUpperCase().indexOf(".GIF")>0){
	    isValidFile=true;
	}

	return isValidFile;	
}

function isValidImgZipFile(filename){
	var isValidFile=isValidImgFile(filename);
	
	if(!isValidFile && (filename!==null && filename.toUpperCase().indexOf(".ZIP")>0)){
	    isValidFile=true;
	}
	
	return isValidFile;
}

function atualizacep(url, cep){
  	$(".loading3").show();

	cep = cep.replace(/\D/g,"");
		
  	$.ajax({
  		url : url,
  		type : "POST",
  		data : {cep: cep},
  		success : function(resourceResponse) {  			
  			$(".loading3").hide();
			if(resourceResponse == 'erro'){
				alert('A consulta de CEP está temporariamente indisponível. Por favor, tente novamente mais tarde');
			}else{
				if(resourceResponse != null)	
					atualizarValores(eval("[" + resourceResponse + "]")[0]);
			}	  		
  		},
  		error : function(erro) {
  			$(".loading3").hide();
  		}
  	});
}

function validaSenha(url, senha){
  	$(".loading3").show();

  	$.ajax({
  		url : url,
  		type : "POST",
  		data : {senha: senha},
  		success : function(resourceResponse) {  			
  			$(".loading3").hide();
  			
			if (resourceResponse == ''){
				$.fn.colorbox.close();
				parent.retornoSenhaOK();
			}
			else
				if(resourceResponse == 'erro')
					alert('A validação de senha está temporariamente indisponível. Por favor, tente novamente mais tarde');
				else {
					$("#senha").val("");
					alert(resourceResponse);
				}	  		
  			},
  			error : function(erro) {
  				$(".loading3").hide();
  				alert('A validação de senha está temporariamente indisponível. Por favor, tente novamente mais tarde');
  			}
  		});
  	return false;
}

function atualizarValores(valor) {
	document.getElementById("infoCepNotFound").style.display = "none";
	if (valor.serializable.logradouro < 1 || valor.serializable.logradouroFmt == null) {
		document.getElementById("infoCepNotFound").style.display = "block";
		$("#logradouro").attr("readonly", false); 
		$("#bairro").attr("readonly", false); 
		$("#cidade").attr("readonly", false); 
		$('#uf').attr("readonly", false); 
	}else{
		$("#logradouro").attr("readonly", true); 
		$("#bairro").attr("readonly", true); 
		$("#cidade").attr("readonly", true);
		$('#uf').attr("readonly", true); 
	}

	document.getElementById('logradouro').value=valor.serializable.logradouroFmt;
	document.getElementById('bairro').value=valor.serializable.bairro;
	document.getElementById('cidade').value=valor.serializable.cidade;
	document.getElementById('numero').value = valor.serializable.numero;
	document.getElementById('complemento').value = valor.serializable.complemento;

	$("#uf").val(valor.serializable.uf);
}

function validarCNPJ(cnpj) {
	 
    cnpj = cnpj.replace(/[^\d]+/g,'');
 
    if(cnpj == '') return false;
     
    if (cnpj.length != 14)
        return false;
 
    // Elimina CNPJs invalidos conhecidos
    if (cnpj == "00000000000000" || 
        cnpj == "11111111111111" || 
        cnpj == "22222222222222" || 
        cnpj == "33333333333333" || 
        cnpj == "44444444444444" || 
        cnpj == "55555555555555" || 
        cnpj == "66666666666666" || 
        cnpj == "77777777777777" || 
        cnpj == "88888888888888" || 
        cnpj == "99999999999999")
        return false;
         
    // Valida DVs
    tamanho = cnpj.length - 2
    numeros = cnpj.substring(0,tamanho);
    digitos = cnpj.substring(tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
      soma += numeros.charAt(tamanho - i) * pos--;
      if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(0))
        return false;
         
    tamanho = tamanho + 1;
    numeros = cnpj.substring(0,tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
      soma += numeros.charAt(tamanho - i) * pos--;
      if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(1))
          return false;
           
    return true;
}

function validarCPF(cpf) {	
	cpf = cpf.replace(/[^\d]+/g,'');	
	if(cpf == '') return false;	
	// Elimina CPFs invalidos conhecidos	
	if (cpf.length != 11 || 
		cpf == "00000000000" || 
		cpf == "11111111111" || 
		cpf == "22222222222" || 
		cpf == "33333333333" || 
		cpf == "44444444444" || 
		cpf == "55555555555" || 
		cpf == "66666666666" || 
		cpf == "77777777777" || 
		cpf == "88888888888" || 
		cpf == "99999999999")
			return false;		
	// Valida 1o digito	
	add = 0;	
	for (i=0; i < 9; i ++)		
		add += parseInt(cpf.charAt(i)) * (10 - i);	
		rev = 11 - (add % 11);	
		if (rev == 10 || rev == 11)		
			rev = 0;	
		if (rev != parseInt(cpf.charAt(9)))		
			return false;		
	// Valida 2o digito	
	add = 0;	
	for (i = 0; i < 10; i ++)		
		add += parseInt(cpf.charAt(i)) * (11 - i);	
	rev = 11 - (add % 11);	
	if (rev == 10 || rev == 11)	
		rev = 0;	
	if (rev != parseInt(cpf.charAt(10)))
		return false;		
	return true;   
}