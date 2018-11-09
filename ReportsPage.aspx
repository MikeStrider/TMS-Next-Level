<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportsPage.aspx.cs" Inherits="Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="StyleSheet.css" type="text/css" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".frank").dynDateTime({
                showsTime: false,
                ifFormat: "%m/%d/%Y",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
        });
    </script>
    <style type="text/css">
        td, th {
            padding: 5px;
        }
        .auto-style1 {
            text-decoration: underline;
        }
        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}
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

        <div id="nav-placeholder"></div>
            
            <div style="padding-left: 12px">
            <h2 style="padding-bottom: 4px">Reports</h2>
                              
            Sort by <b>one</b> of the following items:
            <br />
            <br />
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Pick Up Locations : " />
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="FilterDataSource" DataTextField="pickuplocation"
                            DataValueField="pickuplocation" AppendDataBoundItems="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem Text="select a value" Value="na" />
                        </asp:DropDownList>
                    </td>
                    <td width="50"></td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="View All : " />
                    </td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click1" />
                    </td>
                    <td width="50"></td>
                    <td>&nbsp;<asp:Label ID="Label7" runat="server" Text="Pick Up Date Range:"></asp:Label>&nbsp;
                    </td>
                    <td>
                        From 
                    </td>
                    <td>
                        <asp:TextBox ID="txtFromDate" runat="server" class="frank" Width="90px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Booked By : " />
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="BookedByFilterDataSource" DataTextField="bookedby"
                            DataValueField="bookedby" AppendDataBoundItems="true" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Style="height: 22px">
                            <asp:ListItem Text="select a value" Value="na" />
                        </asp:DropDownList>
                    </td>
                    <td>

                    </td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Bill To Customer : " />
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox> <asp:Button ID="Button2" runat="server" Text="Submit" OnClick="Button2_Click" />
                    </td>
                    <td width="50"></td>
                    <td align="right"> 
                        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click" />
                    </td>
                    <td>
                        To 
                    </td>
                    <td>
                        <asp:TextBox ID="txtToDate" runat="server" class="frank" Width="90px" OnTextChanged="txtToDate_TextChanged"></asp:TextBox>
                    </td>
                </tr>
            </table>

            <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
            EmptyDataText="There are no data records to display." OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CellPadding="5">
            <Columns>
                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="id" HeaderText="Order<br>Number" HtmlEncode="False" SortExpression="id" InsertVisible="False" ReadOnly="True">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="pickuplocation" HeaderText="Pick Up<br>Location" HtmlEncode="False" SortExpression="pickuplocation">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="dropofflocation" HeaderText="Drop Off<br>Location" HtmlEncode="False" SortExpression="dropofflocation">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="bookedby" HeaderText="Booked<br>By" HtmlEncode="False" SortExpression="bookedby">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Expr1" HeaderText="Truck<br>No." HtmlEncode="False" SortExpression="Expr1">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="driver" HeaderText="Driver's<br>Name" HtmlEncode="False" SortExpression="driver">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="pickupdateandtime" HeaderText="Pick Up<br>Scheduled" DataFormatString="{0:MM/dd/yyyy HH:mm}" HtmlEncode="False" SortExpression="pickupdateandtime">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="actualpickup" HeaderText="Pick Up<br>Arrive Time" DataFormatString="{0:MM/dd/yyyy HH:mm}" HtmlEncode="False" SortExpression="actualpickup">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="loaded" HeaderText="Pick Up<br>Loaded" DataFormatString="{0:MM/dd/yyyy HH:mm}" HtmlEncode="False" SortExpression="loaded">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="dropoffdateandtime" HeaderText="Drop Off<br>Scheduled" DataFormatString="{0:MM/dd/yyyy HH:mm}" HtmlEncode="False" SortExpression="dropoffdateandtime">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="actualdropoff" HeaderText="Drop Off<br>Arrive Time" DataFormatString="{0:MM/dd/yyyy HH:mm}" HtmlEncode="False" SortExpression="actualdropoff">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="empty" HeaderText="Drop Off<br>Empty" DataFormatString="{0:MM/dd/yyyy HH:mm}" HtmlEncode="False" SortExpression="empty">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="billto" HeaderText="Bill To<br>Customer" HtmlEncode="False" SortExpression="billto">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="totalcharges" HeaderText="Total<br>Charges" HtmlEncode="False" SortExpression="totalcharges">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="tcposted" HeaderText="posted" SortExpression="tcposted">
                    <ItemStyle Wrap="False" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="paid" HeaderText="paid" SortExpression="paid">
                    <ItemStyle Wrap="False" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="driverpay" HeaderText="Driver<br>Pay" HtmlEncode="False" SortExpression="driverpay">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="dpposted" HeaderText="posted" SortExpression="dpposted">
                    <ItemStyle Wrap="False" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="paperwork" HeaderText="Paperwork" SortExpression="paperwork">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:Label ID="Label6" runat="server"></asp:Label>
        <br />
        <br />
        <span class="auto-style1">help - definition of status</span><br />
        <b>available</b> - user has created the order <br /> <b>onRoute</b> - user has dispatched the order and is currnetly driving <br /> <b>complete</b> - job is done waiting for payment <br /> <b>posted</b> - trip is paid for and driver is paid <br /> <b>exported</b> - exported to flat file<br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            SelectCommand="SELECT orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.bookedby, orders.status, orders.compid, DispatchTable.truck AS Expr1, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE (orders.pickuplocation = @pickuplocation) AND (orders.compid = @compid)" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="pickuplocation" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            SelectCommand="SELECT        orders.*, DispatchTable.truck AS Expr1, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, 
                         Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork
FROM            Billing FULL OUTER JOIN
                         DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN
                         orders ON DispatchTable.ordernumber = orders.id
WHERE (orders.bookedby = @bookedby) AND (orders.compid = @compid)" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="bookedby" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" OnSelecting="SqlDataSource3_Selecting" SelectCommand="SELECT orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.bookedby, orders.status, DispatchTable.truck AS Expr1, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE (orders.compid = @compid) ORDER BY CASE status WHEN 'available' THEN 1 WHEN 'onRoute' THEN 2 WHEN 'complete' THEN 3 WHEN 'posted' THEN 4 WHEN 'exported' THEN 5 END, orders.id">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_BillToCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" SelectCommand="SELECT        orders.*, DispatchTable.truck AS Expr1, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, 
                         Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork
FROM            Billing FULL OUTER JOIN
                         DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN
                         orders ON DispatchTable.ordernumber = orders.id
WHERE (billing.billto = @billto) and (orders.compid = @compid)">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="billto" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
            OnSelecting="SqlDataSource3_Selecting" 
            SelectCommand="SELECT orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.bookedby, orders.status, DispatchTable.truck AS Expr1, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE (orders.compid = @compid) AND (orders.pickupdateandtime >= @from ) AND (orders.pickupdateandtime <= @to) ORDER BY orders.pickupdateandtime">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtFromDate" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtToDate" Name="to" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <asp:SqlDataSource ID="FilterDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            SelectCommand="SELECT DISTINCT pickuplocation FROM orders WHERE (compid = @compid)" OnSelecting="FilterDataSource_Selecting">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="BookedByFilterDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            SelectCommand="SELECT DISTINCT bookedby FROM orders WHERE (compid = @compid)" OnSelecting="FilterDataSource_Selecting">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

    </form>

    <script>
        $(function () {
            $("#nav-placeholder").load("navpage.html");
        });
    </script>
</body>
</html>
