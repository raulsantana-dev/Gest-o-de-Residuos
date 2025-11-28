<%@page import="java.util.List"%>
<%@page import="model.DestinoFinal"%>
<%@page import="model.DAO.DestinoFinalDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista - Destino Final</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<h1>Lista - Destino Final</h1>

<%
    List<DestinoFinal> lista = null;
    String erro = null;

    try {
        DestinoFinalDAO dao = new DestinoFinalDAO();
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
    <p>Nenhum destino cadastrado.</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Nome do local</th>
            <th>Tipo</th>
            <th>Endereço</th>
            <th>Capacidade diária (kg)</th>
            <th>Ações</th>
        </tr>
    <%
        for (DestinoFinal d : lista) {
    %>
        <tr>
            <td><%= d.getIdDestino() %></td>
            <td><%= d.getNomeLocal() %></td>
            <td><%= d.getTipoLocal() %></td>
            <td><%= d.getEndereco() %></td>
            <td><%= d.getCapacidadeDiaria() %></td>
            <td>
                <a href="destinofinal_edita.jsp?id=<%= d.getIdDestino() %>">Editar</a>
            </td>
        </tr>
    <%
        }
    %>
    </table>
<%
    }
%>

<p><a href="destinofinal_cad.jsp">Novo destino</a></p>
<p><a href="index.html">Voltar</a></p>

</body>
</html>
