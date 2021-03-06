package com.jitae.chating.Handler;

import java.util.HashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class SocketHandler extends TextWebSocketHandler{

	HashMap<String, WebSocketSession> sessionMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		String msg = message.getPayload();
		for(String key : sessionMap.keySet()) {
			WebSocketSession ws = sessionMap.get(key);
			try {
				ws.sendMessage(new TextMessage(msg));
				System.out.println("msg"+msg);
				System.out.println("key"+sessionMap.get(key));
				System.out.println("ID"+" : ");
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		System.out.println("enable session id"+session.getId());
		sessionMap.put(session.getId(), session);
		
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionMap.remove(session.getId());
		super.afterConnectionClosed(session, status);
		System.out.println("close"+status);
		
	}
}
