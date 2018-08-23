package util;

public class MyUtil {

	//��ü������ ��
	public int getPageCount(int numPerPage, int dataCount){ //(3,34)
		
		int pageCount = 0;
		pageCount = dataCount / numPerPage; //11=34/3
		
		if(dataCount % numPerPage !=0) //11%3 != 0
			pageCount++; //11+1=12
		
		return pageCount; //�� 12page
		
	}
	
	//����¡ó�� �޼ҵ�
	//currentPage : ���� ǥ���� ������
	//totalPage : ��ü ������ ��
	//listUrl : ��ũ�� ������ url
	public String pageIndexList(int currentPage, int totalPage, String listUrl){ //(9,24, list.jsp)
		
		int numPerBlock = 5;  // 5 < ���� 6 7 8 9 10 ���� > 12 6~10���� ǥ�õǴ� ������ ����
		int currentPageSetup; // ǥ���� ù ������(6)�� -1 ���� ��(5, 10, 15, 20)
		int page;			  // page index ���� (...6 7 8 9 10 ...)
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage == 0 || totalPage == 0)
			return "";
		
		//��ũ�� �ɾ �������� �ٿ��ַ��� �ϴ°�
		//�˻��� �������� list.jsp�� �´�
		//�˻��� ������ list.jsp�� ��ܼ� 
		//list.jsp?searchKey=subject&searchValue='����'&
		if(listUrl.indexOf("?") != -1){ //������ ���� ���	
			
			listUrl = listUrl + "&";
	
		}else{
			listUrl = listUrl + "?";
		}
		
		//current_page�� 9
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;// (9/5)*5 = 5
		
		//���� currentPage�� 5,10,15,20..�̸�
		//currentPageSetup = (currentPage / numPerBlock) * numPerBlock; //(10/5)*5 = 10
		if(currentPage % numPerBlock == 0) // 10%5=0
			currentPageSetup = currentPageSetup - numPerBlock; //10-5=5(ǥ���� ù������ -1)
		
		//1�� �� ����
		if(totalPage > numPerBlock && currentPageSetup > 0){
			
			sb.append("<a href=\""+listUrl+"pageNum="
			+currentPageSetup+"\">������</a>&nbsp;"); //5
			//<a href="list.jsp?pageNum=5">������</a>&nbsp;
		}
		
		//�ٷΰ��� ������
		page = currentPageSetup + 1;  //5+1=6
		
		//if(6 <= 12 && 6 <= 5+5) : �ᱹ 6 7 8 9 10
		while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
			
			if(page == currentPage){
				
				sb.append("<font color=\"Fuchsia\">"+page+"</font>&nbsp;");
				//<font color="Fuchsia">9</font>&nbsp;
			
			}else{
				
				sb.append("<a href=\""+listUrl+"pageNum="+page+"\">"+page+"</a>&nbsp;");
				//<a href="list.jsp?pageNum=10">10</a>&nbsp;
			}
			
			page++; //5��(6,7,8,9,10) ��Ȥ �� page ���� 11
			
		}
		
		//������, ������ ������
		//if(12-5 > 5)
		if(totalPage - currentPageSetup > numPerBlock){
			
			sb.append("<a href=\""+listUrl+"pageNum="+page+"\">������</a>&nbsp;");
		}		//<a href="list.jsp?pageNum=11">11</a>&nbsp;
		
		
		return sb.toString();
		
	}
	
	
	
	
	
	
	
	
	
}
