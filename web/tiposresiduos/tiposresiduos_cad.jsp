<%@page import="model.DAO.TipoResiduoDAO"%>
<%@page import="model.TipoResiduo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Cadastro - Inventário de Tipos de Resíduos</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String mensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String nomeMaterial = request.getParameter("nomeMaterial");
            String codigoInterno = request.getParameter("codigoInterno");
            String densidadeStr = request.getParameter("densidadeKgM3");
            String valorStr = request.getParameter("valorVendaEstimado");

            double densidade = 0;
            double valorVenda = 0;

            if (densidadeStr != null && !densidadeStr.isEmpty()) {
                densidade = Double.parseDouble(densidadeStr);
            }
            if (valorStr != null && !valorStr.isEmpty()) {
                valorVenda = Double.parseDouble(valorStr);
            }

            TipoResiduo tr = new TipoResiduo();
            tr.setNomeMaterial(nomeMaterial);
            tr.setCodigoInterno(codigoInterno);
            tr.setDensidadeKgM3(densidade);
            tr.setValorVendaEstimado(valorVenda);

            TipoResiduoDAO dao = new TipoResiduoDAO();
            if (dao.inserir(tr)) {
                mensagem = "Tipo de resíduo cadastrado com sucesso!";
            } else {
                mensagem = "Erro ao cadastrar o tipo de resíduo.";
            }
        } catch (Exception e) {
            mensagem = "Erro: " + e.getMessage();
        }
    }
%>

    <h1>Cadastro - Inventário de Tipos de Resíduos</h1>

    <% if (mensagem != null && !mensagem.isEmpty()) { %>
        <p style="color:blue;"><%= mensagem %></p>
    <% } %>

    <form method="post">
        Nome do material: <input type="text" name="nomeMaterial" required><br><br>
        Código interno: <input type="text" name="codigoInterno"><br><br>
        Densidade (kg/m³): <input type="number" step="0.01" name="densidadeKgM3"><br><br>
        Valor de venda estimado: <input type="number" step="0.01" name="valorVendaEstimado"><br><br>

        <input type="submit" value="Cadastrar">
    </form>

    <p><a href="tiposresiduos_lista.jsp">Ir para lista</a></p>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
