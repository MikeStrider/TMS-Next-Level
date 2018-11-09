<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AvailableTrucks.aspx.cs" Inherits="AvailableTrucks" %>

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
        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}
        .auto-style1 {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div style="padding: 12px">

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

            <div runat="server" id="mytitle">  <%--hide title when driver--%>
                <div id="nav-placeholder"></div>
            </div>

            <div style="padding-left: 12px">
                <h2 style="padding-bottom: 4px">Independent Drivers</h2>

                <asp:DataList ID="DataList1" runat="server" DataKeyField="Id" DataSourceID="SqlDataSource1" BorderColor="Black" BorderWidth="1px" CellSpacing="1">
                    <HeaderStyle BackColor="#507CD1" ForeColor="White" />
                    <HeaderTemplate>
                        <table border="1">
                            <tr>
                                <td style="width:225px;">
                                    Driver Name <br />
                                    Company Name
                                </td>
                                <td style="width:225px;">
                                    Truck Number<br />
                                    Truck Type<br />
                                    Length x Width x Height
                                </td>
                                <td style="width:225px;">
                                    Location<br />
                                    Date Updated
                                </td>
                                <td style="width:225px;">
                                    Average Rating <br />
                                    Comments
                                </td>
                                <td style="width:225px;">
                                    Email<br />
                                    Phone Number
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table  border="1">
                            <tr>
                                <td style="width:225px;">
                                    <asp:Label ID="fullnameLabel" runat="server" Text='<%# Eval("fullname") %>' /><br />
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("companyname") %>' />
                                </td>
                                <td style="width:225px;">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("truckno") %>' /><br />
                                    <asp:Label ID="trucktypeLabel" runat="server" Text='<%# Eval("trucktype") %>' /><br />
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("lxwxh") %>' />
                                </td>
                                <td style="width:225px;">
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("location") %>' /><br />
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("date") %>' />
                                </td>
                                <td style="width:225px;">
                                    <asp:Label ID="ratingLabel" runat="server" Text='<%# Eval("AverageRating") %>' /><br />
                                    <asp:Label ID="commentsLabel" runat="server" Text='<%# Eval("comments") %>' />
                                </td>
                                <td style="width:225px;">
                                    <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' /><br />
                                    <asp:Label ID="phonenoLabel" runat="server" Text='<%# Eval("phoneno") %>' />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                <br />                
                <span class="auto-style1">help - how this page works</span><br />
                Drivers will update there position and availability from the mobile app.  Give them a call if you have a load for them.


                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT DISTINCT driverinfo.userid, driverinfo.fullname, driverinfo.companyname, driverinfo.truckno, driverinfo.location, driverinfo.date, driverinfo.trucktype, driverinfo.lxwxh, driverinfo.email, driverinfo.phoneno, driverinfo.comments, (SELECT AVG(rating) AS Expr1 FROM rating WHERE (driverinfo.userid = ratingto)) AS AverageRating, driverinfo.Id FROM driverinfo LEFT OUTER JOIN rating AS rating_1 ON driverinfo.userid = rating_1.ratingto WHERE (driverinfo.available = '1')"></asp:SqlDataSource>
        </div>
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $("#nav-placeholder").load("navpage.html");
        });
    </script>
    <br /><br /><br /><br /><br /><br />
</body>
</html>
