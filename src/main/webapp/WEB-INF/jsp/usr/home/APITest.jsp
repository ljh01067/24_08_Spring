<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST"></c:set>

<script>
	const API_KEY = 'UMYC-TTKR-6RO4-L6EJ';
	async function getCData() {
		const url = 'https://ecvam.neins.go.kr/apiConfirm.do?APIKEY='+ API_KEY + '&DOMAIN=localhost:8080';
		const response = await fetch(url);
		const data = await
		response.json();
		console.log("data", data);
	}
	getCData();
</script>


<%@ include file="../common/head.jspf"%>

<%@ include file="../common/foot.jspf"%>