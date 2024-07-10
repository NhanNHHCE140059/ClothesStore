<!DOCTYPE html>
<html lang="en">
    <%@page import="model.Account"%>
    <%@page import="helper.Role"%>
    <%@page import="model.Order"%>
    <%@page import="java.util.List"%>
    <% Account account = (Account) request.getAttribute("account"); %>
    <% List<Order> listOrderS = (List<Order>) request.getAttribute("listOrderShipped"); %>
    <% Integer endPage = (Integer) request.getAttribute("endPage");%>
    <% String searchText = (String) request.getAttribute("searchText"); %>
    <% Integer indexPage =(Integer) request.getAttribute("indexPage"); %>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feedbackManagement.css"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Management</title>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">Dashboard For Staff</div>
            <a href="#" class="menu-item">Product Management</a>
            <div class="separator"></div>
            <div class="submenu">
                <a href="/clothesstore/manage-product">Manage Product Variant</a>
                <a href="/clothesstore/main-manage-product">Manage Product</a>
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
            <a href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
            <div class="header">
                <input oninput="searchByPhone(this)" value="${phoneSearch}" type="number" id="autoSubmitInput" name="searchText" placeholder="Enter phone to search...">

                <div class="role-info">
                    <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
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
                    <!--                    <a href="#">Create New Product (Warehouse)</a>
                                        <a href="#">Update Product (Warehouse)</a>-->
                    <a href="${pageContext.request.contextPath}/ViewWarehouse">Manage Warehouse </a>
                </div>

            </div>

            <div class="content">
                <a href="${pageContext.request.contextPath}/home" class=" back-home">Back to Home</a>
                <div class="header">
                    <input oninput="searchByPhone(this)" value="${phoneSearch}" type="number" id="autoSubmitInput" name="searchText" placeholder="Enter phone to search...">

                    <div class="role-info">
                        <span><%= account.getRole()%> :</span><span><%= account.getName()%></span>
                    </div>

                </div>

                <table class="table">
                    <thead>
                        <tr>
                            <th>ID Order</th>
                            <th>Phone Number</th>
                            <th>Feedback Content</th>
                            <th>Actions</th>

                        </tr>

                    </thead>
                    <tbody id="contentFeedBack">

                        <%  if (listOrderS!=null && !listOrderS.isEmpty() ) {
                          for ( Order o : listOrderS ) {
                        %>            
                        <tr>
                            <td><%= o.getOrder_id() %></td>
                            <td><%= o.getPhone() %></td>
                            <% if (o.getFeedback_order()==null) { %>
                            <td class="error-message">There are no feedback yet or the feedback has been deleted</td>
                            <% } else { %>
                            <td><%= o.getFeedback_order() %></td>
                            <% }%>
                            <td>
                                <form action="FeedBackManagementController" method="POST">
                                    <% if (o.getFeedback_order()==null) { %>
                                    <button class="non-action-button">Delete Feedback</button>
                                    <% }else {%>
                                    <input type="hidden" name="indexPage" value="<%= indexPage %>">
                                    <input type="hidden" name="action" value="confirm"/>
                                    <input type="hidden" name="idOrder" value="<%= o.getOrder_id() %>"/>
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

                <div class="pagination" id="pagination">
                    <% if (endPage != 0) {
                   for (int i =1; i<=endPage;i++) {
                    %>
                    <a href="managementfeedback?indexPage=<%=i%>"class="page-link"><%=i%></a>
                    <% } } %>
                </div>
            </div>
            <% if ( session.getAttribute("deleteID")!= null) { 
             int deleteID = (Integer) session.getAttribute("deleteID");
               session.removeAttribute("deleteID");
            %>

            <div id="myModal" class="modal">
                <div class="modal-content">
                    <p>DO YOU WANT DELE FEEDBACK ID: <span id="feedbackId"><%= deleteID%></span>?</p>
                    <div class="modal-footer">
                        <form action="FeedBackManagementController" method="POST">
                            <input type="hidden" name="idOrder" value="<%=deleteID%>">
                            <input type="hidden" name="indexPage" value="<%= indexPage %>">
                            <button class="modal-button" name="action" value="delete" type="submit">Delete</button>
                            <button class="modal-button cancel"  name="action" value="cancel" type="submit">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
            <% }%>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="./assets/js/feedbackManagement.js" type="text/javascript"></script>
    </body>

</html>
