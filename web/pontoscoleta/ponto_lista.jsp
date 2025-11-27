<%@page import="java.util.List"%>
<%@page import="model.PontoColeta"%>
<%@page import="model.DAO.PontoColetaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <meta charset="UTF-8">
    <title>Lista de Pontos de Coleta</title>
</head>
<body>
    <h1>Lista de Pontos de Coleta</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Endereço</th>
            <th>Capacidade (kg)</th>
            <th>Status</th>
            <th>Freq. Coleta (dias)</th>
        </tr>
        <%
            try {
                PontoColetaDAO dao = new PontoColetaDAO();
                List<PontoColeta> lista = dao.listarTodos();
                for (PontoColeta pc : lista) {
        %>
        <tr>
            <td><%= pc.getId() %></td>
            <td><%= pc.getNomePonto() %></td>
            <td><%= pc.getEndereco() %></td>
            <td><%= pc.getCapacidadeKg() %></td>
            <td><%= pc.getStatus() %></td>
            <td><%= pc.getFrequenciaColetaDias() %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
