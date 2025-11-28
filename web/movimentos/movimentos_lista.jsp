<%@page import="java.util.List"%>
<%@page import="model.MovimentoResiduo"%>
<%@page import="model.DAO.MovimentoResiduoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista - Movimentação de Resíduos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<h1>Movimentação de Resíduos</h1>

<%
    List<MovimentoResiduo> lista = null;
    String erro = null;

    try {
        MovimentoResiduoDAO dao = new MovimentoResiduoDAO();
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
    <p>Nenhum movimento registrado.</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Data</th>
            <th>ID Ponto</th>
            <th>ID Tipo</th>
            <th>ID Veículo</th>
            <th>ID Destino</th>
            <th>Peso (kg)</th>
            <th>Obs.</th>
            <th>Ações</th>
        </tr>
    <%
        for (MovimentoResiduo m : lista) {
    %>
        <tr>
            <td><%= m.getIdMovimento() %></td>
            <td><%= m.getDataMovimento() %></td>
            <td><%= m.getIdPonto() %></td>
            <td><%= m.getIdTipo() %></td>
            <td><%= m.getIdVeiculo() %></td>
            <td><%= m.getIdDestino() %></td>
            <td><%= m.getPesoKg() %></td>
            <td><%= m.getObservacoes() %></td>
            <td>
                <a href="movimentos_edita.jsp?id=<%= m.getIdMovimento() %>">Editar</a>
            </td>
        </tr>
    <%
        }
    %>
    </table>
<%
    }
%>

<p><a href="movimentos_cad.jsp">Novo movimento</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
