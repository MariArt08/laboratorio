/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

/**
 *
 * @author Mariangel
 */
public class reservas {
    int id;
    int FkPasajero;
    String numAsiento;
    int FkVuelo;
    String estado;
    
    public reservas (int id, String numAsiento,String estado, int FkVuelo,int FkPasajero) {
        this.id = id;
        this.numAsiento = numAsiento;
        this.estado = estado;
        this.FkVuelo = FkVuelo;
        this.FkPasajero = FkPasajero;
    }

    public reservas() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFkPasajero() {
        return FkPasajero;
    }

    public void setFkPasajero(int FkPasajero) {
        this.FkPasajero = FkPasajero;
    }

    public String getNumAsiento() {
        return numAsiento;
    }

    public void setNumAsiento(String numAsiento) {
        this.numAsiento = numAsiento;
    }

    public int getFkVuelo() {
        return FkVuelo;
    }

    public void setFkVuelo(int FkVuelo) {
        this.FkVuelo = FkVuelo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}
