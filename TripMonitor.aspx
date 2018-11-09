<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripMonitor.aspx.cs" Inherits="TripMonitor" %>

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

        .auto-style2 {
            width: 128px;
        }

        .auto-style4 {
            width: 270px;
        }

        .auto-style5 {
            width: 200px;
        }

        .auto-style8 {
            width: 151px;
        }

        .auto-style9 {
            width: 305px;
        }

        .auto-style10 {
            width: 311px;
        }

        a.set1:link {
            color: rgb(80, 124, 209);
        }

        a.set1:active {
            color: rgb(80, 124, 209);
        }

        a.set1:visited {
            color: rgb(80, 124, 209);
        }

        .button {
            font: bold 11px Arial;
            text-decoration: none;
            background-color: #EEEEEE;
            color: #333333;
            padding: 2px 6px 2px 6px;
            border-top: 1px solid #CCCCCC;
            border-right: 1px solid #333333;
            border-bottom: 1px solid #333333;
            border-left: 1px solid #CCCCCC;
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
        <h2 style="padding-bottom: 4px">Trip Monitor</h2>

        <asp:DataList ID="DataList1" OnItemDataBound="DataList1_ItemDataBound" runat="server"
            DataKeyField="ordernumber" DataSourceID="SqlDataSource2" BorderColor="Black" BorderWidth="1px"
            CellSpacing="1" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">
            <HeaderStyle BackColor="#507CD1" ForeColor="White" />
            <HeaderTemplate>
                <table border="1">
                    <tr>
                        <td class="auto-style2">Order Number</td>
                        <td class="auto-style8">Truck Number<br />
                            Driver&#39;s Name</td>
                        <td class="auto-style4">Pick Up Location<br />
                            Scheduled Pick Up - Date & Time<br />
                            Actual Arrived - Date & Time</td>
                        <td class="auto-style4">Drop Off Location<br />
                            Scheduled Drop Off - Date & Time<br />
                            Actual Arrived - Date & Time</td>
                        <td class="auto-style9">
                            <table width="100%">
                                <tr>
                                    <td>Last Known - City, State/Prov<br />
                                        Last Known - Date & Time</td>
                                    <td>View on Map</td>
                                </tr>
                            </table>
                        </td>
                        <td class="auto-style5">
                            Mins Until the Trips Next Stop<br />
                            (Sch Time - Curr Time)
                        </td>
                    </tr>
                </table>
            </HeaderTemplate>
            <ItemTemplate>
                <table border="1">
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="ordernumberLabel" runat="server" Text='<%# Eval("ordernumber") %>' />
                        </td>
                        <td class="auto-style8">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="truckLabel" runat="server" Text='<%# Eval("truck") %>' /><br />
                                        <asp:Label ID="driverLabel" runat="server" Text='<%# Eval("driver") %>' />
                                    </td>
                                    <td>
                                        <%--<div class="tooltip">--%>
                                            <asp:HyperLink ID="hlnk" NavigateUrl='<%# string.Format("TruckDriver.aspx?id={0}&driver={1}&truck={2}", Eval("ordernumber"), Eval("driver"), Eval("truck")) %>' runat="server">
                                                <asp:Image ID="Image1" runat="server" BorderStyle="None"
                                                    ImageUrl='Images/truckbutton.png' />
                                            </asp:HyperLink>
                                            <%--<span class="tooltiptext">Dispatch the load to a truck or a carrier.</span></div>--%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="auto-style4">
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("pickuplocation") %>' />
                            <br />
                            <asp:Label ID="pickupdateandtimeLabel" runat="server" Text='<%# Eval("pickupdateandtime", "{0:MM/dd/yyyy HH:mm}") %>' />
                            <br />
                            <asp:Label ID="actualpickupLabel" runat="server" Text='<%# Eval("actualpickup", "{0:MM/dd/yyyy HH:mm}") %>' />
                            <br />
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# String.Format("~/LogLoaded.aspx?id={0}&schtime={1}", Eval("ordernumber"), Eval("pickupdateandtime", "{0:MM/dd/yyyy HH:mm}")) %>'>log arrive and loaded</asp:HyperLink>
                        </td>
                        <td class="auto-style4">
                            <asp:Label ID="Label14" runat="server" Text='<%# Eval("dropofflocation") %>' />
                            <br />
                            <asp:Label ID="dropoffdateandtimeLabel" runat="server" Text='<%# Eval("dropoffdateandtime", "{0:MM/dd/yyyy HH:mm}") %>' />
                            <br />
                            <asp:Label ID="actualdropoffLabel" runat="server" Text='<%# Eval("actualdropoff", "{0:MM/dd/yyyy HH:mm}") %>' /><br />
                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# String.Format("~/LogEmpty.aspx?id={0}&schtime={1}", Eval("ordernumber"), Eval("dropoffdateandtime", "{0:MM/dd/yyyy HH:mm}")) %>'>log arrive and empty</asp:HyperLink>
                        </td>
                        <td class="auto-style9">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:HyperLink ID="lastpositionlabel" runat="server" Text='<%# Eval("lastposition") %>' NavigateUrl='<%# Eval("truck", "~/PositionHistory.aspx?name={0}")  %>'></asp:HyperLink>
                                        <br />
                                        <asp:Label ID="lastdateandtimelabel" runat="server" Text='<%# Eval("lastdateandtime", "{0:MM/dd/yyyy HH:mm}") %>'> </asp:Label>
                                    </td>
                                    <td>

                                        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl='<%# String.Format("~/Map.aspx?lat={0}&long={1}&marker={2}", Eval("pickuplocation"), Eval("dropofflocation"), Eval("lastposition")) %>'
                                            onclick="javascript:w= window.open(this.href,'lat', 'left=200,top=100,width=790,height=1000,resizable=yes');return false;">
                                            <%--<div class="tooltip">--%>
                                                <asp:Image ID="Image2" runat="server" BorderStyle="None" ImageUrl='Images/mapbutton.png' />
                                        </asp:HyperLink>
                                        <%--<span class="tooltiptext">View the trips route and current truck location.</span></div>--%>
                                    </td>
                                </tr>
                            </table>


                        </td>
                        <td class="auto-style5">
                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("Days2") %>'></asp:Label>
                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("Days") %>'></asp:Label>
                            <asp:Label ID="Label6" runat="server" Text=" days "></asp:Label>
                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("Hours2") %>'></asp:Label>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Hours") %>'></asp:Label>
                            <asp:Label ID="Label4" runat="server" Text=" hours "></asp:Label>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Mins2") %>'></asp:Label>
                            <asp:Label ID="Label11" runat="server" Text='<%# Eval("Mins") %>'></asp:Label>
                            <asp:Label ID="Label5" runat="server" Text=" mins"></asp:Label>
                            <br />
                            <center><asp:HyperLink  ID="HyperLink5" style="white-space:nowrap;" class="button" NavigateUrl='<%# String.Format("~/workerSendUpdate.aspx?orderid={0}&driver={1}&location={2}&time={3}&truck={4}&pickup={5}&drop={6}", Eval("ordernumber"), Eval("driver"), Eval("lastposition"), Eval("lastdateandtime"), Eval("truck"), Eval("pickupdateandtime"), Eval("dropoffdateandtime")) %>' runat="server">
                                        Send Email Update</asp:HyperLink></center>
                            <center>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:HyperLink ID="HyperLink3" style="white-space:nowrap;" class="button" NavigateUrl='<%# String.Format("~/SetupAutoEmail.aspx?orderid={0}", Eval("ordernumber")) %>' runat="server">
                                        Configure Auto Email</asp:HyperLink>
                                            </td>
                                            <td>
                                                <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/autoemail.png" Width="22px" Visible="False" />
                                            </td>
                                        </tr>
                                    </table>
                                    </center>


                        </td>
                    </tr>
                </table>

            </ItemTemplate>
        </asp:DataList>
        <div style="max-width: 1340px; text-align:right; padding:7px" >
            <asp:Label ID="Label12" runat="server" Text="Current Time is "></asp:Label>
            <asp:Label ID="Label13" runat="server" Text="Label"></asp:Label>
        </div>

        <p>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
                DeleteCommand="DELETE FROM [DispatchTable] WHERE [ordernumber] = @ordernumber" InsertCommand="INSERT INTO [DispatchTable] ([ordernumber], [truck], [driver], [pickupdateandtime], [dropoffdateandtime], [actualpickup], [actualdropoff]) VALUES (@ordernumber, @truck, @driver, @pickupdateandtime, @dropoffdateandtime, @actualpickup, @actualdropoff)" SelectCommand="SELECT DispatchTable.ordernumber, DispatchTable.truck, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, orders.pickupdateandtime, orders.dropoffdateandtime FROM DispatchTable INNER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE (orders.status = 'onRoute')" UpdateCommand="UPDATE [DispatchTable] SET [truck] = @truck, [driver] = @driver, [pickupdateandtime] = @pickupdateandtime, [dropoffdateandtime] = @dropoffdateandtime, [actualpickup] = @actualpickup, [actualdropoff] = @actualdropoff WHERE [ordernumber] = @ordernumber" OnSelecting="SqlDataSource1_Selecting">
                <DeleteParameters>
                    <asp:Parameter Name="ordernumber" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ordernumber" Type="Int32" />
                    <asp:Parameter Name="truck" Type="String" />
                    <asp:Parameter Name="driver" Type="String" />
                    <asp:Parameter Name="pickupdateandtime" Type="DateTime" />
                    <asp:Parameter Name="dropoffdateandtime" Type="DateTime" />
                    <asp:Parameter Name="actualpickup" Type="DateTime" />
                    <asp:Parameter Name="actualdropoff" Type="DateTime" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="truck" Type="String" />
                    <asp:Parameter Name="driver" Type="String" />
                    <asp:Parameter Name="pickupdateandtime" Type="DateTime" />
                    <asp:Parameter Name="dropoffdateandtime" Type="DateTime" />
                    <asp:Parameter Name="actualpickup" Type="DateTime" />
                    <asp:Parameter Name="actualdropoff" Type="DateTime" />
                    <asp:Parameter Name="ordernumber" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
                SelectCommand="SELECT DispatchTable.ordernumber, DispatchTable.truck, DispatchTable.driver, orders.pickuplocation, orders.dropofflocation, DispatchTable.actualpickup, DispatchTable.actualdropoff, orders.pickupdateandtime, orders.dropoffdateandtime, TruckLatest.lastposition, TruckLatest.lastdateandtime, DATEDIFF(minute, GETDATE(), orders.pickupdateandtime) / (60 * 24) AS Days, DATEDIFF(minute, GETDATE(), orders.pickupdateandtime) / 60 % 24 AS Hours, DATEDIFF(minute, GETDATE(), orders.pickupdateandtime) % 60 AS Mins, DATEDIFF(minute, GETDATE(), orders.dropoffdateandtime) / (60 * 24) AS Days2, DATEDIFF(minute, GETDATE(), orders.dropoffdateandtime) / 60 % 24 AS Hours2, DATEDIFF(minute, GETDATE(), orders.dropoffdateandtime) % 60 AS Mins2, TruckLatest.compid FROM DispatchTable INNER JOIN orders ON DispatchTable.ordernumber = orders.id FULL OUTER JOIN (SELECT name, lastposition, lastdateandtime, compid FROM Truck002 AS Truck1 WHERE (lastdateandtime = (SELECT MAX(lastdateandtime) AS Expr1 FROM Truck002 AS Truck2 WHERE (name = Truck1.name) AND (compid = Truck1.compid)))) AS TruckLatest ON DispatchTable.truck = TruckLatest.name AND orders.compid = TruckLatest.compid WHERE (orders.status = 'onRoute') AND (orders.compid = @compid)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </div>
    </form>
    <br /><br /><br /><br />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $("#nav-placeholder").load("navpage.html");
        });
    </script>
</body>
</html>
