package model;

public class PontoColeta {
    private int id;
    private String nomePonto;
    private String endereco;
    private double capacidadeKg;
    private String status;
    private int frequenciaColetaDias;

    public PontoColeta() {
    }

    public PontoColeta(int id, String nomePonto, String endereco, double capacidadeKg, String status, int frequenciaColetaDias) {
        this.id = id;
        this.nomePonto = nomePonto;
        this.endereco = endereco;
        this.capacidadeKg = capacidadeKg;
        this.status = status;
        this.frequenciaColetaDias = frequenciaColetaDias;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomePonto() {
        return nomePonto;
    }

    public void setNomePonto(String nomePonto) {
        this.nomePonto = nomePonto;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public double getCapacidadeKg() {
        return capacidadeKg;
    }

    public void setCapacidadeKg(double capacidadeKg) {
        this.capacidadeKg = capacidadeKg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getFrequenciaColetaDias() {
        return frequenciaColetaDias;
    }

    public void setFrequenciaColetaDias(int frequenciaColetaDias) {
        this.frequenciaColetaDias = frequenciaColetaDias;
    }

}