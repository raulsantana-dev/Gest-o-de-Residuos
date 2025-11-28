<%@page import="java.util.List"%>
<%@page import="model.VeiculoRota"%>
<%@page import="model.DAO.VeiculoRotaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Veículos / Rotas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<h1>Veículos / Rotas</h1>

<%
    List<VeiculoRota> lista = null;
    String erro = null;

    try {
        VeiculoRotaDAO dao = new VeiculoRotaDAO();
        lista = dao.listarTodos();
    } catch (Exception e) {
        erro = e.getMessage();
    }

    if (erro != null) {
%>
    <p>Erro: <%= erro %></p>
<%
    } else if (lista == null || lista.isEmpty()) {
%>
    <p>Nenhum registro encontrado.</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Placa</th>
            <th>Capacidade (m³)</th>
            <th>Rota</th>
            <th>Descrição</th>
            <th>Dia da semana</th>
            <th>Ações</th>
        </tr>
    <%
        for (VeiculoRota v : lista) {
    %>
        <tr>
            <td><%= v.getIdVeiculo() %></td>
            <td><%= v.getPlaca() %></td>
            <td><%= v.getCapacidadeM3() %></td>
            <td><%= v.getRotaNome() %></td>
            <td><%= v.getRotaDescricao() %></td>
            <td><%= v.getDiaSemanaRota() %></td>
            <td>
                <a href="veiculosrotas_edita.jsp?id=<%= v.getIdVeiculo() %>">Editar</a>
            </td>
        </tr>
    <%
        }
    %>
    </table>
<%
    }
%>

<p><a href="veiculosrotas_cad.jsp">Novo</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
