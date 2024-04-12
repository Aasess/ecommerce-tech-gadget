<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Online_Electronics_Showroom.Contact" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="container-banner">
        <p>Contact Us</p>
    </div>

    <div class="container mt-3 mx-auto">
        <div>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
        </div>
        <div class="mb-3">
            <label for="txtName" class="form-label">Name:</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ControlToValidate="txtName"
                ErrorMessage="Name is required" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="mb-3">
            <label for="txtEmail" class="form-label">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="Email is required" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="mb-3">
            <label for="txtSubject" class="form-label">Subject:</label>
            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="txtMessage" class="form-label">Message:</label>
            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
        </div>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
    </div>
</asp:Content>
