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
    <h1>Cadastrar Ponto de Coleta</h1>
    <form method="post">
        Nome do ponto: <input type="text" name="nomePonto" required><br>
        Endereço: <input type="text" name="endereco" required><br>
        Capacidade (kg): <input type="number" step="0.01" name="capacidadeKg"><br>
        Status: 
        <select name="status">
            <option value="ATIVO">ATIVO</option>
            <option value="INATIVO">INATIVO</option>
            <option value="SOBRECARGA">SOBRECARGA</option>
        </select><br>
        Freq. Coleta (dias): <input type="number" name="frequenciaColetaDias" value="7"><br>
        <input type="submit" value="Salvar">
    </form>
    <p><a href="index.html">Voltar</a></p>
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
                if (ok) {
                    out.println("<p>Registro salvo com sucesso!</p>");
                } else {
                    out.println("<p>Falha ao salvar registro.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Erro: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
