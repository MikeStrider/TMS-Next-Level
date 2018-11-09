<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Processor.aspx.cs" Inherits="Processor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="refresh" content="15" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        This is the processor. It cycles and does various things every 1 min.<br />
        <br />
       <a href="HangFire">Launch HangFire Dashboard</a> 
        <br />
        <br />

        Showing:<br />

        Load tenders from EDI. <br />
        All XML transactions.<br />
        Data from last 7 days till now.<br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Start" Width="90px" style="height: 26px" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="Stop" OnClick="Button2_Click" style="height: 26px" Width="102px" /><br />
        <br />
        <table>
            <tr>
                <td valign="top" width="50%">
                      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="DataSource1">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="StateName" HeaderText="StateName" SortExpression="StateName" />
                <asp:BoundField DataField="Arguments" HeaderText="Arguments" SortExpression="Arguments" />
                <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" SortExpression="CreatedAt" />
                <asp:BoundField DataField="ExpireAt" HeaderText="ExpireAt" SortExpression="ExpireAt" />
            </Columns>
        </asp:GridView>
                </td>
                <td valign="top">

                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="DataSource2">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                            <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                            <asp:BoundField DataField="details" HeaderText="details" SortExpression="details" />
                            <asp:BoundField DataField="datetime" HeaderText="datetime" SortExpression="datetime" />
                        </Columns>
                    </asp:GridView>

                </td>
            </tr>
        </table>
      
       <asp:SqlDataSource ID="DataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
                SelectCommand="SELECT Id, StateName, Arguments, CreatedAt, ExpireAt FROM HangFire.Job ORDER BY Id DESC"></asp:SqlDataSource>
       <asp:SqlDataSource ID="DataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TMSProgramConnectionString %>" 
                SelectCommand="SELECT id, type, details, datetime FROM logging WHERE (datetime &gt;= { fn NOW() } - 7) ORDER BY id DESC"></asp:SqlDataSource>
        <br />

    
    </div>
    </form>
</body>
</html>
