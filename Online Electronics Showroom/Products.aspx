<%@ Page Title="Product Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Online_Electronics_Showroom.Products" %>
<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="container-banner">
        <p>Product Page</p>
    </div>

    <div class="container mt-3 mx-auto">
        
            <div class="logged-in__user mb-4">
                <asp:Label ID="lblWelcome" runat="server" CssClass="text-capitalize text-info"></asp:Label>
            </div>

        <%-- Check if the query string contains the "ProductId" parameter --%>
        <% if (string.IsNullOrEmpty(Request.QueryString["ProductId"]))
            { %>
            <div>
                <asp:Label ID="lblProduct" runat="server" Text="Please select a Product:" CssClass="label"></asp:Label>
                <asp:DropDownList ID="ddlProducts" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Name"
                    DataValueField="ProductID" CssClass="ddlProducts-select">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT ProductID, Name, Description, UnitPrice FROM Products"></asp:SqlDataSource>
            </div>
        <% } %>
            <div>
                <div class="mt-3">
                    <h2>
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </h2>
                </div>
            </div>

            <div>
                <div>
                    <p>
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

            <div class="Product-info">
                <p>Price:</p>
                <p>
                    <asp:Label ID="lblUnitPrice" runat="server" CssClass="bold"></asp:Label>
                </p>
            </div>

            <div class="Product-info">
                <p>
                    <asp:Label ID="lblQuantity" runat="server" Text="Quantity:"></asp:Label>
                </p>
                <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" CssClass="input-field w-50"></asp:TextBox>
                <%--<asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Quantity must be in range from 1 to 20" Display="Dynamic" ControlToValidate="txtQuantity" MaximumValue="20" MinimumValue="1" EnableClientScript="false" CssClass="error-msg"></asp:RangeValidator>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Quantity is required" Display="Dynamic" ControlToValidate="txtQuantity" CssClass="error-msg"></asp:RequiredFieldValidator>
            </div>

        <div class="action-btns d-flex gap-3">
            <asp:Button ID="btnAdd" runat="server" Text="Add to Cart"
                OnClick="btnAdd_Click" CssClass="btn btn-primary" />
            <asp:Button ID="btnCart" runat="server" Text="Go to Cart"
                PostBackUrl="~/Cart" CausesValidation="False" CssClass="btn btn-secondary" />
        </div>
    </div>
</asp:Content>
