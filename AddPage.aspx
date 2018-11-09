<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPage.aspx.cs" Inherits="AddPage" %>

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
                button: ".next()"
            });
        });
    </script>
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

            <h3>Insert Order</h3>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1"
                ForeColor="#333333" GridLines="None" Height="50px" Width="157px" DefaultMode="Insert" OnItemInserted="DetailView_ItemInsert"
                OnItemCommand="DetailView_ItemCommand">
                <AlternatingRowStyle BackColor="White" />
                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                <EditRowStyle BackColor="#2461BF" />
                <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                <Fields>

                    <asp:BoundField DataField="id" HeaderText="Order Number" InsertVisible="False" ReadOnly="True" SortExpression="id">
                        <HeaderStyle Wrap="False" />
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="Pick Up Location">
                        <EditItemTemplate>
                            <asp:TextBox ID="pickuplocation" runat="server"
                                Text="<%# Bind('pickuplocation') %>" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="pickuplocation" ErrorMessage="location is required" ForeColor="#999999"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" />
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Pick Up - Date &amp; Time">
                        <EditItemTemplate>
                            <asp:TextBox ID="pickupdateandtime" runat="server" class="frank"
                                Text="<%# Bind('pickupdateandtime') %>" />
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" />
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Drop Off Location">
                        <EditItemTemplate>
                            <asp:TextBox ID="dropofflocation" runat="server"
                                Text="<%# Bind('dropofflocation') %>" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="dropofflocation" ErrorMessage="location is required" ForeColor="#999999"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" />
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Drop Off - Date &amp; Time">
                        <EditItemTemplate>
                            <asp:TextBox ID="dropoffdateandtime" runat="server" class="frank"
                                Text="<%# Bind('dropoffdateandtime') %>" />
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" />
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Booked By">
                        <EditItemTemplate>
                            <asp:TextBox ID="bookedBy" runat="server" ReadOnly="true"
                                Text="<%# Bind('bookedBy') %>" />
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" />
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
            </asp:DetailsView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>"
                InsertCommand="INSERT INTO [orders] ([pickupdateandtime], [dropoffdateandtime], [pickuplocation], [dropofflocation], [bookedby], [status], [compid], [Posted]) VALUES 
                (@pickupdateandtime, @dropoffdateandtime, @pickuplocation, @dropofflocation, @bookedby, 'available', @compid, '0')"
                OnSelecting="SqlDataSource1_Selecting" >
                <InsertParameters>
                    <asp:ControlParameter ControlID="lblcompid" Name="compid" PropertyName="Text" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
        <br />


    </form>



</body>



</html>

