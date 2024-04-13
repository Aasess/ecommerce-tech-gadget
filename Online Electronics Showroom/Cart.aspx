<%@ Page title="Tech Gadget - Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Online_Electronics_Showroom.Cart" %>
<%@ MasterType VirtualPath="~/Site.Master" %>


<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="container-banner">
        <p>Shopping Cart</p>
    </div>

    <div class="container mx-auto mt-3">
        <div>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
        </div>
        <div class="cart-info">
            <div>
                <asp:ListBox ID="lstCart" runat="server" CssClass="list-cart"></asp:ListBox>
            </div>

            <div class="cart-actions-btn">
                <div class="remove-btn">
                    <asp:Button ID="btnRemove" runat="server" Text="Remove Item" OnClick="ProductRemove_Click" CssClass="btn btn-secondary" />
                </div>

                <div class="empty-btn">
                    <asp:Button ID="btnEmpty" runat="server" Text="Empty Cart" OnClick="CartEmpty_Click" CssClass="btn btn-danger" />
                </div>
            </div>
        </div>

        <div class="error-label">
            <asp:Label ID="lblErrorMessage" runat="server" EnableViewState="False" CssClass="error-msg"></asp:Label>
        </div>

        <div class="action-btns">
            <div class="continue-shopping">
                <asp:Button ID="btnContinue" runat="server" Text="Continue Shopping" PostBackUrl="~/Products" CssClass="btn btn-secondary" />
            </div>

            <div class="checkout-shopping">
                <asp:Button ID="btnCheckout" runat="server" Text="Checkout" OnClick="BtnCheckOut_Click" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</asp:Content>

