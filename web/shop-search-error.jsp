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
        
        <div class="container-fluid">
            <div class="row px-xl-5">
                <!-- Shop Sidebar Start -->
                <div class="col-lg-3 col-md-4">
                    <!-- Category Start -->
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Filter by Category</span></h5>
                    <div class="bg-light p-4 mb-30">
                        <form>
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
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Top 3 Trending</span></h5>
                    <div class="bg-light p-4 mb-30 top-3-products text-center" style="max-height: 73-px">
                        <c:forEach var="product" items="${top3Sell}">
                            <div class="product-items" style="height:230px; width: auto;border:1px solid;margin-top: 4px; border-radius:4px" >
                                <div class="product-imgs">
                                    <img class="img-fluid" style="width: 30%;height: auto;margin-top:4px;" src="${product.imageURL}">
                                    <div class="product-actions">
                                      
                                        <a class="btn btn-outline-dark btn-sm" href="/clothesstore/detail?pid=${product.pro_id}"><i class="fa fa-info-circle"></i> More information and Buy</a>
                                    </div>
                                </div>
                                <div class="text-center py-3">
                                    <a class="h6 text-decoration-none text-truncate text-dark" href="/clothesstore/detail?pid=${product.pro_id}">${product.pro_name}</a>
                                    <div class="d-flex align-items-center justify-content-center mt-2">
                                        <h5 class="font-weight-bold"><fmt:formatNumber value="${product.pro_price}" type="number" pattern="#,##0"/> VND</h5>
                                    </div>
                                </div>
                            </div>
                                    
                        </c:forEach>
                    </div>
                </div>
                <!-- Shop Sidebar End -->


                <!-- Shop Product Start -->
                <div class="col-lg-9 col-md-8">
                    <h2 class="text-center">Product Not Found</h2>
                </div>
                <!-- Shop Product End -->
            </div>
        </div>
        <!-- Shop End -->

        <jsp:include page="/shared/_footer.jsp" />
    </body>
</html>
