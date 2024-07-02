<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.Product" %>
<%@page import="model.Cart" %>
<%@page import="java.util.*" %>
<%@page import="model.ProductsVariant"%>
<%@page import="service.ProductService"%>
<%@page import="service.ProductVariantService"%>
<%@page import="service.ProductColorService"%>
<%@page import="model.ProductColor"%>
<% LinkedList<Cart> carttop5 = (LinkedList<Cart>) request.getAttribute("carttop5");
ProductService pservice = new ProductService();
ProductVariantService pvariantservice = new ProductVariantService();
ProductColorService pcolorservice = new ProductColorService();
Integer indexpage = (Integer) request.getAttribute("indexpage");
%>
<!DOCTYPE html>
<%@page import="model.*" %>
<%@page import="helper.*" %>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <body>
        <style>
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            .page-link {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                color: #000;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .quantity-custom {
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                font-size: 16px;
            }
            input[type="number"] {
                -moz-appearance: textfield;
                -webkit-appearance: none;
                appearance: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                font-size: 16px;
            }
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            input[type="number"]::-ms-clear {
                display: none;
            }
            th:first-child {
                width: 10px;
                padding-right: 100px;
            }
            th:not(:first-child) {
                padding-left: 10px;
            }
            table {
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                white-space: nowrap;
            }
            th {
                width: auto;
            }
            html {
                position: relative;
            }
            #cartsummary {
                width: 92%;
                height: 115px; /* Để tự động điều chỉnh chiều cao */
                text-align: center;
                position: fixed;
                bottom: 0; /* Gắn vào đáy trang */
                left: 50%;
                transform: translateX(-50%);
                z-index: 100000;
                background-color: #fff;
                border-top: 1px solid #ddd;
                border: 1px solid #ffd333;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            #cartsummary .bg-light {
                padding: 10px 30px; /* Giảm padding */
            }

            #cartsummary h5 {
                margin: 0;
                padding: 0 10px; /* Khoảng cách giữa các mục */
                line-height: 40px; /* Chiều cao dòng */
            }
            #cartsummary .btn {
                height: 55px;
                width: 280px;
                font-size: 18px;
                border-radius: 4px;
            }

            .checkbox-wrapper input[type="checkbox"] {
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                width: 20px;
                height: 20px;
                border: 2px solid #ccc;
                border-radius: 3px;
                outline: none;
                cursor: pointer;
                position: relative;
                margin-right: 10px;
            }

            .checkbox-wrapper input[type="checkbox"]:checked {
                background-color: yellow;
                border-color: yellow;
            }

            .checkbox-wrapper input[type="checkbox"]:checked::before {
                content: '✔';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 14px;
                color: #3D464D;
            }
        </style>

        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Breadcrumb Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Shopping Cart</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Cart Start -->
        <div class="container-fluid" style="margin-bottom:-95px;">
            <div class="row px-xl-5" style="max-height: 980px;">
                <div class="col-lg-12 table-responsive mb-5 cartmanagement">
                    <table class="table table-light table-borderless table-hover text-center mb-0">
                        <thead class="thead-dark"> 

                        <c:if test="${not empty sessionScope.message}">
                            <c:set var="message" value="${sessionScope.message}" />
                            <div id="message" style="display: none;">
                                <h1 class="btn btn-block btn-primary font-weight-bold my-3 py-3">${sessionScope.message}</h1>
                            </div>
                            <c:remove var="message" scope="session"/>
                        </c:if>
                        <tr>
                            <th>Products</th>
                            <th></th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Remove</th>
                        </tr>
                        </thead>
                        <% double total_price = 0; %>
                        <tbody class="align-middle">
                            <% for (Cart cart: carttop5) { %>
                            <%
    Integer variantId = cart.getVariant_id();
    Integer productId = pvariantservice.getVariantByID(variantId).getPro_id();
    Product pro = pservice.GetProById(productId);
    ProductsVariant pro_Vid = pvariantservice.getVariantByID(variantId);
    ProductColor pColor= pcolorservice.getProductColorByID(pro_Vid.getColor_id());
                            %>

                            <tr>                                       
                                <td class="align-middle" style="display: flex; align-items: center;">
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" id="tick-checkbox">
                                    </div>
                                    <img src="<%=pro.getImageURL()%>" alt="imgProduct" style="width: 100px; height: 100px; margin-right: 20px;">
                                    <div>
                                        <span style="display: block; font-size: 18px; font-weight: bold;"><%=pro.getPro_name()%></span>
                                        <span style="display: inline-block; padding: 2px 5px; border: 1px solid red; color: red; margin-top: 5px;">Change your mind for free for 15 days</span>
                                        <div style="margin-top: 10px;">
                                            <span style="background-color: orange; color: white; padding: 2px 5px; margin-right: 5px;">QUALITY</span>
                                            <span style="background-color: green; color: white; padding: 2px 5px; margin-right: 5px;">TREND</span>
                                            <span style="background-color: yellow; color: black; padding: 2px 5px;">SPECTACULAR</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="align-middle">Product Classification <br>Color: <%=pColor.getColor_name()%>, Size: <%=pro_Vid.getSize_name()%></td>
                                <td class="align-middle">
                                    <fmt:formatNumber value="<%=pro.getPro_price()%>" type="number" pattern="#,##0" /> VND
                                </td>
                                <td class="align-middle">
                                    <div class="input-group quantity mx-auto" style="width: 100px;">
                                        <form action="cart" method="post">
                                            <div class="input-group-btn">
                                                <input type="hidden" name="pro_Vid" value="<%=cart.getVariant_id()%>"> 
                                                <button name="action" value="decQuan" type="submit" class="btn btn-sm btn-primary btn-plus"/>
                                                <i class="fa fa-minus"></i>
                                            </div>   
                                        </form>
                                        <form id="quantityCustom_<%=cart.getVariant_id()%>"action="cart" method="post" >     
                                            <input class="form-control form-control-sm bg-secondary border-0 text-center quantity-custom" type="number" value="<%= cart.getPro_quantity() %>" name="quantityC" onblur="handleBlur(<%=cart.getVariant_id()%>)" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                        </form>
                                        <div class="input-group-btn">
                                            <form action="cart" method="post">

                                                <input type="hidden" name="pro_Vid" value="<%=cart.getVariant_id()%>"> 
                                                <button name="action" value="incQuan" type="submit" class="btn btn-sm btn-primary btn-plus">
                                                    <i class="fa fa-plus"></i>
                                                </button>                                       
                                            </form>
                                        </div>
                                    </div>
                                </td>            
                                <td class="align-middle">                                   
                                    <fmt:formatNumber value="<%=pro.getPro_price() * cart.getPro_quantity()%>" type="number" pattern="#,##0" /> VND
                                </td>                                
                                <td class="align-middle">
                                    <form action="cart" method="post">

                                        <input type="hidden" name="cart_id" value="<%=cart.getCart_id()%>"> 
                                        <button type="submit" name="action" value="delete" onclick="return confirm('Do you want to delete this cart?')"  class="btn btn-sm btn-danger" style="margin-left: 2px">
                                            <i class="fa fa-times"></i>
                                            Remove</button>
                                    </form>
                                </td>
                            </tr>   
                            <% total_price += (pro.getPro_price() * cart.getPro_quantity()); %>
                            <%}%>
                        </tbody>
                    </table>
                    <div class="pagination" id="pagination">
                        <c:if test="${endpage != 0}">
                            <c:forEach var="i" begin="1" end="${endpage}">
                                <a href="cart?indexPage=${i}" class="page-link">${i}</a>
                            </c:forEach>
                        </c:if>
                    </div>     
                </div>
                <div class="text-center mb-0" id="cartsummary">
                    <div class="bg-light p-30 mb-5">
                        <div class="pt-2">
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <div class="d-flex align-items-center">
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" id="tick-checkbox">
                                    </div>
                                    <h5 class="m-0 ml-2">Select All (16)</h5>
                                </div>
                                <h5 class="m-0 text-danger">Save to Loved</h5>
                                <h5 class="m-0">Total Price (16 produts): <fmt:formatNumber value="<%=total_price%>" type="number" pattern="#,##0" /> VND</h5>
                                <div class="d-flex flex-column align-items-end">
                                    <a href="/clothesstore/checkout" class="btn btn-primary font-weight-bold py-3 px-4">Proceed To Checkout</a>                              
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cart End -->

        <jsp:include page="/shared/_footer.jsp" />
    </body>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            showDiv();
        });

        function showDiv() {
            var div = document.getElementById("message");
            div.style.display = "block";
            setTimeout(function () {
                div.style.display = "none";
            }, 3000);
        }

        async function sendGetRequest(proId) {
            document.getElementById('quantityCustom' + proId).submit();
        }

        function handleBlur(proId) {
            sendGetRequest(proId);
        }
    </script>
</html>
