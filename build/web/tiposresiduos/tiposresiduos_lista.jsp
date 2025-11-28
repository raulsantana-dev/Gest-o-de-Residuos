<%@page import="java.util.List"%>
<%@page import="model.TipoResiduo"%>
<%@page import="model.DAO.TipoResiduoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Lista - Inventário de Tipos de Resíduos</title>
</head>
<body>
    <h1>Lista - Inventário de Tipos de Resíduos</h1>

    <%
        try {
            TipoResiduoDAO dao = new TipoResiduoDAO();
            List<TipoResiduo> lista = dao.listarTodos();

            if (lista == null || lista.isEmpty()) {
    %>
                <p>Nenhum tipo de resíduo cadastrado.</p>
    <%
            } else {
    %>
                <table border="1" cellpadding="5" cellspacing="0">
                    <tr>
                        <th>ID</th>
                        <th>Nome do material</th>
                        <th>Código interno</th>
                        <th>Densidade (kg/m³)</th>
                        <th>Valor venda estimado</th>
                        <th>Ações</th>
                    </tr>
    <%
                for (TipoResiduo tr : lista) {
    %>
                    <tr>
                        <td><%= tr.getIdTipo() %></td>
                        <td><%= tr.getNomeMaterial() %></td>
                        <td><%= tr.getCodigoInterno() %></td>
                        <td><%= tr.getDensidadeKgM3() %></td>
                        <td><%= tr.getValorVendaEstimado() %></td>
                        <td>
                            <a href="tiposresiduos_edita.jsp?id=<%= tr.getIdTipo() %>">Editar</a>
                            <!-- Poderia ter também um excluir.jsp depois -->
                        </td>
                    </tr>
    <%
                } // fim for
    %>
                </table>
    <%
            } // fim else
        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro: " + e.getMessage() + "</p>");
        }
    %>

    <p><a href="tiposresiduos_cad.jsp">Cadastrar novo tipo de resíduo</a></p>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
