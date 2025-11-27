package model;

public class VeiculoRota {
    private int idVeiculo;
    private String placa;
    private double capacidadeM3;
    private String rotaNome;
    private String rotaDescricao;
    private String diaSemanaRota;

    public VeiculoRota() {
    }

    public VeiculoRota(int idVeiculo, String placa, double capacidadeM3, String rotaNome, String rotaDescricao, String diaSemanaRota) {
        this.idVeiculo = idVeiculo;
        this.placa = placa;
        this.capacidadeM3 = capacidadeM3;
        this.rotaNome = rotaNome;
        this.rotaDescricao = rotaDescricao;
        this.diaSemanaRota = diaSemanaRota;
    }

    public int getIdVeiculo() {
        return idVeiculo;
    }

    public void setIdVeiculo(int idVeiculo) {
        this.idVeiculo = idVeiculo;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public double getCapacidadeM3() {
        return capacidadeM3;
    }

    public void setCapacidadeM3(double capacidadeM3) {
        this.capacidadeM3 = capacidadeM3;
    }

    public String getRotaNome() {
        return rotaNome;
    }

    public void setRotaNome(String rotaNome) {
        this.rotaNome = rotaNome;
    }

    public String getRotaDescricao() {
        return rotaDescricao;
    }

    public void setRotaDescricao(String rotaDescricao) {
        this.rotaDescricao = rotaDescricao;
    }

    public String getDiaSemanaRota() {
        return diaSemanaRota;
    }

    public void setDiaSemanaRota(String diaSemanaRota) {
        this.diaSemanaRota = diaSemanaRota;
    }

}