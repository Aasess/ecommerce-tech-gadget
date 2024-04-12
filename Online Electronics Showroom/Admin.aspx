<%@ Page title="Tech Gadget - Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Online_Electronics_Showroom.Admin" %>
<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="container-banner">
        <p>Admin Panel</p>
    </div>

    <div class="container">
        <div class="form-group d-flex align-items-baseline w-50">
            <asp:Label ID="lblCategory" runat="server" Text="Choose a category:" CssClass="w-50"></asp:Label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="true" 
                DataSourceID="sdsCategorys" DataTextField="longName" DataValueField="categoryID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsCategorys" runat="server" ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                SelectCommand="SELECT [categoryID], [shortName], [longName] FROM [Category]"
                UpdateCommand="UPDATE [Category] SET [shortName] = @shortName, [longName] = @longName WHERE [categoryID] = @categoryID"
                DeleteCommand="DELETE FROM [Category] WHERE [categoryID] = @categoryID">
                <UpdateParameters>
                    <asp:Parameter Name="shortName" Type="String" />
                    <asp:Parameter Name="longName" Type="String" />
                    <asp:Parameter Name="categoryID" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="categoryID" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>

        </div>
            <!-- Validation Controls -->
            <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" 
                CssClass="text-danger" ErrorMessage="Please choose a category" InitialValue="" 
                ValidationGroup="group1">
            </asp:RequiredFieldValidator>

        <%--book listing based on Category--%>
        <div>
            <div class="col-12">
                <asp:DataList ID="dlProducts" runat="server"
                    DataKeyField="ProductID" DataSourceID="SqlDataSource2"
                    CssClass="table table-bordered table-striped table-condensed">
                    <HeaderTemplate>

                        <span class="d-inline-block fw-bold" style="width: 40px">ID</span>
                        <span class="w-50 d-inline-block fw-bold">Book Name</span>
                        <span class="w-25 d-inline-block text-right fw-bold">Unit Price</span>
                        <span class="d-inline-block text-right fw-bold" style="width: 90px">On Hand</span>
                    </HeaderTemplate>
                    <ItemTemplate>

                        <span class="d-inline-block" style="width: 40px"><%# Eval("ProductID") %></span>
                        <span class="w-50 d-inline-block"><%# Eval("Name") %></span>
                        <span class="w-25 d-inline-block text-right"><%# Eval("UnitPrice", "{0:C}") %></span>
                        <span class="d-inline-block text-right" style="width: 90px"><%# Eval("Quantity") %></span>
                    </ItemTemplate>
                </asp:DataList>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT [ProductID], [Name], [UnitPrice], [Quantity]
FROM [Products] WHERE ([categoryID] = @categoryID) 
ORDER BY [ProductID]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCategory" Name="categoryID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>

        <%--list categories--%>
        <div class="container mt-5">
            <h3 class="mb-2">Category Maintenance</h3>
            <div class="col-12">
                <asp:GridView runat="server" DataSourceID="SqlDataSource1" ID="GridViewCategory" CssClass="table table-bordered table-striped table-condensed" AutoGenerateColumns="False" DataKeyNames="categoryID" OnRowDeleted="GridViewCategory_RowDeleted" OnRowUpdated="GridViewCategory_RowUpdated" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="categoryID" HeaderText="Category ID" ReadOnly="True" SortExpression="categoryID"></asp:BoundField>
                        <asp:BoundField DataField="ShortName" HeaderText="Short Name" SortExpression="ShortName"></asp:BoundField>
                        <asp:BoundField DataField="LongName" HeaderText="Long Name" SortExpression="LongName"></asp:BoundField>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                    </Columns>
                </asp:GridView>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT * FROM [Category]"
                    DeleteCommand="DELETE FROM [Category] WHERE [categoryID] = @categoryID"
                    InsertCommand="INSERT INTO [Category] ([ShortName], [LongName]) VALUES (@ShortName, @LongName)"
                    UpdateCommand="UPDATE [Category] SET [ShortName] = @ShortName, [LongName] = @LongName WHERE [categoryID] = @categoryID">
                    <DeleteParameters>
                        <asp:Parameter Name="categoryID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ShortName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="LongName" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ShortName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="LongName" Type="String"></asp:Parameter>
                        <asp:Parameter Name="categoryID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>

            </div>

        </div>

        <%--add categories--%>
        <div class="container mt-3">
            <div class="form-group">
                <p>To create a new category, enter the category information and click Add New Category</p>
                <div class="col-sm-4 d-flex align-items-center">
                    <label for="addcategoryID" class="d-inline-block w-50">Category ID</label>
                    <asp:TextBox ID="addcategoryID" runat="server" MaxLength="10" CssClass="form-control" TextMode="Number"></asp:TextBox>
                </div>
                <div class="col-sm-4">
                    <asp:CustomValidator ID="cvcategoryIDExists" runat="server" ControlToValidate="addcategoryID" CssClass="text-danger"
                        OnServerValidate="cvCategoryIdExists_ServerValidate" ErrorMessage="Category ID already exists" ValidationGroup="group1">
                    </asp:CustomValidator>
                    <asp:RequiredFieldValidator ID="rfvcategoryID" runat="server" ControlToValidate="addcategoryID" CssClass="text-danger"
                        ErrorMessage="Category ID is a required field" ValidationGroup="group1">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-4 d-flex align-items-center">
                    <label for="addCategoryShortName" class="d-inline-block w-50">Short Name</label>
                    <asp:TextBox ID="addCategoryShortName" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-sm-4">
                    <asp:RequiredFieldValidator ID="rfvShortName" runat="server" ControlToValidate="addCategoryShortName" CssClass="text-danger"
                        ErrorMessage="Short Name is a required field" ValidationGroup="group1">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-4 d-flex align-items-center">
                    <label for="addCategoryLongName" class="d-inline-block w-50">Long Name</label>
                    <asp:TextBox ID="addCategoryLongName" runat="server" MaxLength="255" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-sm-4">
                    <asp:RequiredFieldValidator ID="rfvLongName" runat="server" ControlToValidate="addCategoryLongName" CssClass="text-danger"
                        ErrorMessage="Long Name is a required field" ValidationGroup="group1">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-8 col-sm-4">
                    <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" CssClass="btn btn-primary" OnClick="btnAddCategory_Click" ValidationGroup="group1" />
                </div>
            </div>
        </div>

        <div class="form-group mt-5">
            <h3>Listing of all Products</h3>
            <div class="col-xs-12  col-sm-12 mt-4">
                <asp:GridView runat="server" AutoGenerateColumns="False"
                    DataKeyNames="ProductID" DataSourceID="SqlDataSource5"
                    CssClass="table table-bordered table-striped table-condensed"
                    ID="ctl02" AllowPaging="True" PagerStyle-CssClass="custom-pagination"
                    OnSelectedIndexChanged="ctl02_SelectedIndexChanged" AutoPostBack="True">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ProductID"
                            ReadOnly="True" SortExpression="ProductID">
                            <ItemStyle CssClass="col-xs-2" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Name"
                            SortExpression="Name">
                            <ItemStyle CssClass="col-xs-4" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Category" HeaderText="Category"
                            SortExpression="Category">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>
                        <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                    </Columns>

                    <PagerStyle CssClass="custom-pagination" BackColor="#CCCCCC" Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                </asp:GridView>
                <asp:DetailsView runat="server" Width="726px" Height="50px"
                    AutoGenerateRows="False" DataSourceID="SqlDataSource8"
                    CssClass="table table-bordered table-condensed"
                    ID="ctl03" DataKeyNames="ProductID" 
                    OnItemUpdated="ctl03_ItemUpdated" 
                    OnItemDeleted="ctl03_ItemDeleted" 
                    OnItemCreated="ctl03_ItemAdded">
                    <Fields>
                        <asp:BoundField DataField="ProductID" HeaderText="ProductID"
                            ReadOnly="True" SortExpression="ProductID"></asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                        <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author"></asp:BoundField>
                        <asp:BoundField DataField="PublishedYear" HeaderText="PublishedYear" SortExpression="PublishedYear"></asp:BoundField>

                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <%# Eval("Category") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="SqlDataSourceCategory" DataTextField="LongName" DataValueField="categoryID" SelectedValue='<%# Bind("categoryID") %>'></asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice"></asp:BoundField>
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity"></asp:BoundField>

                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True"></asp:CommandField>
                    </Fields>
                </asp:DetailsView>
                <!-- DataSource for Category dropdown -->
                <asp:SqlDataSource runat="server" ID="SqlDataSourceCategory"
                    ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT [categoryID], [LongName] FROM [Category]"></asp:SqlDataSource>

                <asp:SqlDataSource runat="server" ID="SqlDataSource8"
                    ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT b.*, g.[LongName] as Category FROM [Products] b INNER JOIN [Category] g ON b.[categoryID] = g.[categoryID] WHERE [ProductID] = @ProductID"
                    DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = @ProductID"
                    InsertCommand="INSERT INTO [Products] ([Name], [Author], [PublishedYear], [categoryID], [Description], [UnitPrice], [Quantity]) VALUES (@Name, @Author, @PublishedYear, @categoryID, @Description, @UnitPrice, @Quantity)"
                    UpdateCommand="UPDATE [Products] SET [Name] = @Name, [Author] = @Author, [PublishedYear] = @PublishedYear, [categoryID] = @categoryID, [Description] = @Description, [UnitPrice] = @UnitPrice, [Quantity] = @Quantity WHERE [ProductID] = @ProductID">
                    <DeleteParameters>
                        <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Author" Type="String"></asp:Parameter>
                        <asp:Parameter Name="PublishedYear" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="categoryID" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                        <asp:Parameter Name="UnitPrice" Type="Decimal"></asp:Parameter>
                        <asp:Parameter Name="Quantity" Type="Int32"></asp:Parameter>
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="Author" Type="String"></asp:Parameter>
                        <asp:Parameter Name="PublishedYear" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="categoryID" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                        <asp:Parameter Name="UnitPrice" Type="Decimal"></asp:Parameter>
                        <asp:Parameter Name="Quantity" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ctl02" Name="ProductID" PropertyName="SelectedValue" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource runat="server" ID="SqlDataSource5" ConnectionString="<%$ ConnectionStrings:ProductStoreCollection %>"
                    SelectCommand="SELECT b.[ProductID], b.[Name], g.[LongName] as Category FROM [Products] b INNER JOIN [Category] g ON b.[categoryID] = g.[categoryID]">
                    
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

