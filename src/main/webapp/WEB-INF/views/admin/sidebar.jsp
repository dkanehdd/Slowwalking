<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">관리자페이지</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">



      <!-- Heading -->
    <div class="sidebar-heading">
        Member Management
    </div>
    <!-- Nav Item - Charts -->
    <li class="nav-item">
        <a class="nav-link" href="charts">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>회원정보</span></a>
            
     <!-- Nav Item - Charts -->
    <li class="nav-item">
        <a class="nav-link" href="member?flag=sitter">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Sitter 회원정보</span></a>
    </li>
    <!-- Heading -->
    <div class="sidebar-heading">
        Board Management
    </div>
    <li class="nav-item">
        <a class="nav-link" href="adminnotice?flag=notice">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>공지사항</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="../admin/product">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>상품관리</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
<!-- End of Sidebar -->