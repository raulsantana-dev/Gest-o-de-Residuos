package model;

public class DestinoFinal {
    private int idDestino;
    private String nomeLocal;
    private String tipoLocal;
    private String endereco;
    private double capacidadeDiaria;

    public DestinoFinal() {
    }

    public DestinoFinal(int idDestino, String nomeLocal, String tipoLocal, String endereco, double capacidadeDiaria) {
        this.idDestino = idDestino;
        this.nomeLocal = nomeLocal;
        this.tipoLocal = tipoLocal;
        this.endereco = endereco;
        this.capacidadeDiaria = capacidadeDiaria;
    }

    public int getIdDestino() {
        return idDestino;
    }

    public void setIdDestino(int idDestino) {
        this.idDestino = idDestino;
    }

    public String getNomeLocal() {
        return nomeLocal;
    }

    public void setNomeLocal(String nomeLocal) {
        this.nomeLocal = nomeLocal;
    }

    public String getTipoLocal() {
        return tipoLocal;
    }

    public void setTipoLocal(String tipoLocal) {
        this.tipoLocal = tipoLocal;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public double getCapacidadeDiaria() {
        return capacidadeDiaria;
    }

    public void setCapacidadeDiaria(double capacidadeDiaria) {
        this.capacidadeDiaria = capacidadeDiaria;
    }

}