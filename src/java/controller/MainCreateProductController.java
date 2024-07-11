/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import helper.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import model.Account;
import model.Category;
import model.Product;
import model.ProductColor;
import service.CategoryService;
import service.ProductColorService;
import service.ProductImageService;
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
             HttpSession session = request.getSession();

        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Customer) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
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
             HttpSession session = request.getSession();

        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Customer) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        String nameProduct = request.getParameter("name_product");
        ProductService productService = new ProductService();
        for (Product product : productService.getAllProducts()) {
            if (product.getPro_name().toUpperCase().trim().equals(nameProduct.toUpperCase().trim())) {
                response.sendRedirect("main-create-product?error=duplicateName");
                return;
            }
        }
        String description = request.getParameter("description");
        String categoryID = request.getParameter("category");
        String status = request.getParameter("status");
        String proPrice = request.getParameter("pro_price");
        System.out.println(proPrice);
        proPrice = proPrice.replace(" VND", "").replace(".", "");

        Collection<Part> parts = request.getParts();
        String uploadDir = getServletContext().getRealPath("/") + "assets/img";
        String relativeFilePath = null;
        for (Part part : parts) {
            if (part.getName().equals("img_product") && part.getSize() > 0) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uniqueFilename = UUID.randomUUID().toString() + "_" + filename;
                String absoluteFilePath = uploadDir + File.separator + uniqueFilename;

                try {
                    part.write(absoluteFilePath);
                } catch (IOException e) {
                    continue;
                }

                relativeFilePath = "assets/img/" + uniqueFilename;
          
                    break;
                
            }
        }

        if (nameProduct != null && proPrice != null && description != null && categoryID != null) {
            int statusNUM = status.equals("active") ? 1 : 0;
            ProductService prdS = new ProductService();
            ProductImageService prImageService = new ProductImageService();
            int productId = prdS.createProduct(nameProduct, Double.parseDouble(proPrice), description, relativeFilePath, Integer.parseInt(categoryID), statusNUM);

            for (Part part : parts) {
                if (part.getName().equals("img_product") && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String uniqueFilename = UUID.randomUUID().toString() + "_" + filename;
                    String absoluteFilePath = uploadDir + File.separator + uniqueFilename;

                    try {
                        part.write(absoluteFilePath);
                    } catch (IOException e) {
                        continue;
                    }

                    relativeFilePath = "assets/img/" + uniqueFilename;
                    prImageService.addProductImage(productId, relativeFilePath);

                }
            }

            response.sendRedirect("main-create-product?success=true");
        }
    }

}
