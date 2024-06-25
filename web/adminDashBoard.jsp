<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashBoardAdmin.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">administrator</div>
            <a href="#" class="menu-item">STATICAL</a>
            <a href="#" class="menu-item">ACCOUNT MANAGEMENT</a>
        </div>

        <div class="content">
            <div class="header">
                <h2>ACCOUNT MANAGEMENT</h2>
                <div class="header-actions">
                    <span class="date-time">Sat, 10 Oct 2020 at 10:00 AM</span>
                    <div class="user-info">
                        <img src="https://th.bing.com/th/id/OIP.ItvA9eX1ZIYT8NHePqeuCgAAAA?rs=1&pid=ImgDetMain" alt="User Avatar">
                        <span>Johnny Vino</span>
                    </div>
                </div>
            </div>

            <div class="filters">
                <div class="search-container">
                    <input type="text" placeholder="Search...">
                    <button class="search-button"><i class="icon-search"></i></button>
                </div>
                <button class="filter-button">Show Active Accounts</button>
                <button class="filter-button">Show Deactivated Accounts</button>
                <button class="filter-button">Show All Accounts</button>
            </div>

            <table class="account-table">
                <thead>
                    <tr>
                        <th>Action</th>
                        <th>Name</th>
                        <th>Account Type</th>
                        <th>Mobile</th>
                        <th>Username</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody class="content-table">
                    <tr>
                        <td>
                            <button class="deactivate-button">Deactivate</button>
                        </td>
                        <td>Alexandro</td>
                        <td>Tenant</td>
                        <td>+91 76885 36697</td>
                        <td>+91 785 236 946</td>
                        <td>kloodas@gmail.com</td>
                    </tr>

                </tbody>
            </table>


        </div>

        <script src="dashboardAdmin.js" type="text/javascript"></script>
    </body>
</html>
