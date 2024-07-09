/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;
import service.*;
import helper.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Locale;
import service.ProductService;

/**
 *
 * @author My Computer
 */
@WebServlet(value = {"/Create_Product_Variant_Controller", "/createVariants"})
@MultipartConfig
public class Create_Product_Variant_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ProductService productService = new ProductService();
        CategoryService cateService = new CategoryService();
        String proName = request.getParameter("proName");
        Product product = productService.GetProByName(proName);
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi", "VN"));
        symbols.setGroupingSeparator('.');
        symbols.setDecimalSeparator(',');
        DecimalFormat decimalFormat = new DecimalFormat("#,### VND", symbols);
        String formattedAmount = decimalFormat.format(product.getPro_price());
        try ( PrintWriter out = response.getWriter()) {
            if (product != null) {
                String json = "{";
                json += "\"price\":\"" + formattedAmount + "\",";
                json += "\"description\":\"" + product.getDescription() + "\",";
                json += "\"categoryName\":\"" + cateService.getNameCateByIDCate(product.getCat_id()).getCat_name() + "\"";
                json += "}";
                out.print(json);
            } else {
                String json = "{";
                json += "\"price\": \"Not Found\",";
                json += "\"description\": \"Not Found\",";
                json += "\"categoryName\": \"Not Found\"";
                json += "}";
                out.print(json);
            }
            out.flush();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("proName") != null) {
            processRequest(request, response);
            return;
        }
        ProductService productService = new ProductService();
        ProductColorService productColorService = new ProductColorService();
        List<Product> listAllProduct = productService.getAllProducts();
        List<ProductColor> listAllColor = productColorService.getALLProductColor();
        request.setAttribute("listAllProduct", listAllProduct);
        request.setAttribute("listAllColor", listAllColor);
        request.setAttribute("allSize", ProductSizeType.values());
        request.getRequestDispatcher("create-product-variants.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");
            ProductService productService = new ProductService();
            ProductVariantService productVaService = new ProductVariantService();
            switch (action) {
                case "create-new-variant":
                    String UPLOAD_DIR = "uploads";
                    String proName = request.getParameter("pro_Name");
                    Product product = productService.GetProByName(proName);
                    String colorID = request.getParameter("color");
                    String size_Name = request.getParameter("size");

                    if (colorID == null || colorID.isEmpty()) {
                        response.sendRedirect("createVariants?error=ColorError");
                        return;
                    }
                    if (size_Name == null || size_Name.isEmpty()) {
                        response.sendRedirect("createVariants?error=SizeError");
                        return;
                    }

                    if (product == null) {
                        response.sendRedirect("createVariants?error=notFoundProduct");
                        return;
                    }
                    ProductSizeType size = ProductSizeType.valueOf(size_Name);
                    int sizeID = size.ordinal();
                    
                    String applicationPath = request.getServletContext().getRealPath("");
                    String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadFilePath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    List<Part> fileParts = new ArrayList<>();
                    for (Part part : request.getParts()) {
                        if ("imageURL[]".equals(part.getName()) && part.getSize() > 0) {
                            fileParts.add(part);
                        }
                    }
                    int image_ID = -1;
                    for (Part filePart : fileParts) {
                        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        System.out.println("assets/img/" + fileName);
                        image_ID = productVaService.addProductImage(product.getPro_id(), fileName);
                        filePart.write(uploadFilePath + File.separator + fileName);
                    }
                    if (image_ID == -1) {
                        response.sendRedirect("createVariants?Error=cantAddImg");
                        return;
                    } else {
                        boolean idAdded = productVaService.addNewVariant(product.getPro_id(), sizeID, Integer.parseInt(colorID), image_ID);
                        if (idAdded == false) {
                            response.sendRedirect("createVariants?Error=canAddProduct");
                            return;
                        }
                    }
                    response.sendRedirect("createVariants?Success=added");
                    return;
            }
        } else {
            response.sendRedirect("createVariants");
        }
    }

}
