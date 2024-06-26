<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
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

            /* Styling the input field */
            .quantity-custom {
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                font-size: 16px;
            }

            /* CSS to style number input as text input */
            input[type="number"] {
                -moz-appearance: textfield; /* Firefox */
                -webkit-appearance: none; /* Chrome and Safari */
                appearance: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                font-size: 16px;
            }

            /* Remove arrows in Firefox */
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Remove arrows in Internet Explorer */
            input[type="number"]::-ms-clear {
                display: none;
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
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-lg-8 table-responsive mb-5">
                    <table class="table table-light table-borderless table-hover text-center mb-0">
                        <thead class="thead-dark">

                            <c:if test="${not empty sessionScope.message}">
                                <c:set var="message" value="${sessionScope.message}"/>
                            <div id="message" style="display: none;">
                                <h1 class="btn btn-block btn-primary font-weight-bold my-3 py-3">${sessionScope.message}</h1>
                            </div>
                            <c:remove var="message" scope="session"/>
                        </c:if>

                        <tr>
                            <th style="padding-right: 150px;">Products</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Remove</th>
                        </tr>
                        </thead>
                        <tbody class="align-middle">
                            <c:set var="totalQuantity" value="0" />
                            <c:set var="totalPrice" value="0" />

                            <c:choose>
                                <c:when test= "${not empty cp_list}">
                                    <c:forEach var="map" items="${cp_list}">
                                        <c:forEach var="entry" items="${map}">
                                            <c:set var="c" value="${entry.key}" />
                                            <c:set var="product" value="${entry.value}" />
                                            <tr>                                       
                                                <td class="align-middle"> <div style="width: 150px;
                                                                               display: inline-block;" >${c.pro_name}</div><img src="${product.imageURL}" alt="" style="width: 100px;
                                                                               height: 100px;
                                                                               margin-left: 35px"></td>
                                                <td class="align-middle"><fmt:formatNumber value="${c.pro_price}" type="number" pattern="#,##0" /> VND</td>
                                                <td class="align-middle">
                                                    <div class="input-group quantity mx-auto" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <a href="${pageContext.request.contextPath}/cart?action=decQuan&pro_id=${c.pro_id}&indexpage=${indexpage}"><button class="btn btn-sm btn-primary btn-minus">
                                                                    <i class="fa fa-minus"></i>
                                                                </button> 
                                                            </a>
                                                        </div>                                                         
                                                        <input class="form-control form-control-sm bg-secondary border-0 text-center quantity-custom" id="quantityCustom_${c.pro_id}" type="number" value="${c.pro_quantity}" onblur="handleBlur(${c.pro_id})" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                                        <div class="input-group-btn">
                                                            <a href="${pageContext.request.contextPath}/cart?action=incQuan&pro_id=${c.pro_id}&indexpage=${indexpage}"><button class="btn btn-sm btn-primary btn-plus">
                                                                    <i class="fa fa-plus"></i>
                                                                </button>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="align-middle"><fmt:formatNumber value="${c.total_price}" type="number" pattern="#,##0" /> VND</td>                                            
                                                <td class="align-middle"><a onclick="return confirm('Do you want to delete this cart?')" href="${pageContext.request.contextPath}/cart?action=deletePro&card_id=${c.cart_id}&indexpage=${indexpage}" class="btn btn-sm btn-danger" style="margin-left: 2px"><i class="fa fa-times"></i> Remove</a></td>
                                            </tr>                                            
                                        </c:forEach>
                                    </c:forEach>
                                </c:when>                     
                                <c:otherwise>
                                <h2 style="color: #ffd333;
                                    margin-left: 60px;">There are currently no products in your shopping cart &#9888;</h2>
                            </c:otherwise>
                        </c:choose>


                        </tbody>
                    </table>
                    <div class="pagination" id="pagination">
                        <c:if test="${endpage != 0}">
                            <c:forEach var="i" begin="1" end="${endpage}">
                                <a href="cart?indexpage=${i}" class="page-link">${i}</a>
                            </c:forEach>
                        </c:if>
                    </div>     
                </div>
                <div class="col-lg-4">
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Cart Summary</span></h5>
                    <div class="bg-light p-30 mb-5">
                        <div class="border-bottom pb-2">
                            <div class="d-flex justify-content-between mb-3">
                                <h5>Products in the cart:</h5>
                                <h5><%=(Integer) request.getAttribute("totalQuantity")%></h5>
                            </div>
                            <div class="d-flex justify-content-between">
                                <h5 class="font-weight-medium">Promotion:</h5>
                                <h5 class="font-weight-medium">0%</h5>
                            </div>
                        </div>
                        <div class="pt-2">
                            <div class="d-flex justify-content-between mt-2">
                                <h3>Total</h3>
                                <h3><%=request.getAttribute("totalPrice")%></h3>
                            </div>
                            <a href="/clothesstore/checkout" class="btn btn-block btn-primary font-weight-bold my-3 py-3">Proceed To Checkout</a>
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
            }, 3000); // Ẩn sau 3 giây
        }

        async function sendGetRequest(proId) {

            try {
                const quantityCustom = document.getElementById('quantityCustom_' + proId);

                const quantityCustomValue = quantityCustom.value;
                if (!quantityCustomValue) {
                    window.location.href = 'cart';
                    return;
                }
                const idValue = proId;
                window.location.href = 'cart?action=quantityCustom&quantity=' + quantityCustomValue + '&pro_id=' + proId + '&indexpage=' +${indexpage};
            } catch (error) {
                console.error('Lỗi:', error);
            }
        }

        function handleBlur(proId) {
            sendGetRequest(proId);
        }
    </script>
</html>