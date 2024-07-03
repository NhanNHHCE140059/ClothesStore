package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;
import java.util.*;
import model.OrderDetail;
import model.ProductImage;
import service.OrderDetailService;
import service.ProductImageService;
import service.ProductService;
import service.ProductVariantService;
import service.WarehouseService;

/**
 *
 * @author Huenh
 */
@WebServlet(value = "/detail")
public class DetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("pid");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr); // Chuyển đổi từ String sang int
                ProductService ps = new ProductService();
                WarehouseService wservice = new WarehouseService();
                ProductVariantService pvService = new ProductVariantService();
                Product p = ps.GetProById(id);
                if (req.getParameter("success") != null) {
                    req.setAttribute("successP", p);
                }
                ProductImageService prImg = new ProductImageService();
                // lay anh
                List<ProductImage> imgList = prImg.getImageByID(p.getPro_id());
                // lay size 
                Map<String, Set<String>> size_color = pvService.getVariantsByProductId(id);
                List<String> sizeOrder = Arrays.asList("S", "M", "L", "XL", "XXL", "XXXL", "XXXL", "XXXXL", "XXXXXL");
                List<String> sizes = new ArrayList<>(size_color.keySet());
                sizes.remove("ALL_COLORS");
                new Runnable() {
                    @Override
                    public void run() {
                        Collections.sort(sizes, (o1, o2) -> Integer.compare(sizeOrder.indexOf(o1), sizeOrder.indexOf(o2)));
                    }
                }.run();
                // lay color
                Set<String> allColors = size_color.get("ALL_COLORS");
                ////////////////// Lay 9 product 
                List<Product> list9 = ps.getRandom9Product();
                req.setAttribute("list9", list9);
                ////////////////////////////////
                //////////////Lay top 10 feedback 
                OrderDetailService orderdtSV = new OrderDetailService();
                List<OrderDetail> listFeedback = orderdtSV.getTop10FeedbackNotNullByID(id);
                System.out.println(listFeedback.size());
                req.setAttribute("listFeedback", listFeedback);
                req.setAttribute("allColors", allColors);
                req.setAttribute("imgList", imgList);
                req.setAttribute("sizes", sizes);
                req.setAttribute("isCap", p.getCat_id());
                req.setAttribute("color_size", size_color);
                req.setAttribute("totalP", wservice.countTotalProductInWareHouseByID(id));
                req.setAttribute("pro_detail", p);
                req.getRequestDispatcher("detail.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                // Xử lý trường hợp idStr không phải là một số hợp lệ
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else {
            // Xử lý trường hợp pid không có trong request
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
        }
    }
}
