package util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {
	
	//���ϴٿ�ε� �޼ҵ�
	//saveFileName : ������ ����� ���ϸ�
	//originalFileName : Ŭ���̾�Ʈ�� ���ε��� ����
	//path : ������ ����� ���� ���
	
	//�������� ������ �ֱ⸸�ϴ°Ŷ� resp��������ȴ�
	//saveFileName �� originalFileName �� ������ �ٸ��� ������ �Ѵ� �ʿ�
	
	//FTP���� (ex)-(youtube)�Ѱ��� ������ ������ �������� �ø�
	public static boolean doFileDownload(HttpServletResponse response,
			String saveFileName, String originalFileName, String path){
		
		//download.do���� path - ����Ǵ� ���ϱ��� ��μ���
		//1.��� ����
		try {
			//original �����̶� �򰥸��� �ȵȴ�
			
			String filePath = path + File.separator + saveFileName;
			
			//�ѹ� üũ
			if(originalFileName==null||originalFileName.equals("")){
				originalFileName = saveFileName;
			}
			
			//������ �ٿ�޾Ƽ� Ŭ���̾�Ʈ�� ���� �̸��� �����Ҷ�
			//�ѱ� �̸� �����°��� ���� *�ݵ�� euc-kr�� ����*(utf-8�� �ȵ�)
			originalFileName = new String(
					originalFileName.getBytes("euc-kr"), "ISO-8859-1");//8859_1(iso�����Ҷ� �ڵ�)
			
			File f = new File(filePath);
			
			//��ο� ���µ� �����̾���. �׷� ����
			if(!f.exists()){
				return false;
			}
			
			//������ �ٶ� 1�� ����� �����.
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment;fileName=" + originalFileName);
			
			//������ �д� �ڵ� 2�� �о��.
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
			
			//���� �������� �ڵ� 3�� ��������.
			OutputStream out = response.getOutputStream();
			
			int n;
			byte bytes[] = new byte[4096];//�̸�ŭ�� �о ��������
			//n�� bytes�� 0~4096�� �о� ���µ�
			while((n=bis.read(bytes,0,4096)) != -1){
				out.write(bytes, 0, n);//bytes�� 0���� n����
			}
			
			out.flush();// 4096�� �� ��ä��� 3000�̿��� �� �������� ��
			out.close();
			bis.close();
			
		}catch (Exception e){
			System.out.println(e.toString());
			return false;
		}
		
		return true;
				
	}
	
	//������ ���� ����(DB������ DAO�� ����)
	public static void doFileDelete(String saveFileName, String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			File f = new File(filePath);
			
			if(f.exists()){
				f.delete(); //������ ���� ����
			}	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}	
		
	}
	
}
