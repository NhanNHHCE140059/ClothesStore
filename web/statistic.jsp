<%-- 
    Document   : statistic
    Created on : Jul 16, 2024, 4:46:12 PM
    Author     : Nguyen Thanh Thien - CE171253
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            }
            .info-box .number {
                font-size: 24px;
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
                font-size: 20px;
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
            img {
                width: 100px; 
                height: 100px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="info-box">
                    <p>Customer</p>
                    <p class="number">43</p>
                    <p style="color: green">6% ↑</p>
                </div>
                <div class="info-box">
                    <p>Product</p>
                    <p class="number">17</p>
                    <p style="color: red">3% ↓</p>
                </div>
                <div class="info-box">
                    <p>Order</p>
                    <p class="number">7</p>
                    <p style="color: green">9% ↑</p>
                </div>
                <div class="info-box">
                    <p>Daily Earnings</p>
                    <p class="number">27.3K</p>
                    <p style="color: green">3% ↑</p>
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
                <h2>Top 10 Customers</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Total Bills</th>
                            <th>Total Amount Paid</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>tokuda1</td>
                            <td>Tokuda</td>
                            <td>tokuda@jav.com</td>
                            <td>JAV HD</td>
                            <td>10</td>
                            <td>1.000.000 đ</td>
                        </tr>
                        <tr>
                            <td>motocute</td>
                            <td>Hashimoto</td>
                            <td>hashimotocuteee@jav.com</td>
                            <td>Osaka, Japan</td>
                            <td>8</td>
                            <td>800.000 đ</td>
                        </tr>
                        <tr>
                            <td>hihi69</td>
                            <td>Maria Ozawa</td>
                            <td>mariaoki@porn.com</td>
                            <td>Tokyo</td>
                            <td>7</td>
                            <td>700.000 đ</td>
                        </tr>
                        <tr>
                            <td>user4</td>
                            <td>Alice Brown</td>
                            <td>alice@example.com</td>
                            <td>101 Maple St</td>
                            <td>6</td>
                            <td>600.000 đ</td>
                        </tr>
                        <tr>
                            <td>user5</td>
                            <td>Charlie White</td>
                            <td>charlie@example.com</td>
                            <td>202 Birch St</td>
                            <td>5</td>
                            <td>500.000 đ</td>
                        </tr>
                        <tr>
                            <td>user6</td>
                            <td>David Black</td>
                            <td>david@example.com</td>
                            <td>303 Cedar St</td>
                            <td>4</td>
                            <td>400.000 đ</td>
                        </tr>
                        <tr>
                            <td>user7</td>
                            <td>Eva Green</td>
                            <td>eva@example.com</td>
                            <td>404 Elm St</td>
                            <td>3</td>
                            <td>300.000 đ</td>
                        </tr>
                        <tr>
                            <td>user8</td>
                            <td>Frank Blue</td>
                            <td>frank@example.com</td>
                            <td>505 Willow St</td>
                            <td>2</td>
                            <td>200.000 đ</td>
                        </tr>
                        <tr>
                            <td>user9</td>
                            <td>Grace Red</td>
                            <td>grace@example.com</td>
                            <td>606 Ash St</td>
                            <td>1</td>
                            <td>150.000 đ</td>
                        </tr>
                        <tr>
                            <td>user10</td>
                            <td>Henry Gold</td>
                            <td>henry@example.com</td>
                            <td>707 Fir St</td>
                            <td>1</td>
                            <td>100.000 đ</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="top-bills">
                <h2>Top 10 Highest-Value Bills</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Bill ID</th>
                            <th>Customer Username</th>
                            <th>Amount</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>bill001</td>
                            <td>tokuda1</td>
                            <td>300.000 đ</td>
                            <td>2024-01-15</td>
                        </tr>
                        <tr>
                            <td>bill002</td>
                            <td>motocute</td>
                            <td>250.000 đ</td>
                            <td>2024-02-10</td>
                        </tr>
                        <tr>
                            <td>bill003</td>
                            <td>hihi69</td>
                            <td>200.000 đ</td>
                            <td>2024-03-05</td>
                        </tr>
                        <tr>
                            <td>bill004</td>
                            <td>user4</td>
                            <td>180.000 đ</td>
                            <td>2024-04-18</td>
                        </tr>
                        <tr>
                            <td>bill005</td>
                            <td>user5</td>
                            <td>160.000 đ</td>
                            <td>2024-05-22</td>
                        </tr>
                        <tr>
                            <td>bill006</td>
                            <td>user6</td>
                            <td>140.000 đ</td>
                            <td>2024-06-15</td>
                        </tr>
                        <tr>
                            <td>bill007</td>
                            <td>user7</td>
                            <td>130.000 đ</td>
                            <td>2024-07-01</td>
                        </tr>
                        <tr>
                            <td>bill008</td>
                            <td>user8</td>
                            <td>120.000 đ</td>
                            <td>2024-07-07</td>
                        </tr>
                        <tr>
                            <td>bill009</td>
                            <td>user9</td>
                            <td>110.000 đ</td>
                            <td>2024-07-08</td>
                        </tr>
                        <tr>
                            <td>bill010</td>
                            <td>user10</td>
                            <td>100.000 đ</td>
                            <td>2024-07-08</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="top-products">
                <h2>Top 20 Most Purchased Products</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Name <div class="sort-buttons"><i class="fas fa-sort-up"></i><i class="fas fa-sort-down"></i></div></th>
                            <th>Color <div class="sort-buttons"><i class="fas fa-sort-up"></i><i class="fas fa-sort-down"></i></div></th>
                            <th>Size <div class="sort-buttons"><i class="fas fa-sort-up"></i><i class="fas fa-sort-down"></i></div></th>
                            <th>Price <div class="sort-buttons"><i class="fas fa-sort-up"></i><i class="fas fa-sort-down"></i></div></th>
                            <th>Qty <div class="sort-buttons"><i class="fas fa-sort-up"></i><i class="fas fa-sort-down"></i></div></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><img src="./ImageSWP/product10-1.jfif" alt="Product A Image" /></td>
                            <td>Product AA</td>
                            <td>Black</td>
                            <td>M</td>
                            <td>$1000</td>
                            <td>150</td>
                        </tr>
                        <tr>
                            <td><img src="./ImageSWP/product10-2.jfif" alt="Product B Image" /></td>
                            <td>Product BB</td>
                            <td>Brown</td>
                            <td>S</td>
                            <td>$900</td>
                            <td>140</td>
                        </tr>
                        <tr>
                            <td><img src="./ImageSWP/product10-3.jfif" alt="Product C Image" /></td>
                            <td>Product C</td>
                            <td>Gray</td>
                            <td>L</td>
                            <td>$1000</td>
                            <td>130</td>
                        </tr>
                        <tr>
                            <td><img src="product_image_url_4" alt="Product D Image" /></td>
                            <td>Product D by Vicki M. Coleman</td>
                            <td>Blue</td>
                            <td>M</td>
                            <td>$1000</td>
                            <td>120</td>
                        </tr>
                        <tr>
                            <td><img src="product_image_url_5" alt="Product E Image" /></td>
                            <td>Product E by Erik L. Richards</td>
                            <td>Orange</td>
                            <td>M</td>
                            <td>$100</td>
                            <td>110</td>
                        </tr>
                        <!-- Add more rows as needed -->
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            var ctx1 = document.getElementById("developmentChart").getContext("2d");
            var developmentChart = new Chart(ctx1, {
                type: "line",
                data: {
                    labels: [
                        "Jan",
                        "Feb",
                        "Mar",
                        "Apr",
                        "May",
                        "Jun",
                        "Jul",
                        "Aug",
                        "Sep",
                        "Oct",
                        "Nov",
                        "Dec",
                    ],
                    datasets: [
                        {
                            label: "Revenue",
                            data: [10, 15, 9, 14, 20, 24, 19, 22, 18, 24, 28, 26],
                            borderColor: "rgba(2, 117, 216, 1)",
                            backgroundColor: "rgba(2, 117, 216, 0.2)",
                            fill: true,
                            lineTension: 0.1,
                        },
                    ],
                },
                options: {
                    responsive: true,
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

            var ctx2 = document.getElementById("doughnutChart").getContext("2d");
            var doughnutChart = new Chart(ctx2, {
                type: "doughnut",
                data: {
                    labels: ["ACTIVATE", "DEACTIVATE"],
                    datasets: [
                        {
                            data: [63, 37],
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
                        },
                    },
                },
            });

            // Sorting functionality
            const getCellValue = (tr, idx) => tr.children[idx].innerText || tr.children[idx].textContent;

            const comparer = (idx, asc) => (a, b) => ((v1, v2) => 
                v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
                )(getCellValue(asc ? a : b, idx), getCellValue(asc ? b : a, idx));

            document.querySelectorAll('.top-products th').forEach(th => th.addEventListener('click', (() => {
                const table = th.closest('table');
                Array.from(table.querySelectorAll('tr:nth-child(n+2)'))
                    .sort(comparer(Array.from(th.parentNode.children).indexOf(th), this.asc = !this.asc))
                    .forEach(tr => table.appendChild(tr) );

                // Update sort button styles
                const sortButtons = th.querySelector('.sort-buttons');
                if (sortButtons) {
                    document.querySelectorAll('.sort-buttons i').forEach(icon => icon.classList.remove('active'));
                    if (this.asc) {
                        sortButtons.querySelector('.fa-sort-up').classList.add('active');
                    } else {
                        sortButtons.querySelector('.fa-sort-down').classList.add('active');
                    }
                }
            })));
        </script>
    </body>
</html>

