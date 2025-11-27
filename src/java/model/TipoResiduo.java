package model;

public class TipoResiduo {
    private int idTipo;
    private String nomeMaterial;
    private String codigoInterno;
    private double densidadeKgM3;
    private double valorVendaEstimado;

    public TipoResiduo() {
    }

    public TipoResiduo(int idTipo, String nomeMaterial, String codigoInterno, double densidadeKgM3, double valorVendaEstimado) {
        this.idTipo = idTipo;
        this.nomeMaterial = nomeMaterial;
        this.codigoInterno = codigoInterno;
        this.densidadeKgM3 = densidadeKgM3;
        this.valorVendaEstimado = valorVendaEstimado;
    }

    public int getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(int idTipo) {
        this.idTipo = idTipo;
    }

    public String getNomeMaterial() {
        return nomeMaterial;
    }

    public void setNomeMaterial(String nomeMaterial) {
        this.nomeMaterial = nomeMaterial;
    }

    public String getCodigoInterno() {
        return codigoInterno;
    }

    public void setCodigoInterno(String codigoInterno) {
        this.codigoInterno = codigoInterno;
    }

    public double getDensidadeKgM3() {
        return densidadeKgM3;
    }

    public void setDensidadeKgM3(double densidadeKgM3) {
        this.densidadeKgM3 = densidadeKgM3;
    }

    public double getValorVendaEstimado() {
        return valorVendaEstimado;
    }

    public void setValorVendaEstimado(double valorVendaEstimado) {
        this.valorVendaEstimado = valorVendaEstimado;
    }

}