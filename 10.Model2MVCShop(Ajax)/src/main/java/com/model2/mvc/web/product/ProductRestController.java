package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
   
   ///Field
   @Autowired
   @Qualifier("productServiceImpl")
   private ProductService productService;
   //setter Method 구현 않음
      
   public ProductRestController(){
      System.out.println(this.getClass());
   }
   
   @Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
   
   @RequestMapping(value="json/addProduct", method=RequestMethod.POST)
   public Product addProduct( @RequestBody Product product) throws Exception {

      System.out.println("/product/json/addProduct : POST");
      //Business Logic
      productService.addProduct(product);
      
      return product;
   }

   @RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
   public Product getProduct( @PathVariable int prodNo) throws Exception{
      
      System.out.println("/product/json/getProduct : GET");
      
      //Business Logic
      return productService.getProduct(prodNo);
   }

   @RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
   public Product updateProduct( @RequestBody Product product) throws Exception{

      System.out.println("/product/json/updateProduct : POST");
      //Business Logic
      productService.updateProduct(product);
      
      return product;
   }
   
   @RequestMapping( value="json/updateTranCode", method=RequestMethod.POST )
   public Product updateTranCode( @RequestBody Product product) throws Exception{

      System.out.println("/product/json/updateProduct : POST");
      //Business Logic
      productService.updateProduct(product);
      
      return product;
   }

   @RequestMapping( value="json/listProduct", method=RequestMethod.POST)
   public Map listUser( @RequestBody Search search) throws Exception{
      
      System.out.println("/product/json/listProduct : GET / POST");
      
      if(search.getCurrentPage() ==0 ){
         search.setCurrentPage(1);
      }
      search.setPageSize(pageSize);
      
      // Business logic 수행
      Map<String , Object> map=productService.getProductList(search);
      
      Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
      System.out.println(resultPage);
      
      Map mapList=new HashMap();
      // Model 과 View 연결
      mapList.put("list", map.get("list"));
      mapList.put("resultPage", resultPage);
      mapList.put("search", search);
      
      return mapList;
   }

}