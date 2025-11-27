package model;

public class MovimentoResiduo {
    private int idMovimento;
    private String dataMovimento;
    private int idPonto;
    private int idTipo;
    private int idVeiculo;
    private int idDestino;
    private double pesoKg;
    private String observacoes;

    public MovimentoResiduo() {
    }

    public MovimentoResiduo(int idMovimento, String dataMovimento, int idPonto, int idTipo, int idVeiculo, int idDestino, double pesoKg, String observacoes) {
        this.idMovimento = idMovimento;
        this.dataMovimento = dataMovimento;
        this.idPonto = idPonto;
        this.idTipo = idTipo;
        this.idVeiculo = idVeiculo;
        this.idDestino = idDestino;
        this.pesoKg = pesoKg;
        this.observacoes = observacoes;
    }

    public int getIdMovimento() {
        return idMovimento;
    }

    public void setIdMovimento(int idMovimento) {
        this.idMovimento = idMovimento;
    }

    public String getDataMovimento() {
        return dataMovimento;
    }

    public void setDataMovimento(String dataMovimento) {
        this.dataMovimento = dataMovimento;
    }

    public int getIdPonto() {
        return idPonto;
    }

    public void setIdPonto(int idPonto) {
        this.idPonto = idPonto;
    }

    public int getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(int idTipo) {
        this.idTipo = idTipo;
    }

    public int getIdVeiculo() {
        return idVeiculo;
    }

    public void setIdVeiculo(int idVeiculo) {
        this.idVeiculo = idVeiculo;
    }

    public int getIdDestino() {
        return idDestino;
    }

    public void setIdDestino(int idDestino) {
        this.idDestino = idDestino;
    }

    public double getPesoKg() {
        return pesoKg;
    }

    public void setPesoKg(double pesoKg) {
        this.pesoKg = pesoKg;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

}