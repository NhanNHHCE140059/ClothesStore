<!DOCTYPE html>
<html lang="en">
    <%@page import="model.Account"%>
    <%@page import="helper.Role"%>
    <%@page import="model.Order"%>
    <%@page import="java.util.List"%>
    <% Account account = (Account) request.getAttribute("account"); %>
    <% List<Order> listOrderS = (List<Order>) request.getAttribute("listOrderShipped"); %>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Producter Feedback Dashboard</title>
    </head>

    <body>

        <div class="sidebar">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create Product</a>
                <a href="#">Update Product</a>
                <a href="#">Delete Product</a>
            </div>
            <a href="#" class="menu-item">Category Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create Category</a>
                <a href="#">Update Category</a>
                <a href="#">Delete Category</a>
            </div>
            <a href="#" class="menu-item">Feedback Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">View Feedback</a>
            </div>
            <a href="#" class="menu-item">Orders Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Confirm Orders</a>
                <a href="#">Cancel Orders</a>
                <a href="#">Change Ship Status</a>
            </div>
            <a href="#" class="menu-item">Warehouse Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="#">Create New Product (Warehouse)</a>
                <a href="#">Update Product (Warehouse)</a>
                <a href="#">Delete Product (Warehouse)</a>
            </div>
        </div>

        <div class="content">
            <div class="header">
                <input type="text" placeholder="Search...">
                <div class="role-info">
                    <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
                </div>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th>ID Order</th>
                        <th>Feedback Content</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>

                    <%  if (listOrderS!=null && !listOrderS.isEmpty() ) {
                      for ( Order o : listOrderS ) {
                    %>            
                    <tr>
                        <td><%= o.getOrder_id() %></td>
                        <% if (o.getFeedback_order()==null) { %>
                        <td class="error-message">There are no feedback yet or the feedback has been deleted</td>
                        <% } else { %>
                        <td><%= o.getFeedback_order() %></td>
                        <% }%>
                        <td>
                            <form action="FeedBackManagementController" method="POST">
                                <% if (o.getFeedback_order()==null) { %>
                              
                                 <button class="non-action-button" type="submit">Delete Feedback</button>
                                <% }else {%>
                                  <input type="hidden" name="idOrder" value="<%= o.getOrder_id() %>">
                                  <button class="action-button" type="submit">Delete Feedback</button>
                                <% }%>
                               
                            </form>
                        </td>
                    </tr>
                    <% } }else { %>
                    <tr>
                        <td>Not Found Order </td>
                        <td>Not Found FeedBack</td>


                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
        <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>

</html>
