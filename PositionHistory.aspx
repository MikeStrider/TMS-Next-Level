<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PositionHistory.aspx.cs" Inherits="PositionHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="StyleSheet.css" type="text/css" />
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".frank").dynDateTime({
                showsTime: true,
                ifFormat: "%m/%d/%Y %H:%M",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                //button: ".next()"
            });
        });
    </script>
        <style type="text/css">
        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}

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
            <h2>Postion History</h2>

   / <div class="tooltip"><a href="OrdersPage.aspx" class="set1">Available Orders</a> <span class="tooltiptext">Create orders, orders will sit available till dispatched.</span> </div>
        / <div class="tooltip"><a href="Trucks.aspx" class="set1">Truck Address Book</a> <span class="tooltiptext">Vehicles within your Fleet.</span> </div>
        / <div class="tooltip"><a href="AvailableTrucks.aspx" class="set1">Independent Drivers</a> <span class="tooltiptext">Drivers available for hire.</span> </div>
        / <div class="tooltip"><a href="TripMonitor.aspx" class="set1">Trip Monitor</a> <span class="tooltiptext">Orders currently on route.</span> </div>
        / <div class="tooltip"><asp:LinkButton ID="btnNewWindow" OnClick="OpenWindow" runat="server" CLASS="set1">Routing Calculator</asp:LinkButton><span class="tooltiptext">Find the miles / directions / ETA between two locations.</span> </div>
        / <div class="tooltip"><a href="Billing.aspx" class="set1">Billing</a> <span class="tooltiptext">Completed orders, view and print invoices, set driver pay, archive finished orders.</span> </div>
        / <div class="tooltip"><a href="UploadPaperwork.aspx" class="set1">Upload Paperwork</a> <span class="tooltiptext">Add and review paperwork from orders that are complete.</span> </div>
        / <div class="tooltip"><a href="ReportsPage.aspx" class="set1">Reports</a> <span class="tooltiptext">Review all current and past orders.</span> </div>
        / <div class="tooltip"><a href="RatePeople.aspx" class="set1">Rating</a> <span class="tooltiptext">Rate other carriers and drivers based on past interactions.</span> </div>
        / <div class="tooltip"><a href="PostedLoads.aspx" class="set1">Posted Loads</a> <span class="tooltiptext">View loads available from other carriers.</span> </div>
        / <div class="tooltip"><a href="VehicleControlBoard.aspx" class="set1">Vehicle Control Board</a> <span class="tooltiptext">Search for loads based on current truck location.</span> </div>
        /
        <br />
        <br />

            Truck =
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;<i>(sorted by: newest first)</i><br />
            <br />
            <table>
                <tr>
                    <td>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" ForeColor="#333333" GridLines="None" Width="647px" DataSourceID="SqlDataSource1">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                                <asp:BoundField DataField="lastposition" HeaderText="Location" SortExpression="lastposition">
                                    <FooterStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="lastdateandtime" HeaderText="Date and Time" DataFormatString="{0:MM/dd/yyyy HH:mm:ss}" SortExpression="lastdateandtime">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                    </td>
                    <td width="60"></td>
                    <td valign="top">Add a New Location, Date, and Time<br />
                        Enter New Location :
                        <asp:TextBox ID="TextBox1" runat="server" /><br />
                        Enter a New Date and Time :
                        <asp:TextBox ID="TextBox2" runat="server" class="frank" />
                        <asp:Label ID="Label3" runat="server" ForeColor="Red"></asp:Label><br />
                        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" ProviderName="<%$ ConnectionStrings:TMSProgramConnectionString.ProviderName %>" SelectCommand="SELECT id, lastposition, lastdateandtime, name, compid FROM Truck002 WHERE (name = @something) AND (compid = @compid) ORDER BY lastdateandtime DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="something" QueryStringField="name" />
                    <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

            <br />
            <br />
            <br />
          </form>
</body>
</html>
