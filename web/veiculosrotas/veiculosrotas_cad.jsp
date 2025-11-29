<%@page import="model.DAO.VeiculoRotaDAO"%>
<%@page import="model.VeiculoRota"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Veículos / Rotas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="form-group">

<%
    request.setCharacterEncoding("UTF-8");
    String msg = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String placa = request.getParameter("placa");
        String cap = request.getParameter("capacidadeM3");
        String rotaNome = request.getParameter("rotaNome");
        String rotaDesc = request.getParameter("rotaDescricao");
        String dia = request.getParameter("diaSemanaRota");

        double capacidadeM3 = 0;
        if (cap != null && cap.trim().length() > 0) {
            try {
                capacidadeM3 = Double.parseDouble(cap.replace(",", "."));
            } catch (NumberFormatException e) {
                msg = "Capacidade inválida.";
            }
        }

        if (msg == null) {
            try {
                VeiculoRota v = new VeiculoRota();
                v.setPlaca(placa);
                v.setCapacidadeM3(capacidadeM3);
                v.setRotaNome(rotaNome);
                v.setRotaDescricao(rotaDesc);
                v.setDiaSemanaRota(dia);

                VeiculoRotaDAO dao = new VeiculoRotaDAO();
                boolean ok = dao.inserir(v);

                if (ok) {
                    msg = "Registro salvo.";
                } else {
                    msg = "Não foi possível salvar.";
                }
            } catch (Exception e) {
                msg = "Erro: " + e.getMessage();
            }
        }
    }
%>

<h1 class="form-group">Cadastro de Veículos / Rotas</h1>

<% if (msg != null) { %>
    <p><%= msg %></p>
<% } %>

<form class="form-group" method="post">
    Placa: <input type="text" name="placa" required><br><br>
    Capacidade (m³): <input type="number" step="0.01" name="capacidadeM3"><br><br>
    Nome da rota: <input type="text" name="rotaNome"><br><br>
    Descrição da rota: <input type="text" name="rotaDescricao"><br><br>
    Dia da semana: <input type="text" name="diaSemanaRota"><br><br>

    <input type="submit" value="Salvar">
</form>

<p><a href="veiculosrotas_lista.jsp">Ver lista</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
