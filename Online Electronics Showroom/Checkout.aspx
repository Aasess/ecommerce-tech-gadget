<%@ Page title="Tech Gadget - Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Online_Electronics_Showroom.Checkout" %>
<%@ MasterType VirtualPath="~/Site.Master" %>


<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="container-banner">
        <p>Checkout</p>
    </div>

    <div class="container">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
            CssClass="error-msg summary"
            HeaderText="Please correct these entries:" />
    </div>

    <div class="container container-checkout">
        <%-- contact information form --%>
        <h3>Contact Information</h3>
        <div class="book-info">
            <label for="txtEmail1" class="form-label">Email Address:</label>
            <asp:TextBox ID="txtEmail1" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvEmail1" runat="server"
                    ErrorMessage="Email address" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtEmail1">Required</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail1" runat="server"
                    ErrorMessage="Email address" CssClass="error-msg"
                    Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ControlToValidate="txtEmail1">Must be a valid email address</asp:RegularExpressionValidator>
            </div>
        </div>

        <div class="book-info">
            <label for="txtEmail2">Email Re-entry:</label>
            <asp:TextBox ID="txtEmail2" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvEmail2" runat="server"
                    ErrorMessage="Email re-entry" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtEmail2">Required</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvEmail2" runat="server"
                    ErrorMessage="Email re-entry" CssClass="error-msg" Display="Dynamic"
                    ControlToValidate="txtEmail2" ControlToCompare="txtEmail1">Must match first email address</asp:CompareValidator>
            </div>
        </div>

        <div class="book-info">
            <label for="txtFirstName">First Name:</label>
            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                    ErrorMessage="First Name" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtFirstName">Required</asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="book-info">
            <label for="txtLastName">Last Name:</label>
            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                    ErrorMessage="Last Name" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtLastName">Required</asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="book-info">
            <label for="txtPhone">Phone Number:</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server"
                    ErrorMessage="Phone number" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtPhone">Required</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server"
                    ErrorMessage="Phone number" CssClass="error-msg"
                    Display="Dynamic" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                    ControlToValidate="txtPhone">Use this format: 123-456-7890</asp:RegularExpressionValidator>
            </div>
        </div>

        <%-- billing information form --%>
        <h3>Billing Address</h3>
        <div class="book-info">
            <label for="txtAddress">Address:</label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvStreetAddress" runat="server"
                    ErrorMessage="Billing address" Text="Required"
                    CssClass="error-msg" Display="Dynamic"
                    ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
            </div>
        </div>


        <div class="book-info">
            <label>City:</label>
            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                    ErrorMessage="Billing city" Text="Required" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtCity"></asp:RequiredFieldValidator>
            </div>
        </div>


        <div class="book-info">
            <label>Province:</label>
            <div>
                <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"
                    AppendDataBoundItems="True" DataSourceID="SqlDataSource1"
                    DataTextField="StateName" DataValueField="StateCode">
                    <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT [StateCode], [StateName] FROM [States] ORDER BY [StateCode]"></asp:SqlDataSource>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rfvState" runat="server"
                    ErrorMessage="Billing state" Text="Required" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="ddlState"></asp:RequiredFieldValidator>
            </div>
        </div>


        <div class="book-info">
            <label>Zip code:</label>
            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvZip" runat="server"
                    ErrorMessage="Billing zip code" Text="Required" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtZip"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revZip" runat="server"
                    ErrorMessage="Billing zip code" Display="Dynamic" CssClass="error-msg"
                    ControlToValidate="txtZip" ValidationExpression="\d{5}(-\d{4})?">
            Use this format: 98765 or 54321-6789
                </asp:RegularExpressionValidator>
            </div>
        </div>

        <h3>Shipping Address</h3>
        <div class="book-info">
            <div>
                <asp:CheckBox ID="chkSameAsBilling" runat="server"
                    AutoPostBack="true"
                    OnCheckedChanged="chkSameAsBilling_CheckedChanged" />
                <label>Same as billing address</label>
            </div>
        </div>

        <div class="book-info">
            <label>Address:</label>
            <asp:TextBox ID="txtShipAddress" runat="server" CssClass="form-control"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvShipAddress" runat="server"
                    ErrorMessage="Shipping address" Text="Required"
                    CssClass="error-msg" Display="Dynamic"
                    ControlToValidate="txtShipAddress"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="book-info">
            <label>City:</label>
            <asp:TextBox ID="txtShipCity" runat="server" CssClass="form-control"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvShipCity" runat="server"
                    ErrorMessage="Shipping city" Text="Required" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtShipCity"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="book-info">
            <label>State:</label>
            <div>
                <asp:DropDownList ID="ddlShipState" runat="server" CssClass="form-control"
                    AppendDataBoundItems="True" DataSourceID="SqlDataSource1"
                    DataTextField="StateName" DataValueField="StateCode">
                    <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rfvShipState" runat="server"
                    ErrorMessage="Shipping state" Text="Required" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="ddlShipState"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="book-info">
            <label>Zip code:</label>
            <asp:TextBox ID="txtShipZip" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
            <div>
                <asp:RequiredFieldValidator ID="rfvShipZip" runat="server"
                    ErrorMessage="Shipping zip code" Text="Required" CssClass="error-msg"
                    Display="Dynamic" ControlToValidate="txtShipZip"></asp:RequiredFieldValidator>
            </div>

            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                ErrorMessage="Billing zip code" Display="Dynamic" CssClass="error-msg"
                ControlToValidate="txtShipZip" ValidationExpression="\d{5}(-\d{4})?">
                        Use this format: 98765 or 54321-6789
            </asp:RegularExpressionValidator>
        </div>


        <%-- buttons --%>
        <div class="action-btns">
            <asp:Button ID="btnCheckOut" runat="server" Text="Place Order" CssClass="btn btn-primary"
                OnClick="btnCheckOut_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Go back to Cart" CssClass="btn btn-secondary ml-2"
                CausesValidation="False" OnClick="btnCancel_Click" />
            <asp:LinkButton ID="lbtnContinueShopping" runat="server" CssClass="btn ml-2"
                PostBackUrl="~/Products" CausesValidation="False">Continue Shopping</asp:LinkButton>


        </div>
    </div>
</asp:Content>
