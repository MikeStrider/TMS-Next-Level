<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WhatItIs.aspx.cs" Inherits="WhatItIs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

        <h2>What is TMS Next Level?</h2>

        <p>
            This website was created for carriers to record there loads and keep track of there trucks. This site containts a board with all available trucks from other drivers that use this software. You can download an Android app that tracks your drivers and allows drivers to set when they are available. Whis program allows 
            a carrier to invoice and email there customers. Allows a user to record driver pay, upload paperwork, and has a built in routing calculator. This website is free to use. Feel free to make an account however at this time I cannot promise your data will be saved since this site is a proof of concept.</p>
         <p>

 
<video width="1100" controls>
  <source src="Final3.mp4" type="video/mp4">
  Your browser does not support the video tags. We suggest you upgrade your browser.
</video>
             <br /> <br />

             <a href="LogInPage.aspx"> Back to Login</a></p>

    </div>
    </form>
</body>
</html>
