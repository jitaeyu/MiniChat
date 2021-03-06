<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<meta charset="UTF-8">
		<title>Chating</title>
		<style>
			* {
				margin: 0;
				padding: 0;
			}

			.container {
				width: 500px;
				margin: 0 auto;
				padding: 25px
			}

			.container h1 {
				text-align: center;
				padding: 5px 5px 5px 15px;
				color: #3862b0;
				border: 3px solid #3862b0;
				margin-bottom: 5px;
			}

			.chating {
				background-color: #000;
				width: 500px;
				height: 500px;
				overflow: auto;
			}

			.chating p {
				color: #fff;
				text-align: left;
			}

			input {
				width: 90%;
				height: 25px;
			}

			#yourMsg {
				display: none;
			}

			#inputtable {
				width: 500px;
				padding: 5px 5px 5px 5px;
				color: #000000;
				border: 3px solid #000000;
				margin-bottom: 5px;
			}

			#startBtn {
				background: #ffffff;
				width: 50px;
				border: 1px solid;
				border-radius: 15%
			}

			#sendBtn {
				background: #ffffff;
				width: 50px;
				border: 1px solid;
				border-radius: 15%
			}
		</style>
	</head>

	<script type="text/javascript">
		var ws;
		
		window.onbeforeunload = function() {
		 //window 화면을 벗어날때 이벤트 실행 (새로고침,페이지 종료 등)
		   disconnect(); 
		 //채팅자 퇴장 메시지 전송 and close
		};
		
		function wsOpen() {
			ws = new WebSocket("ws://" + location.host + "/chating");
			wsEvt();
		}

		function wsEvt() {
			ws.onopen = function (data) {
				//소켓이 열리면 초기화 세팅하기
				welcome();
				//입장 시 환영메시지 최초1회
				
			}

			ws.onmessage = function (data) {
				var msg = data.data;
				if (msg != null && msg.trim() != '') {
					$("#chating").append("<p>" + msg + "</p>");
				}
			}

			document.addEventListener("keypress", function (e) {
				if (e.keyCode == 13) { //enter press
					send();
				}

			});
			
			
		}

		function chatName() {
			var userName = $("#userName").val();
			if (userName == null || userName.trim() == "") {
				alert("사용자 이름을 입력해주세요.");
				$("#userName").focus();

			} else {
				wsOpen();
				$("#yourName").hide();
				$("#yourMsg").show();
				
			}
		}

		function welcome() {
			var uN = $("#userName").val();
			var msg = "님이 입장하셨습니다";
			ws.send(uN + "" + msg);
		}
		
		  function disconnect(){
			  var uN = $("#userName").val();
				var msg = "님이 퇴장하셨습니다";
				ws.send(uN + "" + msg);
	            ws.close();
	        }
		

		function send() {
			var uN = $("#userName").val();
			var msg = $("#chatting").val();
			ws.send(uN + " : " + msg);
			$('#chatting').val("");
		}
		
		
	</script>

	<body>
		<div id="container" class="container">
			<h1 align="center">채팅</h1>
			<div id="chating" class="chating">
			</div>

			<div id="yourName">
				<table id="inputtable" class="inputTable">
					<tr>
						<th>닉네임</th>
						<th><input type="text" name="userName" id="userName"></th>
						<th><button onclick="chatName()" id="startBtn">등록</button></th>
					</tr>
				</table>
			</div>
			<div id="yourMsg">
				<table id="inputtable" class="inputTable">
					<tr>
						<th>메시지</th>
						<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
						<th><button onclick="send()" id="sendBtn">전송</button></th>
					</tr>
				</table>
			</div>
		</div>
	</body>

	</html>