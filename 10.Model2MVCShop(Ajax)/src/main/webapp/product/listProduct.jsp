<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
<%@ page import="java.util.List"  %>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>

<%
    List<Product> list= (List<Product>)request.getAttribute("list");
    Page resultPage=(Page)request.getAttribute("resultPage");

	Search search=(Search)request.getAttribute("search");
	
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	
	String menu= (String)request.getAttribute("menu");
%>  /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>

<html>
<head>
<title>상품관리</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script type="text/javascript">

	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetUserList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();		
		//alert(  "function호출됨"  );
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	 $(function() {
		 
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
		 $("td.ct_btn01:contains('검색')").on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			fncGetUserList(1);
		});
		
		 $( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				//////////////////////////// 추가 , 변경된 부분 ///////////////////////////////////
				//self.location ="/product/getProduct?menu=${menu}&prodNo="+$( this ).data("value");
                ////////////////////////////////////////////////////////////////////////////////////////////
				var prodNo = $(this).data("value");
					$.ajax( 
							{
								url : "/product/json/getProduct/"+prodNo ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									
									var displayValue = "<h3>"
																+"상품번호 : "+JSONData.prodNo+"<br/>"
																+"상품명 : "+JSONData.prodName+"<br/>"
																+"상품이미지 : "+JSONData.filName+"<br/>"
																+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
																+"제조일자 : "+JSONData.manuDate+"<br/>"
																+"가격 : "+JSONData.price+"<br/>"
																+"등록일자 : "+JSONData.regDate+"<br/>"
																+"</h3>";
									//Debug...									
									//alert(displayValue);
									$("h3").remove();
									$( "#"+prodNo+"" ).html(displayValue);
								}				
							});						
				
		});
		
		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
		
		$( ".ct_list_pop:contains('배송하기')" ).on("click" , function() {
			//Debug..
			//alert(  $( ".ct_list_pop:contains('배송하기')" ).html() );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/updateTranCode?prodNo=${pro.prodNo}&tranCode=3");
		});
		
	});			

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">
<!-- /////////////////////////////////////////////////////////////////////////////
<form name="detailForm" action="/listProduct.do?menu=${menu}" method="post">
///////////////////////////////////////////////////////////////////////////////////////// -->
<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">
////////////////////////////////////////////////////////////////////////////////////////////////// -->

<form name="detailForm">
<input type="hidden" name="menu" value="${menu}"/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
					<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
							<% if(menu.equals("manage")){ %>
					
							   상품관리
							<%}else if(menu.equals("search")){ %>
							   상품 목록조회
							<%} %>
					/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
					
				<c:choose>
				  <c:when test="${menu eq 'manage'}">상품관리</c:when>
				  <c:when test="${menu eq 'search'}">상품 목록조회</c:when>
				</c:choose>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
         <select name="searchCondition" class="ct_input_g" style="width:80px">
            <%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
            <option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>상품번호</option>
            <option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>상품명</option>
            <option value="2" <%= (searchCondition.equals("2") ? "selected" : "")%>>상품가격</option>
            /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
            <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
			<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
			<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품가격</option>
         </select>
         <%--<input type="text" name="searchKeyword" value="<%= searchKeyword %>"  class="ct_input_g" 
                     style="width:200px; height:20px" >--%>
          <input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g" style="width:200px; height:20px" > 
      </td>


		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
						<a href="javascript:fncGetUserList('1');">검색</a>
						////////////////////////////////////////////////////////////////////////////////////////////////// -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<%--<td colspan="11" >전체  <%= resultPage.getTotalCount()%> 건수, 현재 <%=resultPage.getCurrentPage() %> 페이지</td>--%>
	    <td colspan="11" > 전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
	<% 	
	    System.out.println("listproduct.jsp menu:"+menu);

		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
	%>
		
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>

				<td align="left"><a href="/getProduct.do?prodNo=<%= vo.getProdNo() %>&menu=<%=menu%>"><%= vo.getProdName() %></a></td>
		

		<td></td>
		<td align="left"><%= vo.getPrice() %></td>
		<td></td>
		<td align="left"><%= vo.getManuDate() %></td>
		<td></td>
		<td align="left">
		
			<%if(menu.equals("manage")){ %>
		<%    if(vo.getProTranCode()==null){ %>
		        
		        판매중
		<%    }else if(vo.getProTranCode().trim().equals("2")){ %>
			    
			    구매완료
		
					<a href="/updateTranCode.do?prodNo=<%=vo.getProdNo() %>&tranCode=3">배송하기</a>
	    <%    }else if(vo.getProTranCode().trim().equals("3")){ %>
			
			    배송중
			
			        <a href="/updateTranCode.do?prodNo=<%=vo.getProdNo() %>&tranCode=4">배송완료</a>
	    <%    }else if(vo.getProTranCode().trim().equals("4")){ %>
			        
	    	    배송완료
	    	    
	    <%     } %>
		<%}else if(menu.equals("search")){ %>
		<%     
		      if(vo.getProTranCode()!=null){
		    	  if(vo.getProTranCode().trim().equals("2")||vo.getProTranCode().trim().equals("3")||vo.getProTranCode().trim().equals("4")){%>
		            재고없음
		          <%} %>
		<%    }else{ %>
			    판매중
        <%    } %>
        <%} %>
		 
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
	
%>/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>

<c:set var="i" value="0" />
	<c:forEach var="pro" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////
			<td align="left"><a href="/getProduct.do?prodNo=${pro.prodNo}&menu=${menu}">${pro.prodName}</a></td>
			////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
			<td align="left"><a href="/product/getProduct?prodNo=${pro.prodNo}&menu=${menu}">${pro.prodName}</a></td>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<td align="left" data-value="${pro.prodNo}">${pro.prodName}</td>
			<td></td>
			<td align="left">${pro.price}</td>
			<td></td>
			<td align="left">${pro.manuDate}</td>		
			<td></td>
		<td align="left">
		
		<c:choose>
		
		  <c:when test="${menu eq 'manage'}">
		    <c:choose>
		      <c:when test="${empty pro.proTranCode}">판매중</c:when>
		      <c:when test="${pro.proTranCode eq '2'}">
		      구매완료
		      <!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
		      <a href="/product/updateTranCode?prodNo=${pro.prodNo}&tranCode=3">배송하기</a>
		      ////////////////////////////////////////////////////////////////////////////////////////////////// -->
		      배송하기
		      </c:when>
		      <c:when test="${pro.proTranCode eq '3'}">
		      배송중
		      </c:when>
		      <c:when test="${pro.proTranCode eq '4'}">배송완료</c:when>
		    </c:choose> 
		  </c:when>
		  
		  <c:when test="${menu eq 'search'}">
		    <c:choose>
		      <c:when test="${pro.proTranCode eq '2'||pro.proTranCode eq '3'||pro.proTranCode eq '4'}">재고없음</c:when>
		      <c:otherwise>판매중</c:otherwise>
		    </c:choose>
		  </c:when>
		  
		</c:choose>
		 
		</td>	
		</tr>
		<tr>
		<!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		////////////////////////////////////////////////////////////////////////////////////////////  -->
		<td id="${pro.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
	
	</table>


<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
	<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// 		   
	<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
			◀ 이전
	<% }else{ %>
			<a href="javascript:fncGetUserList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
	<% } %>

	<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
			<a href="javascript:fncGetUserList('<%=i %>');"><%=i %></a>
	<% 	}  %>
	
	<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
			이후 ▶
	<% }else{ %>
			<a href="javascript:fncGetUserList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
	<% } %>
	 /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
	
		<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
