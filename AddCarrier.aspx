<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddCarrier.aspx.cs" Inherits="AddCarrier" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
	<script type="text/javascript" src="fancybox/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<script type="text/javascript" src="fancybox/fancybox/jquery.fancybox-1.3.4.js"></script>
	<link rel="stylesheet" type="text/css" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
 	<link rel="stylesheet" href="style.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".fancy").fancybox({
                onClosed: function () {
                    window.location.href = "worker_addcarrier.aspx?name=" + document.getElementById('<%=txt_carriername.ClientID%>').value +
                        "&password=" + document.getElementById('<%=txt_password.ClientID%>').value +
                        "&email=" + document.getElementById('<%=txt_email.ClientID%>').value +
                        "&extrafield=" + document.getElementById('<%=txt_masterpass.ClientID%>').value;
                }
            });
        });
    </script>
</head>
<body style="padding: 4px">
    <form id="form1" runat="server">
        <div>
            <table width="100%">
                <tr>
                    <td width="400">
                        <img src="Images/logo.png" style=" width:70%;  height:auto;">
                    </td>
                    <td>
                        <center>logged in as:
                        <asp:Label ID="lblusername" runat="server"></asp:Label> <br />
                            company id:
                        <asp:Label ID="lblcompid" runat="server"></asp:Label>
                        </center>
                    </td>
                    <td align="right">ASP.NET and MS SQL<br />
                        <i>proof of concept - </i>
                        <asp:LinkButton ID="LinkButton_signout" runat="server" OnClick="LinkButton1_Click">sign out</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <h3>Add New Carrier</h3>

            <p>
                Carrier Name :
                <asp:TextBox ID="txt_carriername" runat="server" Width="280px"></asp:TextBox>
            </p>
            <p>
                Password :
                <asp:TextBox ID="txt_password" runat="server" Width="280px" TextMode="Password"></asp:TextBox>
            </p>
            <p>
                Admin&#39;s E-mail Address
                <asp:TextBox ID="txt_email" runat="server" OnTextChanged="TextBox4_TextChanged" Width="280px"></asp:TextBox>
            &nbsp;(important information will be emailed to you)</p>
            <p>
                Master Password, Needed to Create a New Account
                <asp:TextBox ID="txt_masterpass" runat="server" Width="280px" TextMode="Password"></asp:TextBox>
            &nbsp;(current master password is sl@ve since the service is in Beta)</p>
            <p>
                <asp:Button ID="Button1" href="Images/accountcreated.png" runat="server" class="fancy" title="Your Company ID has been emailed to you."
                    Text="Create" Width="109px" OnClick="Button1_Click" ViewStateMode="Enabled" />

                &nbsp;</p>

        </div>
    </form>
</body>
</html>
