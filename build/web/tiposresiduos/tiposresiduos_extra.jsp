<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Config.ConectaBanco"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Visualização - Inventário de Tipos de Resíduos</title>
</head>
<body>
    <h1>Visualização / Relatório - Inventário de Tipos de Resíduos</h1>

    <h3>Filtro</h3>
    <form method="get" action="tiposresiduos_extra.jsp">
        Nome do material: 
        <input type="text" name="filtroMaterial" value="<%= request.getParameter("filtroMaterial") != null ? request.getParameter("filtroMaterial") : "" %>">
        <input type="submit" value="Pesquisar">
        <a href="tiposresiduos_extra.jsp">Limpar</a>
    </form>
    <br>

<%
    String filtroMaterial = request.getParameter("filtroMaterial");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    double totalKg = 0.0;
    double totalValor = 0.0;

    try {
        conn = ConectaBanco.conectar();

        String sql = "SELECT data_movimento, nome_material, ponto_coleta, quantidade_kg, valor_total " +
                     "FROM VW_RESIDUOS_MOVIMENTADOS";

        boolean temFiltro = (filtroMaterial != null && !filtroMaterial.trim().isEmpty());

        if (temFiltro) {
            sql += " WHERE nome_material LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + filtroMaterial.trim() + "%");
        } else {
            ps = conn.prepareStatement(sql);
        }

        rs = ps.executeQuery();
%>

    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Data movimento</th>
            <th>Material</th>
            <th>Ponto de coleta</th>
            <th>Quantidade (kg)</th>
            <th>Valor total</th>
        </tr>
<%
        boolean temRegistros = false;
        while (rs.next()) {
            temRegistros = true;

            String dataMov = rs.getString("data_movimento"); // ajustar se for DATE/TIMESTAMP
            String nomeMat = rs.getString("nome_material");
            String ponto = rs.getString("ponto_coleta");
            double qtdKg = rs.getDouble("quantidade_kg");
            double valor = rs.getDouble("valor_total");

            totalKg += qtdKg;
            totalValor += valor;
%>
        <tr>
            <td><%= dataMov %></td>
            <td><%= nomeMat %></td>
            <td><%= ponto %></td>
            <td><%= qtdKg %></td>
            <td><%= valor %></td>
        </tr>
<%
        } // fim while

        if (!temRegistros) {
%>
        <tr>
            <td colspan="5">Nenhum registro encontrado.</td>
        </tr>
<%
        }
%>
        <tr>
            <th colspan="3" style="text-align:right;">Totais:</th>
            <th><%= totalKg %> kg</th>
            <th><%= totalValor %></th>
        </tr>
    </table>
<%
    } catch (Exception e) {
%>
    <p style="color:red;">Erro ao carregar relatório: <%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ex) {}
        try { if (ps != null) ps.close(); } catch (Exception ex) {}
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>
    <br>
    <p><a href="tiposresiduos_lista.jsp">Voltar para lista de tipos</a></p>
    <p><a href="index.html">Voltar ao início</a></p>
</body>
</html>
