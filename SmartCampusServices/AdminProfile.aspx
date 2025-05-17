<%@ Page Title="Admin Profile" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="SmartCampusServices.AdminProfile" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<style>

        body {

            background-color: #f7f9fc;

        }
 
        .profile-card {

            max-width: 600px;

            margin: 100px auto;

            border-radius: 10px;

            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);

            background-color: #ffffff;

        }
 
        .profile-card h2 {

            margin-bottom: 20px;

            font-weight: 600;

            color: #333346;

        }
 
        .profile-card .form-control {

            border-radius: 5px;

        }
 
        .btn-primary {

            background-color: #333346;

            border: none;

        }
 
        .btn-primary:hover {

            background-color: #4a4a69;

        }
 
        .form-label {

            font-weight: 500;

        }
</style>
</asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container">
<div class="card profile-card p-4">
<div class="card-body">
<h2 class="text-center"><i class="fas fa-user-shield"></i> Admin Profile</h2>
 
                <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
 
                <div class="mb-3">
<label class="form-label">Full Name</label>
<div class="input-group">
<span class="input-group-text"><i class="fas fa-user"></i></span>
<asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
</div>
</div>
 
                <div class="mb-3">
<label class="form-label">Email Address</label>
<div class="input-group">
<span class="input-group-text"><i class="fas fa-envelope"></i></span>
<asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
</div>
</div>
 
                <div class="mb-3">
<label class="form-label">Role</label>
<div class="input-group">
<span class="input-group-text"><i class="fas fa-user-tag"></i></span>
<asp:TextBox ID="txtRole" runat="server" CssClass="form-control" ReadOnly="true" Text="Admin"></asp:TextBox>
</div>
</div>
 
                <div class="mb-3">
<label class="form-label">New Password</label>
<div class="input-group">
<span class="input-group-text"><i class="fas fa-lock"></i></span>
<asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
</div>
</div>
 
                <div class="mb-3">
<label class="form-label">Confirm Password</label>
<div class="input-group">
<span class="input-group-text"><i class="fas fa-lock"></i></span>
<asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
</div>
</div>
 
                
</div>
</asp:Content>

 