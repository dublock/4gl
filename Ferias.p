{include/i-prgvrs.i NEB_Ferias 2.04.00.004}
{utp/utapi019.i}

/*################################################## F‚rias #############################################*/
    
FOR EACH sit_afast_func WHERE cdn_sit_afast = 90 AND dat_inic_sit_afast = TODAY.

 RUN pi-envia-email.


procedure pi-envia-email.

    FIND FIRST funcionario WHERE cdn_funcionario = sit_afast_func.cdn_funcionario.
        
       
    RUN utp/utapi019.p PERSISTENT SET h-utapi019.

    FIND FIRST param-global NO-LOCK NO-ERROR.
    
    FOR EACH tt-envio2:    delete tt-envio2.    end.
    FOR EACH tt-mensagem:  delete tt-mensagem.  end.

    CREATE tt-envio2.
    ASSIGN tt-envio2.versao-integracao = 1
           tt-envio2.assunto     = "F‚rias Funcion rio: Bloquear Acessos"
           tt-envio2.formato     = "HTML"
           tt-envio2.servidor    = param-global.serv-mail
           tt-envio2.porta       = param-global.porta
           tt-envio2.remetente   = "xxx@seudominio.com.br"
           tt-envio2.destino     = "xxx@seudominio.com.br".


    CREATE tt-mensagem.
    ASSIGN tt-mensagem.seq-mensagem = 1
           tt-mensagem.mensagem     =  '<html>' +
                                    '<body>' +
                                    '<p><span><font face="Calibri">Prezados,</font></span></p>' +
                                    '<p><span><font face="Calibri">O seguinte funcion rio esta de f‚rias: </font>' + STRING(nom_pessoa_fisic) + '<font face="Calibri"> - Matricula: </font>' + string(funcionario.cdn_funcionario) + '<font face="Calibri"> - Data Inicio: </font>' + STRING(dat_inic_sit_afast) + '<font face="Calibri"> / Data Final: </font>' + STRING(dat_term_sit_afast) + '</span></p>' + '<font face="Calibri">Favor, bloquear os acessos: Datasul, AD, e-mail e Fluig, at‚ o t‚rmino do per¡odo. Se necess rio, envie este e-mail para xxx@seudominio.com.br, para monitoramento.</font>' +
                                                                    
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


/*################################################## VOLTA #############################################*/

FOR EACH sit_afast_func WHERE cdn_sit_afast = 90 AND dat_term_sit_afast = TODAY.

 RUN pi-envia-email-volta.


procedure pi-envia-email-volta.

    FIND FIRST funcionario WHERE cdn_funcionario = sit_afast_func.cdn_funcionario.
        
       

    RUN utp/utapi019.p PERSISTENT SET h-utapi019.

    FIND FIRST param-global NO-LOCK NO-ERROR.
    
    FOR EACH tt-envio2:    delete tt-envio2.    end.
    FOR EACH tt-mensagem:  delete tt-mensagem.  end.

    CREATE tt-envio2.
    ASSIGN tt-envio2.versao-integracao = 1
           tt-envio2.assunto     = "Funcion rio Voltando de F‚rias: Desbloquear Acessos"
           tt-envio2.formato     = "HTML"
           tt-envio2.servidor    = param-global.serv-mail
           tt-envio2.porta       = param-global.porta
           tt-envio2.remetente   = "xxx@seudominio.com.br"
           tt-envio2.destino     = "xxx@seudominio.com.br".


    CREATE tt-mensagem.
    ASSIGN tt-mensagem.seq-mensagem = 1
           tt-mensagem.mensagem     =  '<html>' +
                                    '<body>' +
                                    '<p><span><font face="Calibri">Prezados,</font></span></p>' +
                                    '<p><span><font face="Calibri">O seguinte funcion rio esta voltando de f‚rias hoje: </font>' + STRING(nom_pessoa_fisic) + '<font face="Calibri"> - Matricula: </font>' + string(funcionario.cdn_funcionario) + '<font face="Calibri"> - Data Final: </font>' + STRING(dat_inic_sit_afast) + '<font face="Calibri"> / Data Final: </font>' + STRING(dat_term_sit_afast) + '</span></p>' + '<font face="Calibri">Favor, desbloquear os acessos: Datasul, AD, e-mail e Fluig.</font>' +
                                                                    
					  '</body>' +
					  '</html>'.

           
                                                   
    RUN pi-execute2 in h-utapi019 (input  table tt-envio2,
        
    input  table tt-mensagem,
    output table tt-erros).
    
    IF  RETURN-VALUE = "NOK" then do:
        FOR EACH tt-erros:
            disp tt-erros with 1 column width 300.
        END. 
                                  
    END.

    DELETE PROCEDURE h-utapi019.   

END PROCEDURE.  



END.
END.                                              
                                                        
                                                            
    
