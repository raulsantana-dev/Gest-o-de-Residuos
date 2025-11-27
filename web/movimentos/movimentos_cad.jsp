<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <meta charset="UTF-8">
    <title>Cadastro - Movimentação de Resíduos (Log Transacional)</title>
</head>
<body>
    <h1>Cadastro - Movimentação de Resíduos (Log Transacional)</h1>
    <form method="post">

        Data movimento (AAAA-MM-DD HH:MM:SS): <input type="text" name="dataMovimento"><br>
        ID Ponto: <input type="number" name="idPonto"><br>
        ID Tipo Resíduo: <input type="number" name="idTipo"><br>
        ID Veículo: <input type="number" name="idVeiculo"><br>
        ID Destino: <input type="number" name="idDestino"><br>
        Peso (kg): <input type="number" step="0.01" name="pesoKg"><br>
        Observações: <input type="text" name="observacoes"><br>

        <input type="submit" value="Salvar (protótipo)">
    </form>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
