package util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {
	
	//파일다운로드 메소드
	//saveFileName : 서버에 저장된 파일명
	//originalFileName : 클라이언트가 업로드한 파일
	//path : 서버에 저장된 실제 경로
	
	//서버에서 나에게 주기만하는거라서 resp만있으면된다
	//saveFileName 과 originalFileName 이 보통은 다르기 때문에 둘다 필요
	
	//FTP서버 (ex)-(youtube)한개의 서버에 수많은 동영상을 올림
	public static boolean doFileDownload(HttpServletResponse response,
			String saveFileName, String originalFileName, String path){
		
		//download.do에서 path - 저장되는 파일까지 경로설정
		//1.경로 생성
		try {
			//original 파일이랑 헷갈리면 안된다
			
			String filePath = path + File.separator + saveFileName;
			
			//한번 체크
			if(originalFileName==null||originalFileName.equals("")){
				originalFileName = saveFileName;
			}
			
			//파일을 다운받아서 클라이언트에 파일 이름을 생성할때
			//한글 이름 깨지는것을 방지 *반드시 euc-kr로 생성*(utf-8로 안됨)
			originalFileName = new String(
					originalFileName.getBytes("euc-kr"), "ISO-8859-1");//8859_1(iso생략할때 코딩)
			
			File f = new File(filePath);
			
			//경로에 갔는데 파일이없어. 그럼 멈춰
			if(!f.exists()){
				return false;
			}
			
			//파일을 줄때 1번 헤더를 만든다.
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment;fileName=" + originalFileName);
			
			//파일을 읽는 코딩 2번 읽어낸다.
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
			
			//파일 내보내는 코딩 3번 내보낸다.
			OutputStream out = response.getOutputStream();
			
			int n;
			byte bytes[] = new byte[4096];//이만큼씩 읽어서 내보낸다
			//n을 bytes로 0~4096로 읽어 내는데
			while((n=bis.read(bytes,0,4096)) != -1){
				out.write(bytes, 0, n);//bytes로 0부터 n까지
			}
			
			out.flush();// 4096을 다 안채우고 3000이여도 다 내보내라 뜻
			out.close();
			bis.close();
			
		}catch (Exception e){
			System.out.println(e.toString());
			return false;
		}
		
		return true;
				
	}
	
	//물리적 파일 삭제(DB삭제는 DAO에 있음)
	public static void doFileDelete(String saveFileName, String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			File f = new File(filePath);
			
			if(f.exists()){
				f.delete(); //물리적 파일 삭제
			}	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}	
		
	}
	
}
