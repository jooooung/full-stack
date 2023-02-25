<%@page import="com.lec.book.*"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="<%=conPath%>/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		String path = request.getRealPath("bookFile");
		int maxSize = 1024 * 1024 * 3;	// 최대 업로드 사이즈
		String[] images = {"",""};
		MultipartRequest mRequest = null;		// try 안이 아닌 밖에 설정하는 이유 : 받을 파라미터가 많기 때문
		try{
		mRequest = new MultipartRequest(request, path, maxSize, "utf-8", 
								new DefaultFileRenamePolicy());
		Enumeration<String> paramNames = mRequest.getFileNames();
		int idx = 0;
		while(paramNames.hasMoreElements()){
				String param = paramNames.nextElement();
				images[idx] = mRequest.getFilesystemName(param);
				System.out.println(idx + "번째 처리한 파라미터 : " + param + "/파일이름 : " + images[idx]);
				idx++;
			}
		}catch(IOException e){
			System.out.println(e.getMessage());
		}
		// 서버 파일 => 소스폴더로 복사
		for(String imgfile : images){
			InputStream  is = null;
			OutputStream os = null;
			File serverFile = new File(path + "/" + imgfile);
			if(serverFile.exists()){
				try{
					is = new FileInputStream(serverFile);
					os = new FileOutputStream("C:/JK/sourse/06_JSP/ch14_fileUp/WebContent/bookFile/" + imgfile);
					byte[] bs = new byte[(int)serverFile.length()];
					while(true){
						int readByteCnt = is.read(bs);	// bs만큼 is 서버파일 읽기
						if(readByteCnt == -1) break;		// 파일이 끝이면 break
						os.write(bs, 0, readByteCnt);
					}
				}catch(IOException e){
					System.out.println(e.getMessage());
				}finally{
					try{
						if(os != null) os.close();
						if(is != null) is.close();
					}catch(IOException e){
						System.out.println(e.getMessage());
					}
				} //try-catch-finally
			} // if 
		} // for
		// book 테이블에 저장
		String btitle 	 = mRequest.getParameter("btitle");
		int    bprice 	 = Integer.parseInt(mRequest.getParameter("bprice"));
		String bimage1	 = images[1] != null? images[1] : "noImg.png";
		String bimage2	 = images[0] != null? images[0] : "NOTHING.JPG";
		String bcontent  = mRequest.getParameter("bcontent");
		if(bcontent == null) bcontent = "";
		int    bdiscount = Integer.parseInt(mRequest.getParameter("bdiscount"));
		// String ip = request.getRemoteAddr();	// ip가 필요한 경우 request 이용
		BookDto dto = new BookDto(0, btitle, bprice, bimage1, bimage2, bcontent, bdiscount, null);
		BookDao bDao = BookDao.getInstance();
		int result = bDao.insertBook(dto);
		if(result == bDao.SUCCESS){
			out.println("책 등록 성공");
		}else{
			out.println("책 등록 실패");
		}
	%>	
	<h3>책이름 <%=btitle %></h3>
	<h3>
		가격 <del><%=bprice %></del>
		<b>
			<%=bprice * (100-bdiscount) / 100 %>
			(<%=bdiscount %>% 할인)
		</b> 
	</h3>
	<h3>대표이미지 <%=path%>/<%=bimage1 %></h3>
	<img alt="대표이미지" src="<%=conPath%>/bookFile/<%=bimage1%>">
	<h3>추가이미지 <%=path%>/<%=bimage2 %></h3>
	<img alt="추가이미지" src="<%=conPath%>/bookFile/<%=bimage2%>">
	<h3>책소개</h3>
	<pre><%=bcontent%></pre>
	<hr>
	<a href="ex1_list_board.jsp">책 리스트(게시판 스타일)</a><br>
	<a href="ex2_list.jsp">책 1page리스트(게시판 스타일)</a><br>
	<a href="ex3_list_product.jsp">책 전체리스트(product list 스타일)</a><br>
	<a href="ex4_list.jsp">책 1page리스트(product list 스타일)</a><br>
</body>
</html>