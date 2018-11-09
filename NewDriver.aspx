<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewDriver.aspx.cs" Inherits="NewDriver" %>

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
                        <asp:Label ID="lblcompid" runat="server">driver</asp:Label>
                        </center>
                    </td>
                    <td align="right">ASP.NET and MS SQL<br />
                        <i>proof of concept - </i>
                        <asp:LinkButton ID="LinkButton_signout" runat="server" OnClick="LinkButton1_Click">sign out</asp:LinkButton>
                    </td>
                </tr>
            </table>

            <h3>Add New Driver</h3>
            You will need to make a new Account for every truck that you want posted.<br />
            <table>
                <tr>
                    <td>User ID</td>
                    <td>
                        <asp:TextBox ID="txtuserid" runat="server" Width="218px" TabIndex="1"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td>Location of Truck</td>
                    <td>
                        <asp:TextBox ID="txtlocation" runat="server" Width="218px" TabIndex="6"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td>Email</td>
                    <td>
                        <asp:TextBox ID="txtemail" runat="server" Width="218px" TabIndex="10"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="txtpassword" runat="server" Width="218px" TabIndex="2" TextMode="Password"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td>Available Date</td>
                    <td>
                        <asp:TextBox ID="txtdate" runat="server" Width="218px" class="frank" TabIndex="7"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td>Phone Number</td>
                    <td>
                        <asp:TextBox ID="txtphoneno" runat="server" Width="218px" TabIndex="11"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Full Name</td>
                    <td>
                        <asp:TextBox ID="txtfullname" runat="server" Width="218px" TabIndex="3"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td>Truck Type</td>
                    <td>
                        <asp:TextBox ID="txttrucktype" runat="server" Width="218px" TabIndex="8"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td rowspan="3">Comments
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
                        <asp:TextBox ID="txtcompanyname" runat="server" Width="218px" TabIndex="4"></asp:TextBox>
                    </td>
                    <td width="30px"></td>
                    <td>Length x Width x Height</td>
                    <td>
                        <asp:TextBox ID="txtlxwxh" runat="server" Width="218px" TabIndex="9"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Truck Number</td>
                    <td>
                        <asp:TextBox ID="txttruckno" runat="server" Width="218px" TabIndex="5"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="padding: 8px"></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <center>
                        <asp:Button ID="Button1" runat="server" Text="Create New Account" OnClick="Button1_Click" TabIndex="13" /></center>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <center>
                        <asp:Label ID="lblvalidation" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>

        </div>

        <script type="text/javascript">
            function HideLabel() {
                var seconds = 3;
                setTimeout(function () {
                    document.getElementById("<%=lblvalidation.ClientID %>").style.display = "none";
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
        <br />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>

    </form>
</body>
</html>
