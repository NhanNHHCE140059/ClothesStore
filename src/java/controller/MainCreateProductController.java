/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import model.Category;
import model.ProductColor;
import service.CategoryService;
import service.ProductColorService;
import service.ProductService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/main-create-product")
@MultipartConfig
public class MainCreateProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryService cateService = new CategoryService();
        ProductColorService prColor = new ProductColorService();
        List<ProductColor> listAllColor = prColor.getALLProductColor();
        List<Category> listcate = cateService.getAllCate();
        request.setAttribute("listcate", listcate);
        request.setAttribute("listAllColor", listAllColor);
        request.getRequestDispatcher("main-create-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nameProduct = request.getParameter("name_product");
        String proPrice = request.getParameter("pro_price");
        String description = request.getParameter("description");
        String categoryID = request.getParameter("category");
        String status = request.getParameter("status");
        Part part = request.getPart("img_product");

        String filename = null;
        String relativeFilePath = null;

        // Xử lý tệp hình ảnh nếu có
        if (part != null && part.getSize() > 0) {
            filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/") + "assets/img";

            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String absoluteFilePath = uploadDir + File.separator + filename;
            relativeFilePath = "assets/img/" + filename;

            part.write(absoluteFilePath);
        }

        if (nameProduct != null && proPrice != null && description != null && categoryID != null) {
            int statusNUM = 1;
            if(status.equals("VISIBLE")){
                statusNUM =0;
            }
            ProductService prdS = new ProductService();
            prdS.createProduct(nameProduct, Double.parseDouble(proPrice), description, relativeFilePath, Integer.parseInt(categoryID), statusNUM);
            response.sendRedirect("main-manage-product");
            return;
        }

        response.sendRedirect("main-create-product");
    }

}
