package com.mail;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class sendMail {
	
	private String receiverEmail;
	private String senderEmail;
	private String senderName;
	private String subject;
	private String content;
	private String fileFullPath;
	private String originalFileName;
	
	private String mailHost;//메일 서버
	private String mailType;//메일 유형
	
	public sendMail(){
		this.mailHost = "localhost";
		this.mailType = "text/html;charset=UTF-8";
	}
	
	//생성자로 위치를 받을때
	public sendMail(String mailHost){
		this.mailHost = mailHost;
		this.mailType = "text/html;charset=UTF-8";
	}
	
	
	
	
	
	
	
	public String getReceiverEmail() {
		return receiverEmail;
	}
	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFileFullPath() {
		return fileFullPath;
	}
	public void setFileFullPath(String fileFullPath) {
		this.fileFullPath = fileFullPath;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getMailHost() {
		return mailHost;
	}
	public void setMailHost(String mailHost) {
		this.mailHost = mailHost;
	}
	public String getMailType() {
		return mailType;
	}
	public void setMailType(String mailType) {

		if(mailType.equalsIgnoreCase("TEXT"))
			this.mailType="text/plain;charset=UTF-8";
		else{
			this.mailType="text/html;charset=UTF-8";
		}
		
	}
	
	public boolean sendMail(){
		
		try {
			
			Properties props = System.getProperties();
			props.put("mail.stmp.host", mailType);
			
			Session session = Session.getDefaultInstance(props, null);
			
			//메일을 보낸 메세지 클래스
			Message msg = new MimeMessage(session);
			
			//보내는 사람
			if(senderName==null||senderName.equals("")){
				msg.setFrom(new InternetAddress(senderEmail));
			}else{
				msg.setFrom(new InternetAddress(senderEmail, senderName, "UTF-8"));
			}
			
			//받는사람
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiverEmail));
			
			//제목
			msg.setSubject(subject);
			
			//html형식인경우 /r/n을 <br/>로 변경
			if(mailType.indexOf("text/html") != -1){
				content = content.replaceAll("\r\n", "<br/>");
		
			}
			
			//메일 내용과 파일을 MimeBodyPart로 나누어 담음
			makeMessage(msg);
			
			msg.setHeader("X-Mailer", senderName);
			
			//메일보낸 날짜
			msg.setSentDate(new Date());
			
			//메일 전송
			Transport.send(msg);
			
			//서버에 파일을 올려서 파일을 보내는것.
			//그래서 전송 후에 서버에 있는 파일을 삭제.
			//pds/mailFile
			if(fileFullPath != null){
				
				File f = new File(fileFullPath);
				if(f.exists())
					f.delete();
	
			}
			
		} catch (MessagingException e) {
			System.out.println(e.toString());
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return true;

	}
	
	//첨부파일이 있는 경우 bodyPart로 나누어 분류
	private void makeMessage(Message msg) throws MessagingException{
		
		if(fileFullPath == null || fileFullPath.equals("")){
			
			//파일을 첨부하지 않음
			msg.setText(content);
			msg.setHeader("content-type", mailType);
			
		}else{
			//파일을 첨부 했을 경우
			
			//메일 내용
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setText(content);
			mbp1.setHeader("Content-Type", mailType);
			
			//첨부파일
			MimeBodyPart mbp2 = new MimeBodyPart();
			//실제 파일이 저장된 소스
			FileDataSource fds = new FileDataSource(fileFullPath);
			
			mbp2.setDataHandler(new DataHandler(fds));
			
			try {
				
				if(originalFileName == null || originalFileName.equals("")){
					
					mbp2.setFileName(MimeUtility.encodeWord(fds.getName()));
					
				}else{
					mbp2.setFileName(MimeUtility.encodeWord(originalFileName));
				}
				
			} catch (UnsupportedEncodingException e) {
				System.out.println(e.toString());
			}
			
			//보낼 내용과 파일을 받기
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);
			mp.addBodyPart(mbp2);
			
			//받은 내용과 파일을 보내기
			msg.setContent(mp);
			
			
		}
		
		
		
		
		
		
	}
	
	
	
	
}
