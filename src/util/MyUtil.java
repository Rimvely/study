package util;

public class MyUtil {

	//전체페이지 수
	public int getPageCount(int numPerPage, int dataCount){ //(3,34)
		
		int pageCount = 0;
		pageCount = dataCount / numPerPage; //11=34/3
		
		if(dataCount % numPerPage !=0) //11%3 != 0
			pageCount++; //11+1=12
		
		return pageCount; //총 12page
		
	}
	
	//페이징처리 메소드
	//currentPage : 현재 표시할 페이지
	//totalPage : 전체 페이지 수
	//listUrl : 링크를 설정할 url
	public String pageIndexList(int currentPage, int totalPage, String listUrl){ //(9,24, list.jsp)
		
		int numPerBlock = 5;  // 5 < 이전 6 7 8 9 10 다음 > 12 6~10까지 표시되는 페이지 갯수
		int currentPageSetup; // 표시할 첫 페이지(6)의 -1 해준 값(5, 10, 15, 20)
		int page;			  // page index 숫자 (...6 7 8 9 10 ...)
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage == 0 || totalPage == 0)
			return "";
		
		//링크를 걸어서 페이지를 붙여주려고 하는것
		//검색을 안했으면 list.jsp만 온다
		//검색을 했으면 list.jsp에 담겨서 
		//list.jsp?searchKey=subject&searchValue='수지'&
		if(listUrl.indexOf("?") != -1){ //데이터 없을 경우	
			
			listUrl = listUrl + "&";
	
		}else{
			listUrl = listUrl + "?";
		}
		
		//current_page가 9
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;// (9/5)*5 = 5
		
		//만약 currentPage가 5,10,15,20..이면
		//currentPageSetup = (currentPage / numPerBlock) * numPerBlock; //(10/5)*5 = 10
		if(currentPage % numPerBlock == 0) // 10%5=0
			currentPageSetup = currentPageSetup - numPerBlock; //10-5=5(표시할 첫페이지 -1)
		
		//1과 ◀ 이전
		if(totalPage > numPerBlock && currentPageSetup > 0){
			
			sb.append("<a href=\""+listUrl+"pageNum="
			+currentPageSetup+"\">◀이전</a>&nbsp;"); //5
			//<a href="list.jsp?pageNum=5">◀이전</a>&nbsp;
		}
		
		//바로가기 페이지
		page = currentPageSetup + 1;  //5+1=6
		
		//if(6 <= 12 && 6 <= 5+5) : 결국 6 7 8 9 10
		while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
			
			if(page == currentPage){
				
				sb.append("<font color=\"Fuchsia\">"+page+"</font>&nbsp;");
				//<font color="Fuchsia">9</font>&nbsp;
			
			}else{
				
				sb.append("<a href=\""+listUrl+"pageNum="+page+"\">"+page+"</a>&nbsp;");
				//<a href="list.jsp?pageNum=10">10</a>&nbsp;
			}
			
			page++; //5번(6,7,8,9,10) 반혹 후 page 값은 11
			
		}
		
		//다음▶, 마지막 페이지
		//if(12-5 > 5)
		if(totalPage - currentPageSetup > numPerBlock){
			
			sb.append("<a href=\""+listUrl+"pageNum="+page+"\">다음▶</a>&nbsp;");
		}		//<a href="list.jsp?pageNum=11">11</a>&nbsp;
		
		
		return sb.toString();
		
	}
	
	
	
	
	
	
	
	
	
}
