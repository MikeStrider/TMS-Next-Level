<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditDriver.aspx.cs" Inherits="NewDriver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />

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
                        <asp:Label ID="lblcompid" runat="server">driver</asp:Label>
                        </center>
                    </td>
                    <td align="right">ASP.NET and MS SQL<br />
                        <i>proof of concept - </i>
                        <asp:LinkButton ID="LinkButton_signout" runat="server" OnClick="LinkButton1_Click">sign out</asp:LinkButton>
                    </td>
                </tr>
            </table>

            <h3>Account Details - Edit Driver</h3>
            You will need to make a new Account for every truck that you want posted.<br />
            <table>
                <tr>
                    <td>User ID</td>
                    <td>
                        <asp:TextBox ID="txtuserid" runat="server" Width="218px" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td>Location of Truck</td>
                    <td>
                        <asp:TextBox ID="txtlocation" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td>Email</td>
                    <td>
                        <asp:TextBox ID="txtemail" runat="server" Width="218px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="txtpassword" runat="server" Width="218px" TextMode="Password"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td>Available Date</td>
                    <td>
                        <asp:TextBox ID="txtdate" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td>Phone Number</td>
                    <td>
                        <asp:TextBox ID="txtphoneno" runat="server" Width="218px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Full Name</td>
                    <td>
                        <asp:TextBox ID="txtfullname" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td>Truck Type</td>
                    <td>
                        <asp:TextBox ID="txttrucktype" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td rowspan="3" valign="top">Comments
                        <br />
                        <asp:Label ID="Label1" runat="server" Text="60 char limit" Font-Size="Smaller"></asp:Label><br />
                        <asp:TextBox ID="TextBox1" runat="server" Width="59px" Font-Italic="True" Font-Size="Smaller" ReadOnly="True"></asp:TextBox>

                    </td>
                    <td rowspan="3" valign="top">
                        <asp:TextBox ID="txtcomments" runat="server" Height="55px" Width="218px" onKeyDown="limitText(this, 60);" TabIndex="12" TextMode="MultiLine"></asp:TextBox>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>Company Name</td>
                    <td>
                        <asp:TextBox ID="txtcompanyname" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td>Length x Width x Height</td>
                    <td>
                        <asp:TextBox ID="txtlxwxh" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td valign="top">Truck Number</td>
                    <td valign="top">
                        <asp:TextBox ID="txttruckno" runat="server" Width="218px"></asp:TextBox>
                    </td>
                    <td width ="30"></td>
                    <td colspan="2">
                        <asp:Image ID="Image1" runat="server" ImageUrl="Images/avail.png" />
                    </td>
                    <td width ="30"></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>

                <tr>
                    <td colspan="9">
                        <center>
                        <asp:Button ID="Button1" runat="server" Text="Update (set as available)" OnClick="Button1_Click" Width="207px" BackColor="#33CC33" Font-Bold="True" Font-Size="Small" />&nbsp;
                        <asp:Button ID="Button2" runat="server" Text="Update (set as NOT available)" OnClick="Button2_Click" Width="241px" BackColor="Red" Font-Bold="True" Font-Size="Small" />&nbsp;&nbsp;<asp:Button ID="Button3" runat="server" Text="View All Available Independent Drivers" OnClick="Button3_Click" Width="261px" />
                        </center>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <center>
                      <asp:Label ID="lblvalication" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>

        </div>

        <p id="availableimage">
        </p>

        <script type="text/javascript">

            function HideLabel() {
                var seconds = 3;
                setTimeout(function () {
                    document.getElementById("<%=lblvalication.ClientID %>").style.display = "none";
                }, seconds * 1000);
            };

        </script>

        <script language="javascript" type="text/javascript">
            function limitText(limitField, limitNum) {
                var limitCount = document.getElementById("<%=TextBox1.ClientID%>");
                if (limitField.value.length > limitNum) {
                    limitField.value = limitField.value.substring(0, limitNum);
                } else {
                    limitCount.value = limitNum - limitField.value.length;
                }
            }
        </script>

    </form>
    <br />
    <br />
    <br />
    <br />
    <br />

</body>

</html>
