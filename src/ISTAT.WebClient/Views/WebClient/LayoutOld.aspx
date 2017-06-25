<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ViewMasterPage.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="ISTAT.WebClient.WidgetComplements.Model.App_GlobalResources" %>

<asp:Content ID="Headcontainer" ContentPlaceHolderID="ContentHeader" runat="server">
    <script src="<%=ResolveClientUrl("~/Scripts/istat-widget-manager.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/istat-widget-dataset.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/istat-client.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/pages/redirectLogin.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/pages/dashboardElements.js")%>"></script>
    
    <link href="<%=ResolveClientUrl("~/Content/style/widgets/Layout.css")%>" rel="stylesheet" />
    <script type="text/javascript">
        // redirect to login page if access denied
        if (sessionStorage.user_code == null) {
            window.location.href = "<%=ResolveClientUrl("~/")%>WebClient/Login";
        };
    </script>

</asp:Content>
   
<asp:Content ID="Maincontainer" ContentPlaceHolderID="MainContainer" runat="server">
    <h1><i class="icon-website"></i> <%=Messages.label_dashLayout %></h1>
    <!-- HTML Widget START -->
    <div id="DivContainer" class="optionContainer">
        <div class="subContainer">
            <div class="listOPT">
                <div class="check" id="id_view_tree"></div>
                <div class="check" id="id_view_tree_req"></div>
                <div class="check" id="id_more_ws"></div>
            </div>
            <div class="listWS" id="listWS">
                <div class="containerWS" id="containerWS"></div>
                <div class="addWS" id="addWS"></div>
            </div>
            <div class="clear-box"></div>
        </div>
    </div>
    <!-- HTML Widget END -->
</asp:Content>
<asp:Content ID="Footercontainer" ContentPlaceHolderID="ContentFooter" runat="server">
    <script type="text/javascript">
         
        var curIdxPaging = 0;
        var elemnPaging = <%=ConfigurationManager.AppSettings["ElementInList"].ToString() %>;
        //var elemnPaging = 100;
        var endpoints = [];

 
        function enable_HTTPAuthentication() {
            //alert($("#EnableHTTPAuthentication").prop("checked"));
            if ($("#EnableHTTPAuthentication").prop("checked")) {
                $("#Domain").removeAttr('disabled');
                $("#UserName").removeAttr('disabled');
                $("#Password").removeAttr('disabled');
            } else {
                $("#Domain").val("");
                $("#Domain").attr('disabled', 'disabled');

                $("#UserName").val("");
                $("#UserName").attr('disabled', 'disabled');

                $("#Password").val("");
                $("#Password").attr('disabled', 'disabled');
            }
            
        } 
        function enable_Proxy() {
            //alert($("#EnableProxy").prop("checked"));
            if ($("#EnableProxy").prop("checked")) {
                $("#UseSystemProxy").removeAttr('disabled');
                
                $("#ProxyServer").removeAttr('disabled');
                $("#ProxyServerPort").removeAttr('disabled');
                $("#ProxyUserName").removeAttr('disabled');
                $("#ProxyPassword").removeAttr('disabled');

            } else {

                $("#UseSystemProxy").removeAttr('checked');
                $("#UseSystemProxy").attr('disabled', 'disabled');

                $("#ProxyServer").val("");
                $("#ProxyServer").attr('disabled', 'disabled');

                $("#ProxyServerPort").val("");
                $("#ProxyServerPort").attr('disabled', 'disabled');

                $("#ProxyUserName").val("");
                $("#ProxyUserName").attr('disabled', 'disabled');

                $("#ProxyPassword").val("");
                $("#ProxyPassword").attr('disabled', 'disabled');
            }
        }
        function addWebServ() {
            var createWS = document.createElement("div");
            $(createWS).append("<div class='containerPop'>"+
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_idWS %><b>*</b></div><div class='divInp'><input class='inputPop' id='IDNode' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_titleWS %><b>*</b></div><div class='divInp'><input class='inputPop' id='Title' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointWS %><b>*</b></div><div class='divInp'><input class='inputPop' id='EndPoint' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointV20WS %><b>*</b></div><div class='divInp'><input class='inputPop' id='EndPointV20' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointTypeWS %><b>*</b></div><div class='divInp'><select id='EndPointType' class='inputPop' >"+
                                "<option value='V20'>V20</option>"+
                                "<option value='V21'>V21</option>"+
                                "<option value='REST'>REST</option>"+
                                "</select></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointSourceWS %><b>*</b></div><div class='divInp'><select id='EndPointSource' class='inputPop' >"+
                                "<option value='RI'>SDMX-RI</option>"+
                                "<option value='DOTSTAT'>.STAT</option>"+
                                "</select></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_separator_decimal %></div><div class='divInp'><select id='DecimalSeparator' class='inputPop' ><option value='.'>.</option><option value=','>,</option></select></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_enableHttpWS %></div><div class='divInp'><input class='inputPop' id='EnableHTTPAuthentication' type='checkbox' value='true' onclick='enable_HTTPAuthentication();'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_domainWS %></div><div class='divInp'><input disabled class='inputPop' id='Domain' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_UsernameWS %></div><div class='divInp'><input disabled class='inputPop' id='UserName' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_PasswordWS %></div><div class='divInp'><input disabled class='inputPop' id='Password' type='password'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_enablePoxyWS %></div><div class='divInp'><input class='inputPop' id='EnableProxy' type='checkbox' value='true' onclick='enable_Proxy();'/></div><div class='clear-box'></div></div>" +
                                
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_useSystemProxyWS %></div><div class='divInp'><input disabled class='inputPop' id='UseSystemProxy' type='checkbox' value='true'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyServerWS %></div><div class='divInp'><input disabled class='inputPop' id='ProxyServer' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyServerPortWS %></div><div class='divInp'><input disabled class='inputPop' id='ProxyServerPort' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyUsernameWS %></div><div class='divInp'><input disabled class='inputPop' id='ProxyUserName' type='text'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyPasswordWS %></div><div class='divInp'><input disabled class='inputPop' id='ProxyPassword' type='password'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop' style='display:none;'><div class='lab_inputPop'>Prefix</div><div class='divInp'><input class='inputPop' id='Prefix' type='text'/></div><div class='clear-box'></div></div>" +      
                                "<div class='div_inputPop' style='display:none;' ><div class='lab_inputPop'>Wsdl</div><div class='divInp'><input class='inputPop' id='Wsdl' type='text'/></div><div class='clear-box'></div></div>" +
                    
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_useUncategorysed %></div><div class='divInp'><input class='inputPop' id='UseUncategorysed' type='checkbox' value='true'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_useVirtualDF %></div><div class='divInp'><input class='inputPop' id='UseVirtualDf' type='checkbox' value='true'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'>ORDINAMENTO</div><div class='divInp'><input class='inputPop' id='Ordinamento' type='text'/></div><div class='clear-box'></div></div>" +      
                                "</div>");

            $(createWS).dialog({
                title: "<%=Messages.label_new_WS%>",
                resizable: true,
                width: $(window).width() - 20,
                position: { my: "center", at: "center", of: window },
                modal: true,
                buttons: {
                    '<%=Messages.label_save%>': function () {
                        
                        var v_id_node=$(createWS).find("#IDNode").val().trim();
                        var v_title = $(createWS).find("#Title").val().trim();
                        var v_endPoint = $(createWS).find("#EndPoint").val().trim();
                        var v_endPointV20 = $(createWS).find("#EndPointV20").val().trim();
                        var v_endPointType = $("#EndPointType").val();//$(createWS).find("#EndPointType").val().trim();
                        var v_endPointSource = $("#EndPointSource").val();
                        
                        var decimal = $("#DecimalSeparator").val();
                        checkLetter(v_id_node);
                        checkLetter(v_title);
                        checkLetter(v_endPoint);
                        checkLetter(v_endPointV20);
                        checkLetter(v_endPointType);
                        checkLetter(v_endPointSource);

                        if ((!( (checkLetter($(createWS).find("#IDNode").val()))
                            || (checkLetter($(createWS).find("#Title").val())) 
                            || (checkLetter($(createWS).find("#EndPoint").val())) 
                            || (checkLetter($(createWS).find("#EndPointV20").val())) 
                            || (checkLetter($(createWS).find("#Domain").val())) 
                            || (checkLetter($(createWS).find("#Password").val())) 
                            || (checkLetter($(createWS).find("#Prefix").val()))
                            || (checkLetter($(createWS).find("#ProxyPassword").val())) 
                            || (checkLetter($(createWS).find("#ProxyServer").val()))) 
                            || (checkLetter($(createWS).find("#ProxyUserName").val())) 
                            || (checkLetter($(createWS).find("#UserName").val())) 
                            || (checkLetter($(createWS).find("#Wsdl").val())))
                            && (v_title != "") 
                            && (v_endPoint != "") 
                            && (v_endPointV20 != "") 
                            && (v_endPointType != "")) {
                            
                            var b_UseUncategorysed=($(createWS).find("#UseUncategorysed").prop("checked")) ? true : false;
                            var b_UseVirtualDf=($(createWS).find("#UseVirtualDf").prop("checked")) ? true : false;

                            var b_EnableHTTPAuthentication = ($(createWS).find("#EnableHTTPAuthentication").prop("checked")) ? true : false;
                            var b_EnableProxy = ($(createWS).find("#EnableProxy").prop("checked")) ? true : false;
                            var b_UseSystemProxy = ($(createWS).find("#UseSystemProxy").prop("checked")) ? true : false;

                            var aus = $(createWS).find("#ProxyServerPort").val();
                            var b_ProxyServerPort = ($.isNumeric(aus)) ? parseInt(aus) : 0;
                            

                            var ws_obj = {
                                IDNode:$(createWS).find("#IDNode").val(),//"ID",
                                Title: $(createWS).find("#Title").val(),//"SEP",
                                EndPoint: $(createWS).find("#EndPoint").val(),//"http://sdmx.istat.it/WS_T/SdmxService",
                                EndPointV20: $(createWS).find("#EndPointV20").val(),//"http://sdmx.istat.it/WS_T/NSIStdV20Service",
                                EndPointType: v_endPointType,//"V21",
                                EndPointSource:v_endPointSource,
                                DecimalSeparator: decimal,//". or ,",
                                Domain: $(createWS).find("#Domain").val(),//"",
                                EnableHTTPAuthentication: b_EnableHTTPAuthentication,
                                EnableProxy: b_EnableProxy,
                                Password: $(createWS).find("#Password").val(),//"",
                                Prefix: $(createWS).find("#Prefix").val(),//"",
                                ProxyPassword: $(createWS).find("#ProxyPassword").val(),//"",
                                ProxyServer: $(createWS).find("#ProxyServer").val(),//"",
                                ProxyServerPort: b_ProxyServerPort,//80,
                                ProxyUserName: $(createWS).find("#ProxyUserName").val(),//"",
                                UseSystemProxy: b_UseSystemProxy,
                                UserName: $(createWS).find("#UserName").val(),//"",
                                Wsdl: $(createWS).find("#Wsdl").val(),//"",
                                Active: false,
                                UseUncategorysed: b_UseUncategorysed,
                                UseVirtualDf: b_UseVirtualDf,
                                //aggiunta fabio
                                Ordinamento: $(createWS).find("#Ordinamento").val()
                                //fine aggiunta
                            };
                            
                            var div3 = document.createElement('div');
                            $(div3).addClass('divInput');
                            var input = document.createElement('input');
                            $(input).attr('type', 'checkbox');
                            $(input).attr('name', ws_obj.EndPoint);
                            $(input).attr('value', clientParseObjectToJson(ws_obj));
                            $(input).attr('onclick', "saveAll();");
                            
                            if (ws_obj.Active)$(input).attr('checked', 'checked'); 

                            $(input).addClass('check_n');
                            $(input).appendTo(div3);

                            var div2 = document.createElement('div');
                            $(div2).addClass('divLabel');
                            $(div2).text(ws_obj.Title + " - " + ws_obj.EndPoint);
                            
                            var div = document.createElement('div');
                            $(div).addClass('ContWS');

                            var div4 = document.createElement('div');
                            $(div4).addClass('divButton');
                            var button = document.createElement('input');
                            $(button).attr('type', 'button');
                            $(button).attr('value', "<%=Messages.label_remove_query%>");
                            
                            $(button).addClass('RemoveWS');
                            $("<i class='icon-trash'></i>").appendTo(div4);
                            $(button).appendTo(div4);

                            //aggiunta fabio
                            var div5 = document.createElement('div');
                            $(div5).addClass('divLabel');
                            $(div5).text(ws_obj.Ordinamento);
                            //fine

                            $(div3).appendTo(div);
                            $(div2).appendTo(div);
                            $(div4).appendTo(div);

                            //aggiunta fabio
                            $(div5).appendTo(div);
                            //fine
                            $(div).appendTo("#containerWS");

                            var t = $(div3).parents('.ContWS');
                            
                            $(button).click(function(){alert(t);removeWS(t);});
                            
                            saveAll();

                            $(this).dialog('destroy').remove();
                            
                        }
                    },
                    '<%=Messages.label_cancel%>': function () {
                        $(this).dialog('destroy').remove();
                    }
                }
            });
        }

        function removeWS(objWSTitle) {

            var div_dialog = document.createElement("div");
            $(div_dialog).attr("title", '<%= Messages.form_Message%>');
            $(div_dialog).html("<p><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 20px 0;'></span><%= Messages.confRemWS%></p>");
            $(div_dialog).dialog({
                resizable: false,
                height: 140,
                position: { my: "center", at: "center", of: window },
                modal: true,
                buttons: {
                    '<%=Messages.label_save%>': function () {
                        $(this).dialog('destroy').remove();
                        
                        if ($(".check_n").length > 1) {
                            
                            $(objWSTitle).remove();
                            
                            saveAll();

                        } else {
                            var div_dialog = document.createElement("div");
                            $(div_dialog).attr("title", '<%= Messages.form_Message%>');
                            $(div_dialog).html("<p><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 20px 0;'></span><%= Messages.noRemWebService%></p>");
                            $(div_dialog).dialog({
                                resizable: false,
                                height: 140,
                                position: { my: "center", at: "center", of: window },
                                modal: true,
                                buttons: {
                                    'Ok': function () {
                                        $(this).dialog("close");
                                    }
                                }
                            });
                        }

                        
                    },
                    '<%=Messages.label_cancel%>': function () {
                        $(this).dialog('destroy').remove();
                    }
                }
            });

            
            
        }


        function modifyWS(objWS,objWSTitle) {
            //var t = $(objWS).parents('.ContWS');
            //alert(objWSTitle.EndPoint);
            var updateWS = document.createElement("div");
            $(updateWS).append("<div class='containerPop'>"+
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_idWS %><b>*</b></div><div class='divInp'>"+
                                    "<input class='inputPop' id='IDNode' type='text' value='"+objWS.IDNode+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_titleWS %><b>*</b></div><div class='divInp'>"+
                                    "<input class='inputPop' id='Title' type='text' value='"+objWS.Title+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointWS %><b>*</b></div><div class='divInp'>"+
                                    "<input class='inputPop' id='EndPoint' type='text' value='"+objWS.EndPoint+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointV20WS %><b>*</b></div><div class='divInp'>"+
                                    "<input class='inputPop' id='EndPointV20' type='text' value='"+objWS.EndPointV20+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointTypeWS %><b>*</b></div><div class='divInp'>"+
                                    "<select id='EndPointType' class='inputPop' >"+
                                    "<option value='V20' "+ (objWS.EndPointType=='V20'? "selected":"")+ ">V20</option>"+
                                    "<option value='V21' "+ (objWS.EndPointType=='V21'? "selected":"")+ ">V21</option>"+
                                    "<option value='REST' "+ (objWS.EndPointType=='REST'? "selected":"")+ ">REST</option>"+
                                    "</select></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_endPointSourceWS %><b>*</b></div><div class='divInp'>"+
                                    "<select id='EndPointSource' class='inputPop' >"+
                                    "<option value='RI' "+ (objWS.EndPointSource=='RI'? "selected":"")+ ">SDMX-RI</option>"+
                                    "<option value='DOTSTAT' "+ (objWS.EndPointSource=='DOTSTAT'? "selected":"")+ ">.STAT</option>"+
                                    "</select></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_separator_decimal %></div><div class='divInp'>"+
                                    "<select id='DecimalSeparator' class='inputPop' >"+
                                    "<option value='.' "+ (objWS.DecimalSeparator=='.'? "selected":"")+ ">.</option>"+
                                    "<option value=',' "+ (objWS.DecimalSeparator==','? "selected":"")+ ">,</option>"+
                                    "</select></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_enableHttpWS %></div><div class='divInp'>"+
                                    "<input class='inputPop' id='EnableHTTPAuthentication' type='checkbox' "+ (objWS.EnableHTTPAuthentication=='true'? "checked":"")+ " value='"+objWS.EnableHTTPAuthentication+"' onclick='enable_HTTPAuthentication();'/></div>"+
                                "<div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_domainWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='Domain' type='text'  value='"+objWS.Domain+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_UsernameWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='UserName' type='text' value='"+objWS.UserName+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_PasswordWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='Password' type='password' value='"+objWS.Password+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_enablePoxyWS %></div><div class='divInp'>"+
                                    "<input class='inputPop' id='EnableProxy' type='checkbox' value='"+objWS.EnableProxy+"' "+ (objWS.EnableProxy=='true'? "checked":"")+ " onclick='enable_Proxy();'/></div>"+
                                "<div class='clear-box'></div></div>" +                                
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_useSystemProxyWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='UseSystemProxy' type='checkbox' value='"+objWS.UseSystemProxy+"' "+ (objWS.UseSystemProxy=='true'? "checked":"")+ "/></div>"+
                                "<div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyServerWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='ProxyServer' type='text'  value='"+objWS.ProxyServer+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyServerPortWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='ProxyServerPort' type='text'  value='"+objWS.ProxyServerPort+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyUsernameWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='ProxyUserName' type='text' value='"+objWS.ProxyUserName+"'/></div><div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_proxyPasswordWS %></div><div class='divInp'>"+
                                    "<input disabled class='inputPop' id='ProxyPassword' type='password' value='"+objWS.ProxyPassword+"'/></div><div class='clear-box'></div></div>" + 

                                "<div class='div_inputPop' style='display:none;'><div class='lab_inputPop'>Prefix</div><div class='divInp'><input class='inputPop' id='Prefix' type='text'/></div><div class='clear-box'></div></div>" +      
                                "<div class='div_inputPop' style='display:none;' ><div class='lab_inputPop'>Wsdl</div><div class='divInp'><input class='inputPop' id='Wsdl' type='text'/></div><div class='clear-box'></div></div>" +
                                    
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_useUncategorysed %></div><div class='divInp'>"+
                                    "<input class='inputPop' id='UseUncategorysed' type='checkbox' value='"+objWS.UseUncategorysed+"'/></div>"+
                                "<div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'><%=Messages.label_useVirtualDF %></div><div class='divInp'>"+
                                "<input class='inputPop' id='UseVirtualDf' type='checkbox' value='"+objWS.UseVirtualDf+"'/></div>"+
                                "<div class='clear-box'></div></div>" +
                                "<div class='div_inputPop'><div class='lab_inputPop'>ORDINAMENTO</div><div class='divInp'>"+
                                "<input class='inputPop' id='Ordinamento' type='text'  value='"+objWS.Ordinamento+"'/></div>"+
                                "<div class='clear-box'></div></div>" +      
                                "</div>");

            $(updateWS).dialog({
                title: "<%=Messages.label_new_WS%>",
                resizable: true,
                width: $(window).width() - 20,
                position: { my: "center", at: "center", of: window },
                modal: true,
                buttons: {
                    '<%=Messages.label_save%>': function () {
                        
                        var v_id_node=$(updateWS).find("#IDNode").val().trim();
                        var v_title = $(updateWS).find("#Title").val().trim();
                        var v_endPoint = $(updateWS).find("#EndPoint").val().trim();
                        var v_endPointV20 = $(updateWS).find("#EndPointV20").val().trim();
                        var v_endPointType = $("#EndPointType").val();//$(createWS).find("#EndPointType").val().trim();
                        var v_endPointSource = $("#EndPointSource").val();
                        
                        var decimal = $("#DecimalSeparator").val();
                        checkLetter(v_id_node);
                        checkLetter(v_title);
                        checkLetter(v_endPoint);
                        checkLetter(v_endPointV20);
                        checkLetter(v_endPointType);
                        checkLetter(v_endPointSource);

                        if ((!( (checkLetter($(updateWS).find("#IDNode").val()))
                            || (checkLetter($(updateWS).find("#Title").val())) 
                            || (checkLetter($(updateWS).find("#EndPoint").val())) 
                            || (checkLetter($(updateWS).find("#EndPointV20").val())) 
                            || (checkLetter($(updateWS).find("#Domain").val())) 
                            || (checkLetter($(updateWS).find("#Password").val())) 
                            || (checkLetter($(updateWS).find("#Prefix").val()))
                            || (checkLetter($(updateWS).find("#ProxyPassword").val())) 
                            || (checkLetter($(updateWS).find("#ProxyServer").val()))) 
                            || (checkLetter($(updateWS).find("#ProxyUserName").val())) 
                            || (checkLetter($(updateWS).find("#UserName").val())) 
                            || (checkLetter($(updateWS).find("#Wsdl").val())))
                            && (v_title != "") 
                            && (v_endPoint != "") 
                            && (v_endPointV20 != "") 
                            && (v_endPointType != "")) {
                            
                            var b_UseUncategorysed=($(updateWS).find("#UseUncategorysed").prop("checked")) ? true : false;
                            var b_UseVirtualDf=($(updateWS).find("#UseVirtualDf").prop("checked")) ? true : false;

                            var b_EnableHTTPAuthentication = ($(updateWS).find("#EnableHTTPAuthentication").prop("checked")) ? true : false;
                            var b_EnableProxy = ($(updateWS).find("#EnableProxy").prop("checked")) ? true : false;
                            var b_UseSystemProxy = ($(updateWS).find("#UseSystemProxy").prop("checked")) ? true : false;

                            var aus = $(updateWS).find("#ProxyServerPort").val();
                            var b_ProxyServerPort = ($.isNumeric(aus)) ? parseInt(aus) : 0;
                            

                            var ws_obj = {
                                IDNode:$(updateWS).find("#IDNode").val(),//"ID",
                                Title: $(updateWS).find("#Title").val(),//"SEP",
                                EndPoint: $(updateWS).find("#EndPoint").val(),//"http://sdmx.istat.it/WS_T/SdmxService",
                                EndPointV20: $(updateWS).find("#EndPointV20").val(),//"http://sdmx.istat.it/WS_T/NSIStdV20Service",
                                EndPointType: v_endPointType,//"V21",
                                EndPointSource:v_endPointSource,
                                DecimalSeparator: decimal,//". or ,",
                                Domain: $(updateWS).find("#Domain").val(),//"",
                                EnableHTTPAuthentication: b_EnableHTTPAuthentication,
                                EnableProxy: b_EnableProxy,
                                Password: $(updateWS).find("#Password").val(),//"",
                                Prefix: $(updateWS).find("#Prefix").val(),//"",
                                ProxyPassword: $(updateWS).find("#ProxyPassword").val(),//"",
                                ProxyServer: $(updateWS).find("#ProxyServer").val(),//"",
                                ProxyServerPort: b_ProxyServerPort,//80,
                                ProxyUserName: $(updateWS).find("#ProxyUserName").val(),//"",
                                UseSystemProxy: b_UseSystemProxy,
                                UserName: $(updateWS).find("#UserName").val(),//"",
                                Wsdl: $(updateWS).find("#Wsdl").val(),//"",
                                Active: false,
                                UseUncategorysed: b_UseUncategorysed,
                                UseVirtualDf: b_UseVirtualDf,
                                //aggiunta fabio
                                Ordinamento: $(updateWS).find("#Ordinamento").val()
                                //fine aggiunta
                            };
                            
                            var div3 = document.createElement('div');
                            $(div3).addClass('divInput');
                            var input = document.createElement('input');
                            $(input).attr('type', 'checkbox');
                            $(input).attr('name', ws_obj.EndPoint);
                            $(input).attr('value', clientParseObjectToJson(ws_obj));
                            $(input).attr('onclick', "saveAll();");
                            
                            if (ws_obj.Active)$(input).attr('checked', 'checked'); 

                            $(input).addClass('check_n');
                            $(input).appendTo(div3);

                            var div2 = document.createElement('div');
                            $(div2).addClass('divLabel');
                            $(div2).text(ws_obj.Title + " - " + ws_obj.EndPoint);
                            
                            var div = document.createElement('div');
                            $(div).addClass('ContWS');

                            var div4 = document.createElement('div');
                            $(div4).addClass('divButton');
                            var button = document.createElement('input');
                            $(button).attr('type', 'button');
                            $(button).attr('value', "<%=Messages.label_remove_query%>");
                            
                            $(button).addClass('RemoveWS');
                            $("<i class='icon-trash'></i>").appendTo(div4);
                            $(button).appendTo(div4);

                            //aggiunta fabio
                            var div5 = document.createElement('div');
                            $(div5).addClass('divLabel');
                            $(div5).text(ws_obj.Ordinamento);
                            //fine

                            $(div3).appendTo(div);
                            $(div2).appendTo(div);
                            $(div4).appendTo(div);

                            //aggiunta fabio
                            $(div5).appendTo(div);
                            //fine
                            $(div).appendTo("#containerWS");

                            //var t = $(objWS).parents('.ContWS');
                            
                            $(button).click(function(){alert(t);removeWS(t);});

                            //$(this).parents('.ContWS'));
                            $(objWSTitle).remove();
                            saveAll();

                            $(this).dialog('destroy').remove();
                            
                        }
                    },
                    '<%=Messages.label_cancel%>': function () {
                        $(this).dialog('destroy').remove();
                    }
                }
            });
        }

        function saveAll(callBack) {
            var minSel = false;
            var listWS = [];

            //$(".check_n").each(function () {
            //modifica fabio make _index to Ordinamento
            $(".check_n").each(function (_index) {
                var _value_obj = clientParseJsonToObject(this.value);
                //aggiunta fabio
                //_value_obj.Ordinamento = _index;
                //fine aggiunta
                _value_obj.active = $(this).prop("checked");
                if (_value_obj.active) minSel = true;
                listWS.push(_value_obj);
            });
            if (minSel) {
                var _view_tree = ($("#view_tree").prop("checked")) ? "true" : "false";
                var _view_tree_req = ($("#view_tree_req").prop("checked")) ? "true" : "false";
                var _view_tree_select = ($("#more_ws").prop("checked")) ? "true" : "false";

                var data = {
                    settings: {
                        view_tree: _view_tree,
                        view_tree_req: _view_tree_req,
                        view_tree_select: _view_tree_select
                    },
                    endpoints: listWS
                };



                clientPostJSON(
                    "Settings/SetSettings", clientParseObjectToJson(data),
                    function (jsonString) {

                        DrawHTML_ListWsNEW("#containerWS");

                        if (callBack != undefined) callBack();
                    },
                    function (event, status, errorThrown) {
                        errorThrown = 'SetupJsonTree';
                        clientAjaxError(event, status, errorThrown);
                        return;
                    }, false);


            } else {
                var div_dialog = document.createElement("div");
                $(div_dialog).attr("title", '<%= Messages.form_Message%>');
                $(div_dialog).html("<p><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 20px 0;'></span><%= Messages.insertWebService%></p>");
                $(div_dialog).dialog({
                    resizable: false,
                    height: 140,
                    position: { my: "center", at: "center", of: window },
                    modal: true,
                    buttons: {
                        'Ok': function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }

            return minSel;

        }



        function saveAllDragDrop(callBack){
            var minSel = false;
            var listWS = [];

            //$(".check_n").each(function () {
            //modifica fabio make _index to Ordinamento
            $(".check_n").each(function (_index) {
                var _value_obj = clientParseJsonToObject(this.value);
                //aggiunta fabio
                _value_obj.Ordinamento=_index;
                //fine aggiunta
                _value_obj.active = $(this).prop("checked");
                if (_value_obj.active) minSel = true;
                listWS.push(_value_obj);
            });
            if (minSel) {
                var _view_tree = ($("#view_tree").prop("checked")) ? "true" : "false";
                var _view_tree_req = ($("#view_tree_req").prop("checked")) ? "true" : "false";
                var _view_tree_select = ($("#more_ws").prop("checked")) ? "true" : "false";

                var data = {
                    settings: {
                        view_tree: _view_tree,
                        view_tree_req: _view_tree_req,
                        view_tree_select: _view_tree_select
                    },
                    endpoints: listWS
                };

                

                clientPostJSON(
                    "Settings/SetSettings", clientParseObjectToJson(data),
                    function (jsonString) {

                        DrawHTML_ListWsNEW("#containerWS");

                        if (callBack != undefined) callBack();
                    },
                    function (event, status, errorThrown) {
                        errorThrown = 'SetupJsonTree';
                        clientAjaxError(event, status, errorThrown);
                        return;
                    }, false);


            } else {
                var div_dialog = document.createElement("div");
                $(div_dialog).attr("title", '<%= Messages.form_Message%>');
                $(div_dialog).html("<p><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 20px 0;'></span><%= Messages.insertWebService%></p>");
                $(div_dialog).dialog({
                    resizable: false,
                    height: 140,
                    position: { my: "center", at: "center", of: window },
                    modal: true,
                    buttons: {
                        'Ok': function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }

            return minSel;

        }
        
        

        function DrawHTML_ListWs(dest) {
            $(dest).empty();
            $(dest).append("<i class='icon-spin6 animate-spin'></i>"+client.main.messages.text_wait);
            var list_container=document.createElement("div");
            clientPostJSON(
                    "Settings/GetSettings", null,
                    function (jsonString) {
                        
                        var _sett_obj = clientParseJsonToObject(jsonString);
                        if (_sett_obj != "") {

                            var div_pag = DrawHTML_Pagging(
                                curIdxPaging,
                                _sett_obj.endpoints.length,
                                elemnPaging,
                                function (idx) {
                                    curIdxPaging = idx;
                                    DrawHTML_ListWs("#containerWS");
                                }
                            );
                            
                            $(div_pag).appendTo(list_container);
                            $(div_pag).buttonset();
                           
                            var pagFrom = (curIdxPaging * elemnPaging);
                            var pagTo = pagFrom + elemnPaging;
                            var idxPag = -1;
                            //alert("curIdxPaging: " + curIdxPaging+"pagFrom: " + pagFrom+"pagTo: " + pagTo);
                            endpoints = _sett_obj.endpoints;

                            var WS_no_view = true;

                            $.each(endpoints, function (index, value) {
                                var hideDiv = false;
                                idxPag++;
                                if (idxPag < pagFrom || idxPag > (pagTo - 1)) {
                                    hideDiv = true;
                                    //alert("check");
                                } else {
                                    WS_no_view = false;
                                }
                                var div3 = document.createElement('div');
                                $(div3).addClass('divInput');

                                var input = document.createElement('input');
                                $(input).attr('type', 'checkbox');
                                $(input).attr('name', value.EndPoint);
                                $(input).attr('value', clientParseObjectToJson(value));

                                if (value.Active == true) $(input).attr('checked', 'checked');

                                $(input).attr('onclick', "saveAll();");
                                $(input).addClass('check_n');
                                $(input).appendTo(div3);

                                var div2 = document.createElement('div');
                                $(div2).addClass('divLabel');
                                $(div2).text(value.Title + " - " + value.EndPoint);



                                var div4 = document.createElement('div');
                                $(div4).addClass('divButton');

                                var button = document.createElement('input');
                                $(button).attr('type', 'button');
                                $(button).attr('value', "<%= Messages.label_remove_query%>");

                                $(button).addClass('RemoveWS');
                                $("<i class='icon-trash'></i>").appendTo(div4);
                                $(button).appendTo(div4);
                                $(button).click(function () { removeWS($(this).parents('.ContWS')); });

                                var div = document.createElement('div');

                                var idTit = value.Title.replace(/ /g, '_');

                                $(div3).appendTo(div);
                                $(div2).appendTo(div);
                                $(div4).appendTo(div);
                                $("<div class='clear-box'></div>").appendTo(div);
                                $(div).addClass('ContWS');

                                $(div).appendTo(list_container);

                                if (hideDiv) {
                                    $(div).hide();
                                    //alert("nascondi");
                                }
                                
                            });

                            if (WS_no_view == true) {
                                $('#btn_pag0').click();
                            }
                        }

                    $("#addWS").empty();
                    $("#id_view_tree").empty();
                    $("#id_view_tree_req").empty();
                    $("#id_more_ws").empty();
                    $("#id_view_uncategorised").empty();
                    $("#addWS").append('<input id="add_wbs" class="mainButtons" type="button" value="<%= Messages.label_addWebService%>" onclick="addWebServ();"/>');
                    $("#id_view_tree").append('<input id="view_tree" type="checkbox" ' + (((_sett_obj != "") ? _sett_obj.settings.view_tree == true : false) ? 'checked="checked"' : '') + ' name="view_tree" onclick="saveAll();"/><i class="icon-flow-cascade"></i><label><%= Messages.label_tree_display%></label>');
                    $("#id_view_tree_req").append('<input id="view_tree_req" type="checkbox" ' + (((_sett_obj != "") ? _sett_obj.settings.view_tree_req == true : false) ? 'checked="checked"' : '') + ' name="view_tree_req" onclick="saveAll();"/><i class="icon-flow-cascade"></i><label><%= Messages.label_tree_display_request%></label>');
                    $("#id_more_ws").append('<input id="more_ws" type="checkbox" ' + (((_sett_obj != "") ? _sett_obj.settings.view_tree_select == true : false) ? 'checked="checked"' : '') + ' name="more_ws" onclick="saveAll();"/><i class="icon-table"></i><label><%= Messages.label_more_web_services%></label>');
                    
                    $(".mainButtons").button();
                        
                    $(dest).empty();
                    $(list_container).appendTo(dest);

                },
                function (event, status, errorThrown) {
                    errorThrown = 'SetupJsonTree';
                    clientAjaxError(event, status, errorThrown);
                    return;
                }, false);
        }


        //nuova funzione fabio 
        function DrawHTML_ListWsNEW(dest) {
            $(dest).empty();
            $(dest).append("<i class='icon-spin6 animate-spin'></i>"+client.main.messages.text_wait);
            var list_container=document.createElement("div");

            var ul=document.createElement("ul");
            $(ul).attr('id', "listWS");
            $(ul).css("list-style-type", "none"); 
            $(ul).appendTo(list_container);
            
            
            clientPostJSON(
                    "Settings/GetSettings", null,
                    function (jsonString) {
                        
                        var _sett_obj = clientParseJsonToObject(jsonString);
                        if (_sett_obj != "") {

                            var div_pag = DrawHTML_Pagging(
                                curIdxPaging,
                                _sett_obj.endpoints.length,
                                elemnPaging,
                                function (idx) {
                                    curIdxPaging = idx;
                                    DrawHTML_ListWsNEW("#containerWS");
                                }
                            );
                            
                            $(div_pag).appendTo(list_container);
                            $(div_pag).buttonset();
                           
                            var pagFrom = (curIdxPaging * elemnPaging);
                            var pagTo = pagFrom + elemnPaging;
                            var idxPag = -1;
                            //alert("curIdxPaging: " + curIdxPaging+"pagFrom: " + pagFrom+"pagTo: " + pagTo);
                            endpoints= _sett_obj.endpoints;

                            //aggiunta fabio
                            endpoints.sort(function(obj1, obj2) {
                                // Ascending: sort by Ordinamento
                                return obj1.Ordinamento - obj2.Ordinamento;
                            });
                            //fine aggiunta 

                            var WS_no_view = true;

                            $.each(endpoints, function (index, value) {
                                var hideDiv = false;
                                idxPag++;
                                if (idxPag < pagFrom || idxPag > (pagTo - 1)) {
                                    hideDiv = true;
                                    //alert("check");
                                } else {
                                    WS_no_view = false;
                                }
                                var div3 = document.createElement('div');
                                $(div3).addClass('divInput');

                                //ripristino l'ordinamento secondo l'index degli oggetti
                                value.Ordinamento=index;


                                var input = document.createElement('input');
                                $(input).attr('type', 'checkbox');
                                $(input).attr('name', value.EndPoint);
                                $(input).attr('value', clientParseObjectToJson(value));

                                if (value.Active == true) $(input).attr('checked', 'checked');

                                $(input).attr('onclick', "saveAll();");
                                $(input).addClass('check_n');
                                $(input).appendTo(div3);

                                var div2 = document.createElement('div');
                                $(div2).addClass('divLabel');
                                //$(div2).text(value.Title + " - " + value.EndPoint);
                                $(div2).text(value.Title + " - " + value.EndPoint + " - " + value.Ordinamento);


                                var div4 = document.createElement('div');
                                $(div4).addClass('divButton');

                                var button = document.createElement('input');
                                $(button).attr('type', 'button');
                                $(button).attr('value', "<%= Messages.label_remove_query%>");

                                $(button).addClass('RemoveWS');
                                $("<i class='icon-trash'></i>").appendTo(div4);
                                $(button).appendTo(div4);
                                $(button).click(function () { removeWS($(this).parents('.ContWS')); });

                                var div5 = document.createElement('div');
                                $(div5).addClass('divButton');

                                var button = document.createElement('input');
                                $(button).attr('type', 'button');
                                $(button).attr('value', "<%= Messages.label_modify_query%>");

                                $(button).addClass('RemoveWS');
                                $("<i class=' icon-pencil-4'></i>").appendTo(div5);
                                $(button).appendTo(div5);
                                $(button).click(function () { modifyWS(value,$(this).parents('.ContWS')); });


                                var li = document.createElement('li');

                                var idTit = value.Title.replace(/ /g, '_');

                                $(div3).appendTo(li);
                                $(div2).appendTo(li);
                                $(div4).appendTo(li);
                                $(div5).appendTo(li);
                                $("<div class='clear-box'></div>").appendTo(li);
                                $(li).addClass('ContWS');

                                $(li).appendTo(ul);

                                if (hideDiv) {
                                    $(li).hide();
                                }
                                
                            });

                            if (WS_no_view == true) {
                                $('#btn_pag0').click();
                            }
                        }

                        $("#addWS").empty();
                        $("#id_view_tree").empty();
                        $("#id_view_tree_req").empty();
                        $("#id_more_ws").empty();
                        $("#id_view_uncategorised").empty();
                        $("#addWS").append('<input id="add_wbs" class="mainButtons" type="button" value="<%= Messages.label_addWebService%>" onclick="addWebServ();"/>');
                    $("#id_view_tree").append('<input id="view_tree" type="checkbox" ' + (((_sett_obj != "") ? _sett_obj.settings.view_tree == true : false) ? 'checked="checked"' : '') + ' name="view_tree" onclick="saveAll();"/><i class="icon-flow-cascade"></i><label><%= Messages.label_tree_display%></label>');
                        $("#id_view_tree_req").append('<input id="view_tree_req" type="checkbox" ' + (((_sett_obj != "") ? _sett_obj.settings.view_tree_req == true : false) ? 'checked="checked"' : '') + ' name="view_tree_req" onclick="saveAll();"/><i class="icon-flow-cascade"></i><label><%= Messages.label_tree_display_request%></label>');
                        $("#id_more_ws").append('<input id="more_ws" type="checkbox" ' + (((_sett_obj != "") ? _sett_obj.settings.view_tree_select == true : false) ? 'checked="checked"' : '') + ' name="more_ws" onclick="saveAll();"/><i class="icon-table"></i><label><%= Messages.label_more_web_services%></label>');
                    
                        $(".mainButtons").button();
                        
                        $(dest).empty();
                        $(list_container).appendTo(dest);

                    },
                function (event, status, errorThrown) {
                    errorThrown = 'SetupJsonTree';
                    clientAjaxError(event, status, errorThrown);
                    return;
                }, false);
        }




        jQuery(document).ready(function () {
            DrawHTML_ListWsNEW("#containerWS");
            
            //aggiunta fabio
            $('#listWS').sortable({
                items: "> li",
                start: function (e, ui) {
                    ui.placeholder.height(ui.item.children().height());
                },
                stop: function(event, ui) {
                    saveAllDragDrop();
                }
            });
            //fine aggiunta
        });

    </script>
</asp:Content>