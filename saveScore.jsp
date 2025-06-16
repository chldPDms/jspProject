<%@ page import="java.sql.*, java.lang.Math" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Game Over</title>
</head>
<body>
	<%
	String scoreParam = request.getParameter("score");
	int intscore = Integer.parseInt(scoreParam);
	int userId = 1; // 실제 로그인 사용자 ID로 바꿔야 함

	// 1. 사용자 정보 불러오기
	String sql = "SELECT level, exp FROM signup WHERE user_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, userId);
	rs = pstmt.executeQuery();

	int level = 1;
	int exp = 0;

	if (rs.next()) {
		level = rs.getInt("level");
		exp = rs.getInt("exp");
	}
	rs.close();
	pstmt.close();

	// 2. 경험치 계산
	exp += intscore / 100;

	int neededExp = (int) Math.pow(2, level);
	while (exp >= neededExp) {
		exp -= neededExp;
		level++;
		neededExp = (int) Math.pow(2, level);
	}

	// 3. DB 업데이트
	String updateSql = "UPDATE signup SET level = ?, exp = ? WHERE user_id = ?";
	PreparedStatement updateStmt = conn.prepareStatement(updateSql);
	updateStmt.setInt(1, level);
	updateStmt.setInt(2, exp);
	updateStmt.setInt(3, userId);
	updateStmt.executeUpdate();
	//updateStmt.close();
	//conn.close(); 이거 왜 쓴 거임
	
	// 4. 최고 점수 갱신 (현재 scores 테이블은 user_id가 PK)
	String checkSql = "SELECT score FROM scores WHERE user_id = ?";
	PreparedStatement checkStmt = conn.prepareStatement(checkSql);
	checkStmt.setInt(1, userId);
	ResultSet scoreRs = checkStmt.executeQuery();

	boolean shouldInsert = true;
	if (scoreRs.next()) {
		int currentScore = scoreRs.getInt("score");
		if (intscore > currentScore) {
			// 기존보다 높은 점수면 갱신
			String updateScoreSql = "UPDATE scores SET score = ?, played_at = CURRENT_TIMESTAMP WHERE user_id = ?";
			PreparedStatement updateScoreStmt = conn.prepareStatement(updateScoreSql);
			updateScoreStmt.setInt(1, intscore);
			updateScoreStmt.setInt(2, userId);
			updateScoreStmt.executeUpdate();
			updateScoreStmt.close();
		}
		shouldInsert = false; // 이미 존재하니까 insert는 안 함
	}
	scoreRs.close();
	checkStmt.close();

	if (shouldInsert) {
		// 처음 기록이라면 insert
		String insertScoreSql = "INSERT INTO scores (user_id, score) VALUES (?, ?)";
		PreparedStatement insertScoreStmt = conn.prepareStatement(insertScoreSql);
		insertScoreStmt.setInt(1, userId);
		insertScoreStmt.setInt(2, intscore);
		insertScoreStmt.executeUpdate();
		insertScoreStmt.close();
	}
	%>
	ㄴ
	<h2>Game Over!</h2>
	<p>
		내 점수:
		<%=intscore%></p>
	<p>
		현재 레벨:
		<%=level%></p>
	<p>
		현재 EXP:
		<%=exp%>
		/
		<%=neededExp%>
	</p>
	<p>
		<button onclick="location.href='index.html'">다시하기</button>
		<button onclick="location.href='index.html'">메인화면</button>
		<button onclick="location.href='ranking.jsp'">랭킹</button>
		<button onclick="location.href='info.jsp'">프로필 보기</button>
	</p>
	<%
	rs.close();
	pstmt.close();
	conn.close();
	%>
</body>
</html>