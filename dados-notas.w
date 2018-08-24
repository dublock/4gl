&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: neb_nf_canceladas_devolvidas

  Description: Programa para analisar as notas que foram Canceladas ou devolvidas em 
  um determinado per¡odo.

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: Duanderson Block - 21/02/2018

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.


DEFINE TEMP-TABLE tt-nota-fiscal NO-UNDO

FIELD tt-cod-estabel        LIKE nota-fiscal.cod-estabel
FIELD tt-nr-nota-fis        LIKE nota-fiscal.nr-nota-fis
FIELD tt-cod-emitente       LIKE nota-fiscal.cod-emitente
FIELD tt-nome-ab-cli        LIKE nota-fiscal.nome-ab-cli
FIELD tt-estado             LIKE nota-fiscal.estado
FIELD tt-cidade             LIKE nota-fiscal.cidade
FIELD tt-nr-tabpre          LIKE nota-fiscal.nr-tabpre
FIELD tt-cod-rep            LIKE nota-fiscal.cod-rep
FIELD tt-no-ab-reppri       LIKE nota-fiscal.no-ab-reppri.

DEFINE VARIABLE h-acomp      AS HANDLE      NO-UNDO.


/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frame-b
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-nota-fiscal

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 tt-nota-fiscal.tt-cod-estabel tt-nota-fiscal.tt-nr-nota-fis tt-nota-fiscal.tt-cod-emitente tt-nota-fiscal.tt-nome-ab-cli tt-nota-fiscal.tt-estado tt-nota-fiscal.tt-cidade tt-nota-fiscal.tt-nr-tabpre tt-nota-fiscal.tt-cod-rep tt-nota-fiscal.tt-no-ab-reppri   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH tt-nota-fiscal
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH tt-nota-fiscal.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 tt-nota-fiscal
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 tt-nota-fiscal


/* Definitions for FRAME frame-b                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frame-b ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 IMAGE-7 IMAGE-8 fi-dt-ini fi-dt-fim ~
bt-ok BROWSE-2 
&Scoped-Define DISPLAYED-OBJECTS fi-dt-ini fi-dt-fim 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-ok 
     LABEL "OK" 
     SIZE 9 BY 1.

DEFINE VARIABLE fi-dt-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1 NO-UNDO.

DEFINE VARIABLE fi-dt-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1 NO-UNDO.

DEFINE IMAGE IMAGE-7
     FILENAME "image/im-fir.bmp":U
     SIZE 2.57 BY .75.

DEFINE IMAGE IMAGE-8
     FILENAME "image/im-las.bmp":U
     SIZE 2.57 BY .75.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 59 BY 2.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      tt-nota-fiscal SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 C-Win _FREEFORM
  QUERY BROWSE-2 DISPLAY
      tt-nota-fiscal.tt-cod-estabel
tt-nota-fiscal.tt-nr-nota-fis
tt-nota-fiscal.tt-cod-emitente
tt-nota-fiscal.tt-nome-ab-cli 
tt-nota-fiscal.tt-estado
tt-nota-fiscal.tt-cidade
tt-nota-fiscal.tt-nr-tabpre
tt-nota-fiscal.tt-cod-rep
tt-nota-fiscal.tt-no-ab-reppri
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 151 BY 15 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frame-b
     fi-dt-ini AT ROW 2.17 COL 55.72 COLON-ALIGNED WIDGET-ID 2
     fi-dt-fim AT ROW 2.17 COL 78.57 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     bt-ok AT ROW 2.17 COL 95.29 WIDGET-ID 6
     BROWSE-2 AT ROW 4.25 COL 2 WIDGET-ID 200
     RECT-1 AT ROW 1.33 COL 46.43 WIDGET-ID 14
     IMAGE-7 AT ROW 2.29 COL 70.86 WIDGET-ID 102
     IMAGE-8 AT ROW 2.29 COL 77.57 WIDGET-ID 104
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 153 BY 18.71
         BGCOLOR 8  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Dados Nota Fiscal"
         HEIGHT             = 18.92
         WIDTH              = 153
         MAX-HEIGHT         = 30.58
         MAX-WIDTH          = 214.57
         VIRTUAL-HEIGHT     = 30.58
         VIRTUAL-WIDTH      = 214.57
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frame-b
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-2 bt-ok frame-b */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY BROWSE-2 FOR EACH tt-nota-fiscal.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Dados Nota Fiscal */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Dados Nota Fiscal */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-ok C-Win
ON CHOOSE OF bt-ok IN FRAME frame-b /* OK */
DO:
  RUN geraDados.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fi-dt-ini fi-dt-fim 
      WITH FRAME frame-b IN WINDOW C-Win.
  ENABLE RECT-1 IMAGE-7 IMAGE-8 fi-dt-ini fi-dt-fim bt-ok BROWSE-2 
      WITH FRAME frame-b IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frame-b}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraDados C-Win 
PROCEDURE geraDados :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EMPTY TEMP-TABLE tt-nota-fiscal.

RUN utp/ut-acomp.p PERSISTENT SET h-acomp.

RUN pi-inicializar IN h-acomp (INPUT 'Processando...').

FOR EACH nota-fiscal WHERE nota-fiscal.dt-emis-nota >= INPUT FRAME frame-b fi-dt-ini AND 
                           nota-fiscal.dt-emis-nota <= INPUT FRAME frame-b fi-dt-fim NO-LOCK.
   
    IF AVAILABLE nota-fiscal THEN DO:
       
        CREATE    tt-nota-fiscal.

            ASSIGN 
                tt-nota-fiscal.tt-cod-estabel   = nota-fiscal.cod-estabel
                tt-nota-fiscal.tt-nr-nota-fis   = nota-fiscal.nr-nota-fis
                tt-nota-fiscal.tt-cod-emitente  = nota-fiscal.cod-emitente
                tt-nota-fiscal.tt-nome-ab-cli   = nota-fiscal.nome-ab-cli
                tt-nota-fiscal.tt-estado        = nota-fiscal.estado
                tt-nota-fiscal.tt-cidade        = nota-fiscal.cidade
                tt-nota-fiscal.tt-nr-tabpre     = nota-fiscal.nr-tabpre
                tt-nota-fiscal.tt-cod-rep       = nota-fiscal.cod-rep
                tt-nota-fiscal.tt-no-ab-reppri  = nota-fiscal.no-ab-reppri.
     END.

           
RUN pi-acompanhar IN h-acomp (INPUT "Notas: " + string(tt-nota-fiscal.tt-nr-nota-fis)).

END.

RUN pi-finalizar IN h-acomp.

OPEN QUERY BROWSE-2 FOR EACH tt-nota-fiscal BY tt-cod-estabel BY tt-cod-emitente.
   
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

