<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Online_Electronics_Showroom.Login" %>
<%@ MasterType VirtualPath="~/Site.Master" %>


<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="container-banner">
        <p>Login</p>
    </div>
    <div class="container mx-auto">
    <div class="form-group">
        <label for="txtUserName" class="control-label col-sm-2">UserName:</label>
        <div class="col-sm-5">
            <input type="text" id="txtUserName" runat="server" class="form-control" />
        </div>
        <div class="col-sm-5">
            <asp:RequiredFieldValidator ID="rfvUserName" runat="server"
                ErrorMessage="Required" CssClass="text-danger"
                Display="Dynamic" ControlToValidate="txtUserName">
            </asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <label for="txtPassword" class="control-label col-sm-2">Password:</label>
        <div class="col-sm-5">
            <input type="text" id="txtPassword" runat="server" class="form-control" />
        </div>
        <div class="col-sm-5">
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                ErrorMessage="Required" CssClass="text-danger"
                Display="Dynamic" ControlToValidate="txtPassword">
            </asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group action-btns">
        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary"
            OnClick="btnLogin_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ml-3"
            CausesValidation="False" OnClick="btnCancel_Click" />
    </div>
    </div>
</asp:Content>
