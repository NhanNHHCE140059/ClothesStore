<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <jsp:include page="/shared/_head.jsp" />
    <body>
        <jsp:include page="/shared/_header.jsp" />
        <jsp:include page="/shared/_nav.jsp" />

        <!-- Breadcrumb Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="/clothesstore/home">Home</a>
                        <a class="breadcrumb-item text-dark" href="/clothesstore/shop">Shop</a>
                        <span class="breadcrumb-item active">Shop List</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->


        <!-- Shop Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <!-- Shop Sidebar Start -->
                <div class="col-lg-3 col-md-4">
                    <!-- Category Start -->
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Filter by Category</span></h5>
                    <div class="bg-light p-4 mb-30">
                        <form>
                            <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                <input type="checkbox" class="custom-control-input" id="price-2">
                                <label class="custom-control-label" for="price-2">HAT</label>
                            </div>
                            <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                <input type="checkbox" class="custom-control-input" id="price-3">
                                <label class="custom-control-label" for="price-3">SHORTS AND TROUSERS</label>
                            </div>
                            <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                                <input type="checkbox" class="custom-control-input" id="price-4">
                                <label class="custom-control-label" for="price-4">T-SHIRT</label>
                            </div>
                        </form>
                    </div>
                    <!-- Category End -->
                </div>
                <!-- Shop Sidebar End -->


                <!-- Shop Product Start -->
                <div class="col-lg-9 col-md-8">
                    <div class="row pb-3">
                        <style>
                            .product-item {
                                height: 100%;
                            }

                            .product-img img {
                                height: 340px; /* Điều chỉnh chiều cao của hình ảnh */
                                object-fit: fill; 
                            }
                        </style>
                        <div class="row">
                            <c:forEach items="${listP}" var="o" begin="0" end="8">
                                <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                    <div class="product-item bg-light border rounded">
                                        <div class="product-img position-relative overflow-hidden">
                                            <img class="img-fluid w-100" src="${o.imageURL}">
                                            <div class="product-action">
                                                <a class="btn btn-outline-dark btn-sm" href="#"><i class="fa fa-shopping-cart"></i> Add to Cart</a>
                                                <a class="btn btn-outline-dark btn-sm" href="#"><i class="far fa-heart"></i> Add to Wishlist</a>
                                                <a class="btn btn-outline-dark btn-sm" href="/clothesstore/detail?pid=${o.pro_id}"><i class="fa fa-info-circle"></i> More information</a>
                                            </div>
                                        </div>
                                        <div class="text-center py-3">
                                            <a class="h6 text-decoration-none text-truncate text-dark" href="/clothesstore/detail?pid=${o.pro_id}">${o.pro_name}</a>
                                            <div class="d-flex align-items-center justify-content-center mt-2">
                                                <h5 class="font-weight-bold"><fmt:formatNumber value="${o.pro_price}" type="number" pattern="#,##0"/> VND</h5>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-center mb-1">
                                                <small class="fa fa-star text-warning mr-1"></small>
                                                <small class="fa fa-star text-warning mr-1"></small>
                                                <small class="fa fa-star text-warning mr-1"></small>
                                                <small class="fa fa-star text-warning mr-1"></small>
                                                <small class="fa fa-star text-warning mr-1"></small>
                                                <small>(99)</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>


                        <div class="col-12">
                            <nav>
                                <ul class="pagination justify-content-center">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item"><a class="page-link" href="shop?page=${currentPage - 1}">Previous</a></li>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${noOfPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="shop?page=${i}">${i}</a></li>
                                    </c:forEach>
                                    <c:if test="${currentPage < noOfPages}">
                                        <li class="page-item"><a class="page-link" href="shop?page=${currentPage + 1}">Next</a></li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <!-- Shop Product End -->
            </div>
        </div>
        <!-- Shop End -->

        <jsp:include page="/shared/_footer.jsp" />
    </body>
</html>