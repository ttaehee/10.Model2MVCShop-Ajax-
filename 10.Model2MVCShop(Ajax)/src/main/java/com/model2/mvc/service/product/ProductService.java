package com.model2.mvc.service.product;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


public interface ProductService {
	
	public void addProduct(Product product) throws Exception;  //��ǰ���
	
	public Product getProduct(int prodNo) throws Exception;  //��ǰ������ȸ
	
	public Map<String, Object> getProductList(Search search) throws Exception;  //��ǰ�����ȸ
	
	public void updateProduct(Product product) throws Exception; //��ǰ��������

	
}
