<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testing.aspx.cs" Inherits="testing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-decoration: underline;
        }
    </style>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid rgb(80, 124, 209);
            width: 200px;
            height: 130px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }
    </style>
</head>
<body style="padding: 12px">
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


            <h3>Admin Functions</h3>
                                / <a href="OrdersPage.aspx">Orders Page </a> / <a href="HangFire">HangFire Dashboard</a> / <a href="Processor.aspx">Processor</a> / <a href="WebForm1.aspx">HangFire Testing</a><br /> <br />
            <asp:button id="Button2" runat="server" onclick="Button2_Click" text="Get Total Number of Orders" width="186px" />
            &nbsp;<asp:label id="Label1" runat="server"></asp:label>
            <br />

            <br />
            <b>Undo Posted</b> - Use when Invoice Posted, Invoice Paid, and Driver Pay Posted is set to y. This will not remove from export file. -- Order Number
            <asp:textbox id="TextBox5" runat="server"></asp:textbox>
            &nbsp;<asp:button id="Button4" runat="server" text="Submit" onclick="Button4_Click" width="90px" />
            &nbsp;<asp:label id="Label3" runat="server"></asp:label>
            <br />
            <br />
            <strong>Set Order back to Available</strong> - Deletes billing info and dispatch info. -- Order Number
            <asp:textbox id="TextBox6" runat="server"></asp:textbox>
            &nbsp;<asp:button id="Button5" runat="server" onclick="Button5_Click" text="Submit" width="90px" />
            &nbsp;<asp:label id="Label4" runat="server"></asp:label>
            <br />
            <br />
            <strong>Send Test Email</strong> -
            To
            <asp:textbox id="txtTo" runat="server">mike.strong@live.ca</asp:textbox>
            Subject
            <asp:textbox id="txtSubject" runat="server"></asp:textbox>
            Body
            <asp:textbox id="txtBody" runat="server" textmode="MultiLine" height="16px" width="269px"></asp:textbox>
            File Upload
            <asp:fileupload id="fuAttachment" runat="server" />
            From
            <asp:textbox id="txtEmail" runat="server">mike.strong28@gmail.com</asp:textbox>
            From password
            <asp:textbox id="txtPassword" runat="server" textmode="Password">jonesjones1</asp:textbox>
            &nbsp;<asp:button id="Button6" runat="server" onclick="Button6_Click" text="Submit" width="90px" />
            <br />
            <br />
            <br />
            <table>
                <tr>
                    <td>
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="DataSource_Drivers" AutoGenerateColumns="False">
                        <Columns>
                        <asp:BoundField DataField="userid" HeaderText="userid" SortExpression="userid" />
                        <asp:BoundField DataField="companyname" HeaderText="companyname" SortExpression="companyname" />
                        <asp:BoundField DataField="fullname" HeaderText="fullname" SortExpression="fullname" />
                        </Columns>
                        </asp:GridView>
                    </td>
                    <td width="30px"></td>
                    <td>
                        <asp:SqlDataSource ID="DataSource_Drivers" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT [userid], [companyname], [fullname] FROM [driverinfo]"></asp:SqlDataSource>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="compid" DataSourceID="DataSource_Carriers">
                        <Columns>
                        <asp:BoundField DataField="compid" HeaderText="compid" ReadOnly="True" SortExpression="compid" />
                        <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                        </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>



            <asp:SqlDataSource ID="DataSource_Carriers" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
                SelectCommand="SELECT [compid], [name] FROM [companyinfo]"></asp:SqlDataSource>
            <br />
            &nbsp;<asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Simulate Loading" />
            <br />
            <br />
            <a href="ftp://mikestrider.square7.ch/">ftp://mikestrider.square7.ch/</a> .. user name: mikestrider ... password: mikemike<br />
            <br />
            <asp:Button ID="Button8" runat="server" OnClick="Button8_Click" Text="Send EDI" />
            &nbsp;.. add text to EDI
            file then upload.. filename will be date and time.txt<br />
&nbsp;<asp:TextBox ID="TextBox7" runat="server" Height="60px" TextMode="MultiLine" Width="600px" OnTextChanged="TextBox7_TextChanged"></asp:TextBox>
            &nbsp;<br />
            <br />
            <br />
            <asp:Button ID="Button9" runat="server" OnClick="Button9_Click" Text="Read from FTP" style="height: 26px" />
            &nbsp;Reads all files on the FTP and tries to insert them as Orders
            <br />
            &nbsp;<asp:TextBox ID="TextBox8" runat="server" Height="60px" TextMode="MultiLine" Width="600px"></asp:TextBox>
            <br />
            <br />
            <br />
            <span class="auto-style1"><strong>Common Issues</strong></span><br />
            Routing Calculator and View on Map require Pop Up blocker to be turned off.<br />
            <br />
            <br />
            <br />
            <br />

                <div class="loading" align="center" ><br />
                    Loading. Please wait.<br />
                    <br />
                    <img src="loading3.gif" alt="" />
                </div>

                <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
                <script type="text/javascript">
                    function ShowProgress() {
                        setTimeout(function () {
                            var modal = $('<div />');
                            modal.addClass("modal");
                            $('body').append(modal);
                            var loading = $(".loading");
                            loading.show();
                            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                            loading.css({ top: top, left: left });
                        }, 200);
                    }
                    $('form').live("submit", function () {
                        ShowProgress();
                    });
                </script>
      </form>
      <br />
      <br />

</body>
</html>
