/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import service.*;
import model.*;
import helper.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.*;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/update-product")
@MultipartConfig
public class UpdateProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("idPro") != null) {
            int idPro = Integer.parseInt(request.getParameter("idPro"));
            ProductService productService = new ProductService();
            CategoryService cateService = new CategoryService();
            ProductColorService prColor = new ProductColorService();
            List<ProductColor> listAllColor = prColor.getALLProductColor();
            List<Category> listcate = cateService.getAllCategories();
            Product product = productService.GetProById(idPro);
            request.setAttribute("product", product);
            request.setAttribute("listcate", listcate);
            request.setAttribute("listAllColor", listAllColor);
        } else {
            response.sendRedirect(request.getContextPath() + ("/main-manage-product"));
            return;
        }
        request.getRequestDispatcher("update-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy các tham số từ request
        String nameProduct = request.getParameter("name_product");
        String proPrice = request.getParameter("pro_price");
        String description = request.getParameter("description");
        String categoryID = request.getParameter("category");
        String productID = request.getParameter("product_id");
        Part part = request.getPart("img_product");
        if (!request.getParameter("newPrice").isEmpty()) {
            proPrice = request.getParameter("newPrice");

        }
        proPrice = proPrice.replace(" VND", "").replace(".", "");

        String relativeFilePath = null;

        // Xử lý tệp hình ảnh nếu có
        if (part != null && part.getSize() > 0) {
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/") + "assets/img";

            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String absoluteFilePath = uploadDir + File.separator + filename;
            relativeFilePath = "assets/img/" + filename;

            part.write(absoluteFilePath);
        }
        if (nameProduct != null && proPrice != null && description != null && categoryID != null && productID != null) {
            ProductService prdS = new ProductService();
            prdS.updateProduct(nameProduct, Double.parseDouble(proPrice), description, relativeFilePath, Integer.parseInt(categoryID), Integer.parseInt(productID));
        }
        // Gọi phương thức updateProduct từ ProductService

        // Chuyển hướng hoặc chuyển tiếp đến trang phù hợp
        response.sendRedirect("main-manage-product"); // Thay "somewhere.jsp" bằng trang thực tế
    }
}
