package webqq;

public class MessageDispose {

	public static String parse(String[] receivedMessage) {
		StringBuffer messageBuffer = new StringBuffer();
		if(receivedMessage[0].equals("ϵͳ��Ϣ")) {
			messageBuffer.append("<div class=\"system\">");
			messageBuffer.append("<p class=\"message_system\">"+receivedMessage[0]+"</p>");
			messageBuffer.append("</div>");
		}
		return messageBuffer.toString();
		
		
		
		

		
	}
	
	
}
