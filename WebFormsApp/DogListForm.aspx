<%@ Page Title="Dog List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DogListForm.aspx.cs" Inherits="WebFormsApp.WebForm1" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Dog List</h2>
    <asp:GridView ID="DogGrid"
        runat="server"
        ItemType="WebFormsApp.Dog"
        SelectMethod="GetDogs"
        UpdateMethod="UpdateDog"
        DeleteMethod="DeleteDog"
        AutoGenerateColumns="false"
        DataKeyNames="ID, Owner, Name, Gender"
        CssClass="table table-responsive" 
        OnRowCommand="DogGrid_RowCommand"
        ShowFooter="true">
        <Columns>
            <asp:TemplateField HeaderText="Owner">
                <ItemTemplate>
                    <asp:Label runat="server"><%# Item.Owner %></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="AddOwnerTextBox" runat="server" Text="<%# BindItem.Owner %>" cssClass="form-control"></asp:TextBox>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Dog">
                <ItemTemplate>
                    <asp:Label runat="server"><%# Item.Name %></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server"  ID="NameTextBox" Text="<%# BindItem.Name %>" CssClass="form-control" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="AddNameTextBox" runat="server" Text="<%# BindItem.Owner %>" CssClass="form-control"></asp:TextBox>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Gender">
                <ItemTemplate>
                    <asp:Label runat="server"><%# Item.Gender ?? "Unknown" %></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <!-- Must have a blank value in list in case value is null or blank, otherwise it'll throw an exception if selected value is not in list -->
                    <asp:DropDownList runat="server" ID="GenderDropDownList" CssClass="form-control" SelectedValue="<%# BindItem.Gender %>">
                        <asp:ListItem Text="Selected Gender" Value=""></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList runat="server" 
                        ID="AddGenderDropDownList" 
                        CssClass="form-control" 
                        SelectedValue="<%# BindItem.Gender %>" 
                        SelectMethod="GetGenderOptions"
                        DataTextField="Key"
                        DataValueField="Value" >
                    </asp:DropDownList>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-warning" />
                    <asp:Button runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" OnClientClick="return ConfirmDelete()" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button runat="server" CommandName="Update" Text="Update" CssClass="btn btn-success" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" CommandName="Insert" Text="Add" CssClass="btn btn-primary" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <script>
        function ConfirmDelete() {
            return confirm("Are you sure you want to delete the record?");
        }
    </script>
</asp:Content>
