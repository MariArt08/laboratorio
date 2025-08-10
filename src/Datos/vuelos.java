/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

import java.util.Date;

/**
 *
 * @author Mariangel
 */
public class vuelos {
    
    int id;
    String Origen;
    String Destino;
    int FkAvion;
    String NumVuelo;
    Date fecha;
    
    public vuelos(int id, String Origen,String Destino, int FkAvion,String NumVuelo,Date fecha) {
        this.id = id;
        this.Origen = Origen;
        this.Destino = Destino;
        this.FkAvion = FkAvion;
        this.NumVuelo = NumVuelo;
        this.fecha = fecha;
    }

    public vuelos() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrigen() {
        return Origen;
    }

    public void setOrigen(String Origen) {
        this.Origen = Origen;
    }

    public String getDestino() {
        return Destino;
    }

    public void setDestino(String Destino) {
        this.Destino = Destino;
    }

    public int getFkAvion() {
        return FkAvion;
    }

    public void setFkAvion(int FkAvion) {
        this.FkAvion = FkAvion;
    }

    public String getNumVuelo() {
        return NumVuelo;
    }

    public void setNumVuelo(String NumVuelo) {
        this.NumVuelo = NumVuelo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    
}
