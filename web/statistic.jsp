<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: "Arial", sans-serif;
                background-color: #2c3e50;
                margin: 0;
                padding: 0;
                color: #333;
            }
            .container {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .header,
            .section {
                background-color: #ffffff;
                margin: 20px 0;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }
            .info-box {
                text-align: center;
                padding: 10px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                margin: 10px;
                flex: 1;
                min-width: 150px;
            }
            .info-box p {
                margin: 5px 0;
                font-size: 20px;
                font-weight: bold;
            }
            .info-box .number {
                font-size: 30px;
                font-weight: bold;
                color: #0275d8;
            }
            .section {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }
            .left,
            .right {
                display: inline-block;
                vertical-align: top;
            }
            .left {
                width: 65%;
                padding-right: 20px;
            }
            .right {
                width: 34%;
                padding-left: 20px;
            }
            .chart,
            .feedback,
            .user-list,
            .browser-stats,
            .projects,
            .members,
            .invoices,
            .top-bills,
            .top-products {
                margin: 20px 0;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            h2 {
                margin-bottom: 20px;
                font-size: 30px;
                color: #333;
                text-align: center;
            }
            .user-list table,
            .invoices table,
            .top-bills table,
            .top-products table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            .user-list th,
            .user-list td,
            .invoices th,
            .invoices td,
            .top-bills th,
            .top-bills td,
            .top-products th,
            .top-products td {
                border: 1px solid #ddd;
                padding: 12px;
            }
            .user-list th,
            .invoices th,
            .top-bills th,
            .top-products th {
                background-color: #ffd333;
                font-weight: bold;
                position: relative;
                cursor: pointer;
            }
            .sort-buttons {
                display: inline-flex;
                flex-direction: column;
                margin-left: 5px;
            }
            .sort-buttons i {
                font-size: 12px;
                cursor: pointer;
                user-select: none;
                color: #ccc;
            }
            .sort-buttons .active {
                color: blue;
            }
            .chart,
            .feedback p {
                font-size: 18px;
                margin: 10px 0;
            }
            .feedback p {
                font-size: 24px;
                font-weight: bold;
                color: #5cb85c;
            }
            ul {
                list-style: none;
                padding: 0;
            }
            ul li {
                padding: 8px 0;
            }

            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: #ecf0f1;
                height: 100vh;
                position: fixed;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);

            }

            .sidebar-header {
                background-color: #1a252f;
                padding: 20px;
                text-align: center;
                font-size: 20px;
                font-weight: bold;
                color: #ffd333;
                text-transform: uppercase;
            }

            .sidebar a {
                display: block;
                color: #bdc3c7;
                padding: 15px 20px;
                text-decoration: none;
                border-left: 4px solid transparent;
                transition: all 0.3s ease;
            }

            .sidebar a:hover {
                background-color: #34495e;
                border-left: 4px solid #3498db;
                color: #ecf0f1;
            }
            .header {
                background-color: #fff;
                padding: 15px 20px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                align-items: center;
                justify-content: space-between;
                box-shadow: 0 0px 8px rgba(0, 0, 0, 0.1);
            }


            .header h2 {
                margin: 0;
                color: #2c3e50;
            }

            .header-actions {
                display: flex;
                align-items: center;
            }

            .date-time {
                margin-right: 20px;
                color: #2c3e50;
            }

            .user-info {
                display: flex;
                align-items: center;
            }

            .user-info img {
                border-radius: 50%;
                width: 40px;
                height: 40px;
                margin-right: 10px;
            }
            .sidebar a.logout {
                background-color: red;
                color: #fff;
                text-align: center;
                font-weight: 700;
            }

            .sidebar a.logout:hover {
                background-color: #e74c3c;
                border-left: 4px solid #c0392b;
            }
            .menu-item{
                text-align: center;
            }
        </style>
    </head>
    <body onload="updateTime()">
        <div class="sidebar">
            <div class="sidebar-header">administrator</div>
            <a href="/clothesstore/statistic" class="menu-item">STATICAL</a>
            <a href="DisableAccountADMIN.jsp" class="menu-item"  style="margin-bottom: 32px;">ACCOUNT MANAGEMENT</a>
            <a href="logout" class="menu-item logout">LOG OUT</a>
        </div>
        <div class="container" style="margin-right: 260px">
            <div class="header">
                <h2>STATICAL MANAGEMENT</h2>
                <div class="header-actions">
                    <span class="date-time" style="font-weight: 700"></span>
                    <div class="user-info">
                        <img src="https://static.vecteezy.com/system/resources/previews/000/287/517/original/administration-vector-icon.jpg" alt="User Avatar">
                        <span style="text-transform: uppercase;
                              font-weight: 600;"></span>
                    </div>
                </div>
            </div>
            <div class="header">
                <div class="info-box">
                    <p>Customer</p>
                    <p class="number">${totalAccount}</p>
                </div>
                <div class="info-box">
                    <p>Product</p>
                    <p class="number">${totalProduct}</p>
                </div>
                <div class="info-box">
                    <p>Order</p>
                    <p class="number">${totalOrder}</p>
                </div>
                <div class="info-box">
                    <p>Daily Earnings</p>
                    <p class="number"><fmt:formatNumber value="${daiLyErn}" type="number" pattern="#,##0" /> VND</p>
                </div>
            </div>
            <div class="section">
                <div class="left">
                    <div class="development-activity chart">
                        <h2>Annual Revenue Chart</h2>
                        <canvas id="developmentChart"></canvas>
                    </div>
                </div>
                <div class="right">
                    <div class="chart">
                        <h2>Customer Chart</h2>
                        <canvas id="doughnutChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="user-list">
                <h2>Top 10 Customers Paid</h2>
                <table>
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Username</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Total Bills</th>
                            <th>Total Amount Paid</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="list10AccountPaid" items="${listAccountPaid}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${list10AccountPaid.username}</td>
                                <td>${list10AccountPaid.name}</td>
                                <td>${list10AccountPaid.email}</td>
                                <td>${list10AccountPaid.address}</td>
                                <td>${list10AccountPaid.totalBill}
                                <td><fmt:formatNumber value="${list10AccountPaid.totalAmount}" type="number" pattern="#,##0" /> VND</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="top-bills">
                <h2>Top 10 Highest-Value Bills</h2>
                <table>
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Bill ID</th>
                            <th>Customer Username</th>
                            <th>Amount</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="list10Bill" items="${listBillTopValue}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${list10Bill.billID}</td>
                                <td>${list10Bill.username}</td>
                                <td><fmt:formatNumber value="${list10Bill.amount}" type="number" pattern="#,##0" /> VND</td>
                                <td>${list10Bill.date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="top-products">
                <h2>Top 20 Most Purchased Products</h2>
                <table>
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Product</th>
                            <th>Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Price</th>
                            <th>Qty Sold</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="list20Product" items="${top20Product}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><img src="${list20Product.imageURL}" alt="imgProduct" style="width: 100px; height: 100px; margin-left: 125px;"></td>
                                <td>${list20Product.name}</td>
                                <td>${list20Product.color_name}</td>
                                <td>${list20Product.size_name}</td>
                                <td><fmt:formatNumber value="${list20Product.price}" type="number" pattern="#,##0" /> VND</td>
                                <td><fmt:formatNumber value="${list20Product.quantity}" type="number" pattern="#,##0" /></td>                               
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <%
        double[] revenueMonth = (double[]) request.getAttribute("revenueMonth");
        int totalAcctive = (int) request.getAttribute("totalAcctive");
        int totalDeacctive = (int) request.getAttribute("totalDeacctive");
        int totalAccounts = totalAcctive + totalDeacctive;
        double percentActive = ((double) totalAcctive / totalAccounts) * 100;
        double percentDeactive = ((double) totalDeacctive / totalAccounts) * 100;
        %>
        <script>
        var revenueMonth = <%= Arrays.toString(revenueMonth) %>;
        var ctx1 = document.getElementById("developmentChart").getContext("2d");
        var developmentChart = new Chart(ctx1, {
            type: "line",
            data: {
                labels: [
                    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                ],
                datasets: [
                    {
                        label: "Revenue",
                        data: revenueMonth,
                        borderColor: "rgba(2, 117, 216, 1)",
                        backgroundColor: "rgba(2, 117, 216, 0.2)",
                        fill: true,
                        lineTension: 0.1,
                    }
                ],
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        onClick: null,
                    }
                },
                scales: {
                    x: {
                        display: true,
                        title: {
                            display: true,
                            text: "Month",
                        },
                    },
                    y: {
                        display: true,
                        title: {
                            display: true,
                            text: "Revenue",
                        },
                    },
                },
            },
        });
        var totalAcctive = <%= totalAcctive %>;
        var totalDeacctive = <%= totalDeacctive %>;
        var totalAccounts = <%= totalAccounts %>;
        var percentActive = <%= percentActive %>.toFixed(2);
        var percentDeactive = <%= percentDeactive %>.toFixed(2);
        var ctx2 = document.getElementById("doughnutChart").getContext("2d");
        var doughnutChart = new Chart(ctx2, {
            type: "doughnut",
            data: {
                labels: ["ACTIVATE: " + totalAcctive + "/" + totalAccounts + " Customer", "DEACTIVATE: " + totalDeacctive + "/" + totalAccounts + " Customer"],
                datasets: [
                    {
                        data: [percentActive, percentDeactive],
                        backgroundColor: ["#5cb85c", "#d9534f"],
                        hoverBackgroundColor: ["#4cae4c", "#d9534f"],
                        borderWidth: 1,
                    },
                ],
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: "top",
                        onClick: null
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.raw + '%';
                            }
                        }
                    }
                },
            },

        });
        function updateTime() {
            var now = new Date();
            var options = {
                weekday: 'short',
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            };
            var dateTimeElements = document.querySelectorAll('.date-time');
            dateTimeElements.forEach(function (element) {
                element.innerText = now.toLocaleString('en-US', options);
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            updateTime();
            setInterval(updateTime, 1000);
        });
        </script>
    </body>
</html>

