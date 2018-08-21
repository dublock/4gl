/************************************************************************************************************
**  Cliente     : xxx                                                 **
**  Projeto     : Contas a Receber - Envio de e-mail para cobranáa automatizado                            **
**  Programa    : NEB001.p                                                                                 **
**  Versío      : 1.00.00.000 - 05/2014                                                                    **
**  Descri?ío   : Envia e-mail notificando aos cliente sobre boletos que est∆o vencendo, no prazo de um dia**
**  Observa?ío  :                                                                                          **
*************************************************************************************************************/
{include/i-prgvrs.i NEB_Boletos 2.04.00.004}
{utp/utapi019.i}


DEF VAR data                 AS DATE    NO-UNDO.
DEF VAR email                AS CHAR    NO-UNDO.


data = TODAY.

FOR EACH tit_acr where YEAR(dat_vencto_tit_acr) = YEAR(TODAY) AND cod_estab <> "201".

    IF INTERVAL(DATE(dat_vencto_tit_acr),DATE(data),'days') = 1 AND cod_espec_docto = "DP" THEN DO:
        
        RUN pi-envia-email.
    END.
   
END.

END.


procedure pi-envia-email.

    FIND FIRST emitente WHERE emitente.cod-emitente = tit_acr.cdn_cliente.
        
        email = emitente.email.

    RUN utp/utapi019.p PERSISTENT SET h-utapi019.

    FIND FIRST param-global NO-LOCK NO-ERROR.
    
    FOR EACH tt-envio2:    delete tt-envio2.    end.
    FOR EACH tt-mensagem:  delete tt-mensagem.  end.

    CREATE tt-envio2.
    ASSIGN tt-envio2.versao-integracao = 1
           tt-envio2.assunto     = "Titulos a vencer - Empresa"
           tt-envio2.formato     = "HTML"
           tt-envio2.servidor    = param-global.serv-mail
           tt-envio2.porta       = param-global.porta
           tt-envio2.remetente   = "financeiro@seudominio.com.br"
           tt-envio2.destino     = emitente.email.


    CREATE tt-mensagem.
    ASSIGN tt-mensagem.seq-mensagem = 1
           tt-mensagem.mensagem     =  '<html>' +
                                    '<body>' +
                                    '<p><span><font face="Calibri">Caro cliente,</font></span></p>' +
                                    '<p><span><font face="Calibri">Fique atento ao seu pr¢ximo vencimento junto Ö Empresa </font>' + STRING(tit_acr.dat_vencto_tit_acr) + '<font face="Calibri"> - Valor : R$ </font>' + trim(string(tit_acr.val_origin_tit_acr,">>>>,>>9.99")) + '<font face="Calibri"> - Documento : </font>' + STRING(tit_acr.cod_tit_acr) + '<font face="Calibri">/</font>' + STRING(tit_acr.cod_parcela) + '</span></p>' +
                                    '<p><span><font face="Calibri">O boleto foi enviado para o e-mail ' + STRING(email) + ' no momento da emiss∆o de sua nota fiscal.</font></span></p>' +
                                    '<p>&nbsp;	</p>' +
                                    '<p><span><font face="Calibri">Fale com a Empresa.</font></span></p>' +       
                                    '<p><span><font face="Calibri">Para boletos atualizados: (xx)xxxx-xxxx - financeiro@seudominio.com.br</font></span></p>' +
                                    '<p><span><font face="Calibri">Em caso de recebimento de mercadorias em desconformidades: (xx)xxxx-xxxx - sac@seudominio.com.br.</font></span></p>' +
                                    '<p>&nbsp;	</p>' +
                                    '<p><span><font face="Calibri">Esta Ç uma emiss∆o autom†tica e em caso o pagamento dos t°tulos citados j† tenha sido efetuado, favor desconsidera-la.</font></span></p>' +
                                    '<p><span><font face="Calibri">Atenciosamente,</font></span></p>' +
                                    '<p><span><font face="Calibri">Empresa.</font></span></p>' +
                                    '<p><span><font face="Calibri"> </font></span></p>' + 
                                    '<img src="https://dominio.com.br/logo.png" width="194" height="83">' +                                   
					  '</body>' +
					  '</html>'.

           
                                                   
    RUN pi-execute2 in h-utapi019 (input  table tt-envio2,
        
    input  table tt-mensagem,
    output table tt-erros).
    
    IF  return-value = "NOK" then do:
        FOR EACH tt-erros:
            disp tt-erros with 1 column width 300.
        END. 
                                  
    END.

    delete procedure h-utapi019.   

END procedure. 



