<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
        <meta name="author" content="AdminKit">
        <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

        <link rel="canonical" href="tables-bootstrap.html" />

        <title>Tables | AdminKit Demo</title>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

        <!-- Choose your prefered color scheme -->
        <!-- <link href="css/light.css" rel="stylesheet"> -->
        <!-- <link href="css/dark.css" rel="stylesheet"> -->

        <!-- BEGIN SETTINGS -->
        <!-- Remove this after purchasing -->
        <link class="js-stylesheet" href="${pageContext.request.contextPath}/css/light.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/js/settings.js"></script>
        <style>body {
                opacity: 0;
            }
        </style>
        <!-- END SETTINGS -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-120946860-10"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());

            gtag('config', 'UA-120946860-10', {'anonymize_ip': true});
        </script></head>
    <!--
      HOW TO USE: 
      data-theme: default (default), dark, light, colored
      data-layout: fluid (default), boxed
      data-sidebar-position: left (default), right
      data-sidebar-layout: default (default), compact
    -->

    <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
        <div class="wrapper">
            <nav id="sidebar" class="sidebar js-sidebar">
                <div class="sidebar-content js-simplebar">
                    <a class="sidebar-brand" href="index.html">
                        <span class="sidebar-brand-text align-middle">
                            Shop Owner
                            <sup><small class="badge bg-primary text-uppercase">Pro</small></sup>
                        </span>
                        <svg class="sidebar-brand-icon align-middle" width="32px" height="32px" viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="1.5"
                             stroke-linecap="square" stroke-linejoin="miter" color="#FFFFFF" style="margin-left: -3px">
                        <path d="M12 4L20 8.00004L12 12L4 8.00004L12 4Z"></path>
                        <path d="M20 12L12 16L4 12"></path>
                        <path d="M20 16L12 20L4 16"></path>
                        </svg>
                    </a>

                    <div class="sidebar-user">
                        <div class="d-flex justify-content-center">
                            <div class="flex-shrink-0">
                                <img src="img/avatars/avatar.jpg" class="avatar img-fluid rounded me-1" alt="Charles Hall" />
                            </div>
                            <div class="flex-grow-1 ps-2">
                                <a class="sidebar-user-title dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                    ${sessionScope.user.fullName}
                                </a>
                                <div class="dropdown-menu dropdown-menu-start">
                                    <a class="dropdown-item" href="pages-profile.html"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                                    <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="pie-chart"></i> Analytics</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="pages-settings.html"><i class="align-middle me-1" data-feather="settings"></i> Settings &
                                        Privacy</a>
                                    <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="help-circle"></i> Help Center</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Log out</a>
                                </div>

                                <div class="sidebar-user-subtitle">Designer</div>
                            </div>
                        </div>
                    </div>

                    <ul class="sidebar-nav">
                        <li class="sidebar-header">
                            Pages
                        </li>

                        <li class="sidebar-item active">
                            <a class="sidebar-link" href="tables-bootstrap.html">
                                <i class="align-middle" data-feather="list"></i> <span class="align-middle">Products</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <div class="main">
                <nav class="navbar navbar-expand navbar-light navbar-bg">
                    <a class="sidebar-toggle js-sidebar-toggle">
                        <i class="hamburger align-self-center"></i>
                    </a>

                    <form class="d-none d-sm-inline-block">
                        <div class="input-group input-group-navbar">
                            <input type="text" class="form-control" placeholder="Search…" aria-label="Search">
                            <button class="btn" type="button">
                                <i class="align-middle" data-feather="search"></i>
                            </button>
                        </div>
                    </form>

                    <div class="navbar-collapse collapse">
                        <ul class="navbar-nav navbar-align">
                            <li class="nav-item dropdown">
                                <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
                                    <div class="position-relative">
                                        <i class="align-middle" data-feather="bell"></i>
                                        <span class="indicator">4</span>
                                    </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
                                    <div class="dropdown-menu-header">
                                        4 New Notifications
                                    </div>
                                    <div class="list-group">
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-danger" data-feather="alert-circle"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Update completed</div>
                                                    <div class="text-muted small mt-1">Restart server 12 to complete the update.</div>
                                                    <div class="text-muted small mt-1">30m ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-warning" data-feather="bell"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Lorem ipsum</div>
                                                    <div class="text-muted small mt-1">Aliquam ex eros, imperdiet vulputate hendrerit et.</div>
                                                    <div class="text-muted small mt-1">2h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-primary" data-feather="home"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Login from 192.186.1.8</div>
                                                    <div class="text-muted small mt-1">5h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-success" data-feather="user-plus"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">New connection</div>
                                                    <div class="text-muted small mt-1">Christina accepted your request.</div>
                                                    <div class="text-muted small mt-1">14h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="dropdown-menu-footer">
                                        <a href="#" class="text-muted">Show all notifications</a>
                                    </div>
                                </div>
                            </li>

                            <li class="nav-item">
                                <a class="nav-icon js-fullscreen d-none d-lg-block" href="#">
                                    <div class="position-relative">
                                        <i class="align-middle" data-feather="maximize"></i>
                                    </div>
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-icon pe-md-0 dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                    <img src="img/avatars/avatar.jpg" class="avatar img-fluid rounded" alt="Charles Hall" />
                                </a>
                                <div class="dropdown-menu dropdown-menu-end">
                                    <a class="dropdown-item" href="pages-profile.html"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                                    <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="pie-chart"></i> Analytics</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="pages-settings.html"><i class="align-middle me-1" data-feather="settings"></i> Settings &
                                        Privacy</a>
                                    <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="help-circle"></i> Help Center</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Log out</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <main class="content">
                    <div class="container-fluid p-0">

                        <h1 class="h3 mb-3">Products Manager</h1>

                        <div class="row">
                            <div class="col-12 col-xl-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title">Basic Table</h5>
                                        <h6 class="card-subtitle text-muted">Using the most basic table markup, here’s how .table-based tables look in Bootstrap.
                                        </h6>
                                    </div>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th style="width:40%;">Name</th>
                                                <th style="width:25%">Phone Number</th>
                                                <th class="d-none d-md-table-cell" style="width:25%">Date of Birth</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Vanessa Tucker</td>
                                                <td>864-348-0485</td>
                                                <td class="d-none d-md-table-cell">June 21, 1961</td>
                                                <td class="table-action">
                                                    <a href="#"><i class="align-middle" data-feather="edit-2"></i></a>
                                                    <a href="#"><i class="align-middle" data-feather="trash"></i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>William Harris</td>
                                                <td>914-939-2458</td>
                                                <td class="d-none d-md-table-cell">May 15, 1948</td>
                                                <td class="table-action">
                                                    <a href="#"><i class="align-middle" data-feather="edit-2"></i></a>
                                                    <a href="#"><i class="align-middle" data-feather="trash"></i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Sharon Lessman</td>
                                                <td>704-993-5435</td>
                                                <td class="d-none d-md-table-cell">September 14, 1965</td>
                                                <td class="table-action">
                                                    <a href="#"><i class="align-middle" data-feather="edit-2"></i></a>
                                                    <a href="#"><i class="align-middle" data-feather="trash"></i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Christina Mason</td>
                                                <td>765-382-8195</td>
                                                <td class="d-none d-md-table-cell">April 2, 1971</td>
                                                <td class="table-action">
                                                    <a href="#"><i class="align-middle" data-feather="edit-2"></i></a>
                                                    <a href="#"><i class="align-middle" data-feather="trash"></i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Robin Schneiders</td>
                                                <td>202-672-1407</td>
                                                <td class="d-none d-md-table-cell">October 12, 1966</td>
                                                <td class="table-action">
                                                    <a href="#"><i class="align-middle" data-feather="edit-2"></i></a>
                                                    <a href="#"><i class="align-middle" data-feather="trash"></i></a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </main>

                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row text-muted">
                            <div class="col-6 text-start">
                                <p class="mb-0">
                                    <a href="https://adminkit.io/" target="_blank" class="text-muted"><strong>AdminKit</strong></a> &copy;
                                </p>
                            </div>
                            <div class="col-6 text-end">
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Support</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Help Center</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Privacy</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Terms</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/app.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function (event) {
                setTimeout(function () {
                    if (localStorage.getItem('popState') !== 'shown') {
                        window.notyf.open({
                            type: "success",
                            message: "Get access to all 500+ components and 45+ pages with AdminKit PRO. <u><a class=\"text-white\" href=\"https://adminkit.io/pricing\" target=\"_blank\">More info</a></u> 🚀",
                            duration: 10000,
                            ripple: true,
                            dismissible: false,
                            position: {
                                x: "left",
                                y: "bottom"
                            }
                        });

                        localStorage.setItem('popState', 'shown');
                    }
                }, 15000);
            });
        </script></body>

</html>