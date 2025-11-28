<%@page import="model.DAO.MovimentoResiduoDAO"%>
<%@page import="model.MovimentoResiduo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar - Movimentação de Resíduos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    MovimentoResiduo mov = null;
    String msg = null;

    MovimentoResiduoDAO dao = null;
    try {
        dao = new MovimentoResiduoDAO();
    } catch (Exception e) {
        msg = "Erro ao abrir DAO: " + e.getMessage();
    }

    if (dao != null) {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String idStr = request.getParameter("id");
            String dataMovimento = request.getParameter("dataMovimento");
            String idPontoStr = request.getParameter("idPonto");
            String idTipoStr = request.getParameter("idTipo");
            String idVeiculoStr = request.getParameter("idVeiculo");
            String idDestinoStr = request.getParameter("idDestino");
            String pesoStr = request.getParameter("pesoKg");
            String observacoes = request.getParameter("observacoes");

            try {
                int id = Integer.parseInt(idStr);

                int idPonto = 0;
                int idTipo = 0;
                int idVeiculo = 0;
                int idDestino = 0;
                double pesoKg = 0;

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
                m.setIdMovimento(id);
                m.setDataMovimento(dataMovimento);
                m.setIdPonto(idPonto);
                m.setIdTipo(idTipo);
                m.setIdVeiculo(idVeiculo);
                m.setIdDestino(idDestino);
                m.setPesoKg(pesoKg);
                m.setObservacoes(observacoes);

                boolean ok = dao.atualizar(m);
                if (ok) {
                    msg = "Movimento atualizado.";
                } else {
                    msg = "Não foi possível atualizar.";
                }
                mov = m;

            } catch (Exception e) {
                msg = "Erro: " + e.getMessage();
            }

        } else { // GET
            String idStr = request.getParameter("id");
            if (idStr != null && idStr.trim().length() > 0) {
                try {
                    int id = Integer.parseInt(idStr);
                    mov = dao.buscarPorId(id);
                    if (mov == null) {
                        msg = "Registro não encontrado.";
                    }
                } catch (Exception e) {
                    msg = "Erro: " + e.getMessage();
                }
            } else {
                msg = "ID não informado.";
            }
        }
    }

    String vId = (mov != null) ? String.valueOf(mov.getIdMovimento()) : "";
    String vData = (mov != null) ? mov.getDataMovimento() : "";
    String vPonto = (mov != null) ? String.valueOf(mov.getIdPonto()) : "";
    String vTipo = (mov != null) ? String.valueOf(mov.getIdTipo()) : "";
    String vVeiculo = (mov != null) ? String.valueOf(mov.getIdVeiculo()) : "";
    String vDestino = (mov != null) ? String.valueOf(mov.getIdDestino()) : "";
    String vPeso = (mov != null) ? String.valueOf(mov.getPesoKg()) : "";
    String vObs = (mov != null) ? mov.getObservacoes() : "";
%>

<h1>Editar - Movimentação de Resíduos</h1>

<% if (msg != null) { %>
    <p><%= msg %></p>
<% } %>

<form method="post">
    ID: <input type="number" name="id" value="<%= vId %>" readonly><br><br>
    Data movimento (AAAA-MM-DD HH:MM:SS): <input type="text" name="dataMovimento" value="<%= vData %>"><br><br>
    ID Ponto: <input type="number" name="idPonto" value="<%= vPonto %>"><br><br>
    ID Tipo de resíduo: <input type="number" name="idTipo" value="<%= vTipo %>"><br><br>
    ID Veículo: <input type="number" name="idVeiculo" value="<%= vVeiculo %>"><br><br>
    ID Destino: <input type="number" name="idDestino" value="<%= vDestino %>"><br><br>
    Peso (kg): <input type="number" step="0.01" name="pesoKg" value="<%= vPeso %>"><br><br>
    Observações:<br>
    <textarea name="observacoes" rows="4" cols="40"><%= vObs %></textarea><br><br>

    <input type="submit" value="Salvar alterações">
</form>

<p><a href="movimentos_lista.jsp">Voltar para lista</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
