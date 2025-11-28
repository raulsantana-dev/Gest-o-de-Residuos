<%@page import="model.DAO.MovimentoResiduoDAO"%>
<%@page import="model.MovimentoResiduo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro - Movimentação de Resíduos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    String msg = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String dataMovimento = request.getParameter("dataMovimento");
        String idPontoStr = request.getParameter("idPonto");
        String idTipoStr = request.getParameter("idTipo");
        String idVeiculoStr = request.getParameter("idVeiculo");
        String idDestinoStr = request.getParameter("idDestino");
        String pesoStr = request.getParameter("pesoKg");
        String observacoes = request.getParameter("observacoes");

        int idPonto = 0;
        int idTipo = 0;
        int idVeiculo = 0;
        int idDestino = 0;
        double pesoKg = 0;

        try {
            if (idPontoStr != null && idPontoStr.trim().length() > 0) {
                idPonto = Integer.parseInt(idPontoStr);
            }
            if (idTipoStr != null && idTipoStr.trim().length() > 0) {
                idTipo = Integer.parseInt(idTipoStr);
            }
            if (idVeiculoStr != null && idVeiculoStr.trim().length() > 0) {
                idVeiculo = Integer.parseInt(idVeiculoStr);
            }
            if (idDestinoStr != null && idDestinoStr.trim().length() > 0) {
                idDestino = Integer.parseInt(idDestinoStr);
            }
            if (pesoStr != null && pesoStr.trim().length() > 0) {
                pesoKg = Double.parseDouble(pesoStr.replace(",", "."));
            }

            MovimentoResiduo m = new MovimentoResiduo();
            m.setDataMovimento(dataMovimento);
            m.setIdPonto(idPonto);
            m.setIdTipo(idTipo);
            m.setIdVeiculo(idVeiculo);
            m.setIdDestino(idDestino);
            m.setPesoKg(pesoKg);
            m.setObservacoes(observacoes);

            MovimentoResiduoDAO dao = new MovimentoResiduoDAO();
            boolean ok = dao.inserir(m);

            if (ok) {
                msg = "Movimento registrado.";
            } else {
                msg = "Não foi possível salvar.";
            }

        } catch (Exception e) {
            msg = "Erro: " + e.getMessage();
        }
    }
%>

<h1>Cadastro - Movimentação de Resíduos</h1>

<% if (msg != null) { %>
    <p><%= msg %></p>
<% } %>

<form method="post">
    Data movimento (AAAA-MM-DD HH:MM:SS): <input type="text" name="dataMovimento"><br><br>
    ID Ponto: <input type="number" name="idPonto"><br><br>
    ID Tipo de resíduo: <input type="number" name="idTipo"><br><br>
    ID Veículo: <input type="number" name="idVeiculo"><br><br>
    ID Destino: <input type="number" name="idDestino"><br><br>
    Peso (kg): <input type="number" step="0.01" name="pesoKg"><br><br>
    Observações:<br>
    <textarea name="observacoes" rows="4" cols="40"></textarea><br><br>

    <input type="submit" value="Salvar">
</form>

<p><a href="movimentos_lista.jsp">Ver movimentos</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
