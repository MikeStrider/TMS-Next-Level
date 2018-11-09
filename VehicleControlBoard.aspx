<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VehicleControlBoard.aspx.cs" Inherits="PostedLoads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title></title>
    <link rel="stylesheet" href="StyleSheet.css" type="text/css" />
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
            width: 330px;
            height: 140px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }
    </style>
    <style type="text/css">
        a.set1:link {color: rgb(80, 124, 209);}
        a.set1:active {color: rgb(80, 124, 209);}
        a.set1:visited {color: rgb(80, 124, 209);}

    </style>
    <script src="http://code.jquery.com/jquery-1.12.2.min.js"></script>
    <script type="text/javascript" src="js/on-off-switch.js"></script>
    <script type="text/javascript" src="js/on-off-switch-onload.js"></script>
    <link rel="stylesheet" type="text/css" href="css/on-off-switch.css"/>
    <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
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
            <h2>Vehicle Control Board</h2>

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

       <table>
           <tr>
               <td style="padding: 5px">
                   <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Run Vehicle Based Load Search" Width="261px" />
               </td>
               <td>
                   This page is used to search for loads for ALL your vehicles at the same time.  Select how far each truck wants to drive for a pick up.  If a driver really really wants a load he will driver further.  Enter this value by clicking edit.  When ready to run searches click the button.
               </td>
           </tr>
       </table>

        <br />

       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
       CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" 
       OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
       OnRowDataBound="GridView1_RowDataBound">
           <AlternatingRowStyle BackColor="White" />
           <Columns>
               <asp:TemplateField HeaderText="Truck" SortExpression="name">
                   <EditItemTemplate>
                       <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>' ForeColor="White"></asp:Label>
                   </EditItemTemplate>
                   <ItemTemplate>
                       <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField SortExpression="trucktype">
                   <EditItemTemplate>
                       <asp:Label ID="Label2" runat="server" Text='<%# Bind("trucktype") %>' ForeColor="White"></asp:Label>
                   </EditItemTemplate>
                   <ItemTemplate>
                       <asp:Label ID="Label2" runat="server" Text='<%# Bind("trucktype") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Last Position" SortExpression="lastposition">
                   <EditItemTemplate>
                       <asp:Label ID="Label3" runat="server" Text='<%# Bind("lastposition") %>' ForeColor="White"></asp:Label>
                   </EditItemTemplate>
                   <ItemTemplate>
                       <asp:HyperLink ID="HyperLink3" runat="server" Text='<%# Bind("lastposition") %>' NavigateUrl='<%# Eval("name", "~/PositionHistory.aspx?name={0}")  %>'></asp:HyperLink>
                   </ItemTemplate>
               </asp:TemplateField>
                 <asp:TemplateField HeaderText="Last Date &amp; Time" SortExpression="lastdateandtime">
                   <EditItemTemplate>
                       <asp:Label ID="Label6" runat="server" Text='<%# Bind("lastdateandtime", "{0:MM/dd/yyyy HH:mm:ss}") %>' ForeColor="White"></asp:Label>
                   </EditItemTemplate>
                     <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("lastdateandtime", "{0:MM/dd/yyyy HH:mm:ss}") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" Wrap="False" />
                </asp:TemplateField>

               <asp:TemplateField HeaderText="Searching" SortExpression="searching">
                   <ItemTemplate>
                       <asp:Label ID="Label5" runat="server" Text='<%# Bind("searching") %>' Visible="false"></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>

               <asp:TemplateField HeaderText="Kilometers Out" SortExpression="miles">
                   <EditItemTemplate>
                       <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("miles") %>'></asp:TextBox>
                   </EditItemTemplate>
                   <ItemTemplate>
                       <asp:Label ID="Label4" runat="server" Text='<%# Bind("miles") %>'></asp:Label>
                   </ItemTemplate>
                   <ItemStyle HorizontalAlign="Center" />
               </asp:TemplateField>

               <asp:TemplateField ShowHeader="False">
                   <EditItemTemplate>
                       <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" ForeColor="White" Text="update"></asp:LinkButton>
                       &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" ForeColor="White" Text="cancel"></asp:LinkButton>
                   </EditItemTemplate>
                   <ItemTemplate>
                       <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="edit"></asp:LinkButton>
                   </ItemTemplate>
               </asp:TemplateField>

               <asp:TemplateField HeaderText="Loads Found">
                   <ItemTemplate>
                       <asp:HyperLink ID="HyperLink1" runat="server" Text=""></asp:HyperLink>
                       <asp:HyperLink ID="HyperLink2" runat="server" Text="" ForeColor="#0099FF"></asp:HyperLink>
                   </ItemTemplate>
               </asp:TemplateField>


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


            <br />


    </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
            DeleteCommand="DELETE FROM [Trucks] WHERE [name] = @name"
            InsertCommand="INSERT INTO [Trucks] ([name], [dateacquired], [licencesplate], [trucktype], [compid]) VALUES (@name, @dateacquired, @licencesplate, @trucktype, @compid)"
            SelectCommand="SELECT DISTINCT Trucks.name, TruckLatest.lastposition, TruckLatest.lastdateandtime, TruckLatest.compid, Trucks.searching, Trucks.[where], Trucks.miles, Trucks.trucktype FROM Trucks INNER JOIN (SELECT DISTINCT name, lastposition, lastdateandtime, compid FROM Truck002 AS Truck1 WHERE (lastdateandtime = (SELECT MAX(lastdateandtime) AS Expr1 FROM Truck002 AS Truck2 WHERE (name = Truck1.name) AND (compid = Truck1.compid)))) AS TruckLatest ON Trucks.name = TruckLatest.name AND Trucks.compid = TruckLatest.compid WHERE (Trucks.compid = @compid) ORDER BY Trucks.trucktype, Trucks.name"
            UpdateCommand="UPDATE [Trucks] SET [miles] = @miles WHERE [name] = @name">
            <DeleteParameters>
                <asp:Parameter Name="name" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter DbType="Date" Name="dateacquired" />
                <asp:Parameter Name="licencesplate" Type="String" />
                <asp:Parameter Name="trucktype" Type="String" />
                <asp:Parameter Name="lastposition" Type="String" />
                <asp:Parameter Name="lastdateandtime" Type="DateTime" />
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter DbType="Date" Name="dateacquired" />
                <asp:Parameter Name="licencesplate" Type="String" />
                <asp:Parameter Name="trucktype" Type="String" />
                <asp:Parameter Name="lastposition" Type="String" />
                <asp:Parameter Name="lastdateandtime" Type="DateTime" />
                <asp:Parameter Name="name" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>


        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="compid,id" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="pickuplocation" HeaderText="pickuplocation" SortExpression="pickuplocation" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
                    SelectCommand="SELECT companyinfo.email, companyinfo.phonenumber, companyinfo.compid, companyinfo.name, orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.compid AS Expr1 FROM companyinfo INNER JOIN orders ON companyinfo.compid = orders.compid WHERE (orders.Posted = 1)">
                </asp:SqlDataSource>
        <br />




           <div class="loading" align="center" ><br />
                    Please Wait. <br /> Searching for Loads. Looping thru trucks. <br />Contacting Google for Distances... <br /> The more trucks enabled the longer this will take.
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
</body>
</html>
