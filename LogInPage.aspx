<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogInPage.aspx.cs" Inherits="LogInPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TMS Next Level</title>
  <meta charset="UTF-8">
  <meta name="google-site-verification" content="gO-4UXqU6nOXghxZSiqbRtFaU3UY5aqez0xwVL4pU3g" />
  <meta name="description" content="TMS Next Level is a brand new Transportation Management software for small business designed by Michael Strong. You can record your loads, keep track of your fleet using the mobile app, and so much more.">
  <meta name="keywords" content="Michael Strong, Windsor, Transportation Management, TMS, TMS Next Level">
  <meta name="author" content="Michael Strong">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1 {
            width: 50px;
            height: 52px;
        }
        .auto-style2 {
            width: 235px;
            height: 72px;
        }
    </style>
    </head>
<body>
    <div style="padding: 12px">
        <form id="form1" runat="server">
            <table width="100%">
                <tr>
                    <td width="300">
                        <img src="Images/logo.png" style="width: 100%; height: auto;">
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
            <br />

                <div style="padding:4px;font-size:large"><u>Carrier Login</u></div>
                <div style="padding:2px">Company ID: <asp:TextBox ID="TextBox2" runat="server" TabIndex="1"></asp:TextBox></div>
                <div style="padding:2px">Password: <asp:TextBox ID="TextBox3" TextMode="Password" runat="server" Width="163px" TabIndex="2"></asp:TextBox></div>
                <div style="padding:2px">User ID: <asp:TextBox ID="TextBox1" runat="server" Width="204px" TabIndex="3"></asp:TextBox></div>
                <div style="padding:2px">&nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Log In" Width="87px" TabIndex="4" /></div>
                &nbsp;<asp:Label ID="lblvalidation" runat="server" Font-Bold="True" ForeColor="Red" Visible="False" EnableViewState="False"></asp:Label>

                <div style="padding:4px;font-size:large"><u>Driver Login</u></div>
                <div style="padding:2px">User ID: <asp:TextBox ID="TextBox4" runat="server" TabIndex="5"></asp:TextBox></div>
                <div style="padding:2px">Password: <asp:TextBox ID="TextBox5" runat="server" Width="163px" TextMode="Password" TabIndex="6"></asp:TextBox></div>
                <div style="padding:2px">&nbsp;<asp:Button ID="Button2" runat="server" Text="Go" Width="79px" OnClick="Button2_Click" TabIndex="7" /></div>
            &nbsp;<asp:Label ID="lblvalidation2" runat="server" Font-Bold="True" ForeColor="Red" Visible="False" EnableViewState="False">invalid login, please try again, or call TMS - Next Level for support</asp:Label>
            </p>
             <p>
                <table>
                    <tr>
                        <td>
                            <a href="WhatItIs.aspx">What is TMS Next Level?</a><br />
                            <br />
                            <a href="NewDriver.aspx"> Create a New Driver Account</a><br />
                            <br />
                            <a href="AddCarrier.aspx"> Create a New Carrier Account</a><br />
                        </td>
                        <td></td>
                        <td>
                            <a href="https://mikestrong7.wixsite.com/about">Learn About the Author</a>
                            <br />
                            <img alt="" class="auto-style2" src="Images/meSite.png" /></td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td></td>
                        <td>
                            &nbsp;</td>
                    </tr>
                        <td>
                             Demo Carrier Account = 20045 / mikemiker Account = 20045 / mikemike<br />
                        </td>
                        <td width="50"></td>
                        <td valign="top"> Demo Driver Account = mstrong / mikemike</td>
                    </tr>
                    <tr><td> </td></tr>
                        <table>
                            <td>
                            <a href="TMS_Next_Level_v28.zip"><img alt="" class="auto-style1" src="Images/3.png" /></a>
                                </td>
                            <td colspan=3>&nbsp; Download the Mobile App. This app does tracking and allows drivers to take themselves in/out of service.</td>
                        </table>
                    </tr>
            </table>
            <p>
                

            <script type="text/javascript">

                function HideLabel() {
                    var seconds = 3;
                    setTimeout(function () {
                        document.getElementById("<%=lblvalidation.ClientID %>").style.display = "none";
                    }, seconds * 1000);
                };

                function HideLabel2() {
                    var seconds = 3;
                    setTimeout(function () {
                        document.getElementById("<%=lblvalidation2.ClientID %>").style.display = "none";
                    }, seconds * 1000);
                };

            </script>
    </form>
</body>

     <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</html>
