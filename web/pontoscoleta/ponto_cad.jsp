<%@page import="model.PontoColeta"%>
<%@page import="model.DAO.PontoColetaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Cadastrar Ponto de Coleta</title>
</head>
<body>

<div class="form-wrapper">

    <h1>Cadastrar Ponto de Coleta</h1>

    <form method="post">

        <div class="form-group">
            <label>Nome do ponto:</label>
            <input type="text" name="nomePonto" required>
        </div>

        <div class="form-group">
            <label>Endereço:</label>
            <input type="text" name="endereco" required>
        </div>

        <div class="form-group">
            <label>Capacidade (kg):</label>
            <input type="number" step="0.01" name="capacidadeKg">
        </div>

        <div class="form-group">
            <label>Status:</label>
            <select name="status">
                <option value="ATIVO">ATIVO</option>
                <option value="INATIVO">INATIVO</option>
                <option value="SOBRECARGA">SOBRECARGA</option>
            </select>
        </div>

        <div class="form-group">
            <label>Freq. Coleta (dias):</label>
            <input type="number" name="frequenciaColetaDias" value="7">
        </div>

        <button class="btn" type="submit">Salvar</button>

        <div class="voltar-link">
            <a href="../index.html" target="_parent">Voltar</a>
        </div>

    </form>

    <!-- Mensagens do JSP -->
    <div style="margin-top: 15px; text-align:center;">
        <%
            String nomePonto = request.getParameter("nomePonto");
            if (nomePonto != null) {
                String endereco = request.getParameter("endereco");
                String capacidadeKgStr = request.getParameter("capacidadeKg");
                String status = request.getParameter("status");
                String frequenciaStr = request.getParameter("frequenciaColetaDias");

                double capacidadeKg = 0;
                int frequencia = 0;

                try {
                    if (capacidadeKgStr != null && !capacidadeKgStr.isEmpty()) {
                        capacidadeKg = Double.parseDouble(capacidadeKgStr);
                    }
                    if (frequenciaStr != null && !frequenciaStr.isEmpty()) {
                        frequencia = Integer.parseInt(frequenciaStr);
                    }

                    PontoColeta pc = new PontoColeta();
                    pc.setNomePonto(nomePonto);
                    pc.setEndereco(endereco);
                    pc.setCapacidadeKg(capacidadeKg);
                    pc.setStatus(status);
                    pc.setFrequenciaColetaDias(frequencia);

                    PontoColetaDAO dao = new PontoColetaDAO();
                    boolean ok = dao.inserir(pc);

                    if (ok) { out.println("<p style='color:#22c55e'>Registro salvo com sucesso!</p>"); }
                    else { out.println("<p style='color:#ef4444'>Falha ao salvar registro.</p>"); }

                } catch (Exception e) {
                    out.println("<p style='color:#f87171'>Erro: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

</div>

</body>
</html>
