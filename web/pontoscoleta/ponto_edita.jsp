<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.DAO.PontoColetaDAO"%>
<%@page import="model.PontoColeta"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Ponto de Coleta</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";
    PontoColeta ponto = null;
    PontoColetaDAO dao = new PontoColetaDAO();

    String metodo = request.getMethod();           // GET ou POST
    String acao = request.getParameter("acao");    // "carregar" ou "atualizar"

    try {
        if ("POST".equalsIgnoreCase(metodo)) {
            if ("carregar".equalsIgnoreCase(acao)) {
                // Carrega o registro pelo ID informado
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    ponto = dao.buscarPorId(id);
                    if (ponto == null) {
                        mensagem = "Ponto de coleta não encontrado para o ID informado.";
                    }
                } else {
                    mensagem = "Informe um ID para carregar.";
                }
            } else if ("atualizar".equalsIgnoreCase(acao)) {
                // Atualiza o registro com os dados do formulário
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    String nomePonto = request.getParameter("nome_ponto");
                    String endereco = request.getParameter("endereco");
                    String capacidadeStr = request.getParameter("capacidade_kg");
                    String status = request.getParameter("status");
                    String freqStr = request.getParameter("frequencia_coleta_dias");

                    double capacidadeKg = 0;
                    int freq = 0;
                    if (capacidadeStr != null && !capacidadeStr.isEmpty()) {
                        capacidadeKg = Double.parseDouble(capacidadeStr);
                    }
                    if (freqStr != null && !freqStr.isEmpty()) {
                        freq = Integer.parseInt(freqStr);
                    }

                    PontoColeta p = new PontoColeta();
                    p.setId(id);
                    p.setNomePonto(nomePonto);
                    p.setEndereco(endereco);
                    p.setCapacidadeKg(capacidadeKg);
                    p.setStatus(status);
                    p.setFrequenciaColetaDias(freq);

                    if (dao.atualizar(p)) {
                        mensagem = "Registro atualizado com sucesso!";
                        ponto = p; // mantém na tela os dados atualizados
                    } else {
                        mensagem = "Erro ao atualizar o registro. Verifique o ID.";
                    }
                } else {
                    mensagem = "ID é obrigatório para atualizar.";
                }
            }
        } else {
            // GET com parâmetro id na URL: editarPonto.jsp?id=1
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                ponto = dao.buscarPorId(id);
                if (ponto == null) {
                    mensagem = "Ponto de coleta não encontrado para o ID informado.";
                }
            }
        }
    } catch (Exception e) {
        mensagem = "Erro: " + e.getMessage();
    }

    // Valores padrão para preencher o formulário
    String vId          = (ponto != null) ? String.valueOf(ponto.getId()) : "";
    String vNome        = (ponto != null) ? ponto.getNomePonto() : "";
    String vEndereco    = (ponto != null) ? ponto.getEndereco() : "";
    String vCapacidade  = (ponto != null) ? String.valueOf(ponto.getCapacidadeKg()) : "";
    String vStatus      = (ponto != null) ? ponto.getStatus() : "";
    String vFreq        = (ponto != null) ? String.valueOf(ponto.getFrequenciaColetaDias()) : "";
%>

<div class="form-wrapper">

    <h1>Editar Ponto de Coleta</h1>

    <form method="post">
        
        <div class="form-group">
            <label>ID do ponto:</label>
            <input type="text" name="id" required>
        </div>

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
            <input type="number" name="capacidadeKg" required>
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
            <label>Frequência de coleta (dias):</label>
            <input type="number" name="frequenciaColetaDias" required>
        </div>

        <button class="btn-sistema" name="acao" value="carregar">Carregar</button>
        <button class="btn-sistema" name="acao" value="atualizar">Atualizar</button>

    </form>

    <div class="voltar-link">
        <a href="index-coleta.html">Voltar</a>
    </div>

</div>

<!--    <h1>Editar Ponto de Coleta</h1>

    <% if (mensagem != null && !mensagem.isEmpty()) { %>
        <p style="color:red;"><%= mensagem %></p>
    <% } %>

    <form method="post" action="editarPonto.jsp">
        <label>ID do ponto:</label>
        <input type="number" name="id" value="<%= vId %>" required><br><br>

        <label>Nome do ponto:</label>
        <input type="text" name="nome_ponto" value="<%= vNome %>"><br><br>

        <label>Endereço:</label>
        <input type="text" name="endereco" value="<%= vEndereco %>"><br><br>

        <label>Capacidade (kg):</label>
        <input type="number" step="0.01" name="capacidade_kg" value="<%= vCapacidade %>"><br><br>

        <label>Status:</label>
        <input type="text" name="status" value="<%= vStatus %>"><br><br>

        <label>Frequência de coleta (dias):</label>
        <input type="number" name="frequencia_coleta_dias" value="<%= vFreq %>"><br><br>

         Dois botões na mesma tela: carregar e atualizar 
        <input type="submit" name="acao" value="carregar">
        <input type="submit" name="acao" value="atualizar">
    </form>-->

<!--    <p><a href="index.html">Voltar</a></p>-->
</body>
</html>
