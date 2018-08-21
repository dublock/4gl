/************************************************************************************************************
**  Cliente     : Empresa                                                  **
**  Projeto     : Controle de Qualidade - Envio de e-mail para os clientes para pesquisa de satisfa‡Æo     **
**  Programa    : PS001.p                                                                                  **
**  Vers’o      : 1.00.00.000 - 054/2016                                                                   **
**  Descri?’o   : Envia e-mail com pesquisa de satisfacao para os clintes                                  **
**  Observa?’o  :                                                                                          **
*************************************************************************************************************/
{include/i-prgvrs.i epsquisa 2.04.00.004}
{utp/utapi019.i}


DEF VAR data                 AS DATE    NO-UNDO.
DEF VAR data2                AS CHAR    NO-UNDO.

DEF VAR tt-cod-emitente      AS CHAR    NO-UNDO.
DEF VAR tt-cod-pes           AS CHAR    NO-UNDO.

DEF VAR tt-temp-var          AS INTEGER NO-UNDO.

DEF VAR email                AS CHAR    NO-UNDO.
DEF VAR telefone             AS CHAR    NO-UNDO.

data = TODAY.
data2 = STRING(YEAR(TODAY)).


FOR EACH nota-fiscal where YEAR(dt-emis-nota) = 2018 AND INTERVAL(DATE(dt-emis-nota),DATE(data),'days') = -20.
   
    tt-cod-emitente  = STRING(cod-emitente).
    tt-cod-pes = tt-cod-emitente + data2.

FIND FIRST bancoesp.pesquisa WHERE tt-cod-pes = pesquisa.cod_pes NO-ERROR.
    
    IF  AVAILABLE bancoesp.pesquisa THEN
                
        tt-temp-var = tt-temp-var + 1.

    ELSE 
        
        RUN pi-envia-email NO-ERROR.



    procedure pi-envia-email.

    FIND FIRST emitente WHERE cod-emitente = nota-fiscal.cod-emitente.
        
        email = emitente.email.
       

    RUN utp/utapi019.p PERSISTENT SET h-utapi019.

    FIND FIRST param-global NO-LOCK NO-ERROR.
    
    FOR EACH tt-envio2:    delete tt-envio2.    end.
    FOR EACH tt-mensagem:  delete tt-mensagem.  end.

    CREATE tt-envio2.
    ASSIGN tt-envio2.versao-integracao = 1
           tt-envio2.assunto     = "Pesquisa de Satisfa‡Æo"
           tt-envio2.formato     = "HTML"
           tt-envio2.servidor    = param-global.serv-mail
           tt-envio2.porta       = param-global.porta
           tt-envio2.remetente   = "pesquisa@seudominio.com.br"
           tt-envio2.destino     = emitente.email.


    CREATE tt-mensagem.
    ASSIGN tt-mensagem.seq-mensagem = 1
           tt-mensagem.mensagem     =  '<html>' +
                                    '<body>' +
                                    '<p><span><font face="Calibri">Prezado cliente,</font></span></p>' +
                                    '<p><span><font face="Calibri">De forma a contribuir para melhorarmos cada vez mais o nosso atendimento, al‚m de atendermos o Sistema de GestÆo da Qualidade,</font>' +
                                    '<p><span><font face="Calibri">pedimos a gentileza de responder algumas questäes referente a satisfa‡Æo de nossos produtos e servi‡os, sendo de fundamental importƒncia a sua colabora‡Æo </font></span></p>' +
                                    '<p><span><font face="Calibri">A pesquisa ‚ composta por questäes fechadas que devem ser respondidas atrav‚s do grau de sua satisfa‡Æo pontuando de 0 Î 10.</font></span></p>' +
                                    '<p><span><font face="Calibri">Sendo:  0 a 2 ruim, 3 a 4 regular, 5 a 7 bom, 8 a 9 muito bom, 10 excelente.</font></span></p>' +
                                    '<p><span><font face="Calibri">Basta acessar o endere»o <a href="http://seudominio.com.br/pesquisa.php' + STRING(nota-fiscal.cod-emitente) + '&20='  + STRING(nota-fiscal.nome-ab-cli) + '&30=' + STRING(nota-fiscal.nr-nota-fis) + '&40=' + STRING(emitente.telefone[1]) + '&50=' + STRING(emitente.telefone[2]) + '" target="_blank" >http://pesquisa.seudominio.com.br/</a> Obrigado!</font></span></p>' +                                    '<p>&nbsp;	</p>' +
                                    '<img src="http://seudominio.com.br/status/images/logo.png" width="317" height="83">' +                                   
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
END.
