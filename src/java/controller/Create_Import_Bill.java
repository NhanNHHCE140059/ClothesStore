/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import helper.Role;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import model.*;
import service.*;
import java.util.*;

/**
 *
 * @author My Computer
 */
@WebServlet(value = "/createBill")
@MultipartConfig
public class Create_Import_Bill extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Staff) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        ProductVariantService prvSV = new ProductVariantService();
        List<ProductVariantInfo> listAll = prvSV.getAllVariantInfo();
        request.setAttribute("listAll", listAll);
        request.getRequestDispatcher("create_bill_and_import_bill.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRole() != Role.Staff) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        ImportBillService importBillSV = new ImportBillService();
        ImportBillDetailService importDT = new ImportBillDetailService();
        String importDate = request.getParameter("importDate");
        Part filePart = request.getPart("image");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate = null;
        try {
            utilDate = df.parse(importDate);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        String relativeFilePath = null;
        if (filePart != null && filePart.getSize() > 0) {
            String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/") + "assets/img";

            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String absoluteFilePath = uploadDir + File.separator + filename;
            relativeFilePath = "assets/img/" + filename;
        }

        String[] productVariants = request.getParameterValues("productVariant");
        String[] quantities = request.getParameterValues("quantity");
        String[] importPrices = request.getParameterValues("importPrice");

        List<ImportBillDetail> listIMD = new ArrayList<>();
        float totalPrice = 0;
        for (int i = 0; i < productVariants.length; i++) {
            String productVariant = productVariants[i];
            int variantId = Integer.parseInt(productVariant.split("\\|")[0].trim());
            System.out.println(variantId);
            int quantity = Integer.parseInt(quantities[i]);
            double importPrice = Double.parseDouble(importPrices[i].replaceAll("[^\\d]", ""));
            totalPrice += importPrice * quantity;
            listIMD.add(new ImportBillDetail(-1, -1, variantId, quantity, importPrice));
        }
        int bill_id = importBillSV.createImportBill(sqlDate, totalPrice, relativeFilePath);
        System.out.println(listIMD.size());
        importDT.addImportBillDetails(bill_id, listIMD);
        System.out.println(bill_id);
        response.sendRedirect("createBill");
    }
}
