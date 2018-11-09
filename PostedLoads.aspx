<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostedLoads.aspx.cs" Inherits="PostedLoads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        td, th {
            padding: 5px;
        }

        table#DataList1 td{
            padding: 0px;
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
    </div>

    <div id="nav-placeholder"></div>

    <div style="padding-left: 12px">
        <h2 style="padding-bottom: 4px">Posted Loads</h2>

            <asp:CheckBox ID="CheckBox1" runat="server" Text="&nbsp;PickUp Location - " AutoPostBack="false" OnCheckedChanged="CheckBox1_CheckedChanged" />
            <asp:TextBox ID="txtmiles" runat="server" Width="58px"></asp:TextBox>
            &nbsp;kilometers from
            <asp:TextBox ID="txtlocation" runat="server" Width="247px"></asp:TextBox>
            &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Filter" ViewStateMode="Disabled" /> <br /> <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
                SelectCommand="SELECT companyinfo.email, companyinfo.phonenumber, companyinfo.compid, companyinfo.name, orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.compid AS Expr1 FROM companyinfo INNER JOIN orders ON companyinfo.compid = orders.compid WHERE (orders.Posted = 1)">
            </asp:SqlDataSource>
                                      <div id="dontPad">
            <asp:DataList ID="DataList1" runat="server" DataKeyField="compid" DataSourceID="SqlDataSource2" BorderColor="Black" 
                BorderWidth="1px" CellSpacing="1" OnItemDataBound="DataList1_ItemDataBound" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">

            <HeaderStyle BackColor="#507CD1" ForeColor="White" />
            <HeaderTemplate>
                 <table border="1" width="100%">
                    <td width="230px">
                        Carrier's Name
                    </td>
                    <td width="100px">
                        Order Number
                    </td>
                    <td width="270px">Pick Up Location <br />
                        Pick Up Date and Time
                    </td>
                    <td width="270px">
                        Drop Off Location <br />
                        Drop Off Date and Time
                    </td>
                     <td width="200px">
                         Contact Info
                     </td>
                     <td>
                         Distance to <br /> PickUp
                     </td>
                </table>
            </HeaderTemplate>

            <ItemTemplate>

                <table border="1" id="TR2" width="100%" runat="server">
                    <tr>
                    <td width="230px" style="padding: 3px;">
                        <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                    </td>
                    <td width="100px">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>' />
                    </td>
                    <td width="270px" style="padding-left: 3px;">
                        <asp:Label ID="pickuplocationLabel" runat="server" Text='<%# Eval("pickuplocation") %>' /> <br />
                        <asp:Label ID="pickupdateandtimeLabel" runat="server" Text='<%# Eval("pickupdateandtime") %>' />
                    </td>
                    <td width="270px" style="padding-left: 3px;">
                        <asp:Label ID="dropofflocationLabel" runat="server" Text='<%# Eval("dropofflocation") %>' /> <br />
                        <asp:Label ID="dropoffdateandtimeLabel" runat="server" Text='<%# Eval("dropoffdateandtime") %>' />
                    </td>
                    <td width="200px" style="padding-left: 3px;">
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("email") %>' /> <br />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("phonenumber") %>' />
                    </td>
                    <td style="padding-left: 3px; padding-right: 3px;">
                        <asp:Label ID="Label5" runat="server" Text="--"></asp:Label>
                    </td>
                    </tr>
                </table>

            </ItemTemplate>
        </asp:DataList>
                                               
        <div style="max-width: 1200px; text-align:right; padding:7px" >
            <asp:Label ID="txtcount2" runat="server" Text="Label"></asp:Label> <br />
            <asp:Label ID="txtcount" runat="server" Text="Label"></asp:Label>
        </div>
     </div>
       
                     
        <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
                    SelectCommand="SELECT COUNT(orders.id) AS Expr1 FROM companyinfo INNER JOIN orders ON companyinfo.compid = orders.compid WHERE (orders.Posted = 1)">
                </asp:SqlDataSource>


    </div>

    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $("#nav-placeholder").load("navpage.html");
        });
    </script>
</body>
</html>
