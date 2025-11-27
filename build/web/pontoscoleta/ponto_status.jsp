<%@page import="java.util.List"%>
<%@page import="model.PontoColeta"%>
<%@page import="model.DAO.PontoColetaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <meta charset="UTF-8">
    <title>Mapa de Status dos Pontos</title>
</head>
<body>
    <h1>Mapa de Status dos Pontos</h1>
    <%
        try {
            PontoColetaDAO dao = new PontoColetaDAO();
            List<PontoColeta> lista = dao.listarTodos();
            for (PontoColeta pc : lista) {
    %>
        <p>
            <strong><%= pc.getNomePonto() %></strong> - 
            <%= pc.getEndereco() %> - 
            Status: <%= pc.getStatus() %>
        </p>
    <%
            }
        } catch (Exception e) {
            out.println("<p>Erro: " + e.getMessage() + "</p>");
        }
    %>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
