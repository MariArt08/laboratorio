/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

import com.microsoft.sqlserver.jdbc.SQLServerException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import javax.swing.JOptionPane;

/**
 *
 * @author Mariangel
 */
public class Conexion {
    public Conexion() {
    }
    
    public static Connection getConexion()throws SQLException 
    {
        String cadenaConexion = "jdbc:sqlserver://localhost:1433;" //controlador jdbc, servidor y su puerto
                + "database=laboratorio;" //Base de datos a usar
                + "user=sa;" //usuario de la base de datos a conectar
                + "password=Mari1234;" //contraseña del usuario
                + "encrypt=true;" //conexion encriptada
                + "trustServerCertificate=true;";  //certificado de conexion
        try {
            Connection con = DriverManager.getConnection(cadenaConexion);
            return con;
            
        } catch(SQLServerException ex) {
            JOptionPane.showMessageDialog(null, ex.toString());
            return null;
        }
    }
    
    //trae el siguiente numero consecutivo de los vuelos
    public static int siguienteVuelo()  throws SQLException{
        int resultado =1;
        try {
            //--Declarar la conexion a sql server 
            Statement sql = (Statement )Conexion.getConexion().createStatement();
            //-- Variable con la sentenia o script sql
            String consulta = " Select Max(id_vuelo) as id  "+
                              " From vuelos ";
            
            //--Ejecutar la consulta y llenar una estructura con el o los resultados obtenidos
            ResultSet rs = sql.executeQuery(consulta);
            while (rs.next() ) {
                resultado = ( rs.getInt(1) + 1 );
            }
            
        }catch (SQLServerException e){
            JOptionPane.showMessageDialog(null, e.toString());
        }

        return resultado;
    }
    
    //Metodo para levantar/cargar los datos del vuelo en un objeto
    public static vuelos obtenerVuelos(String id) throws SQLException   {
        
        try {
            //--Declarar la conexion a sql server 
            Statement sql = (Statement )Conexion.getConexion().createStatement();
            //-- Variable con la sentenia o script sql
            String consulta = " Select * " +
                              " From vuelos " +
                              " Where id_vuelo = " + id;
            
            //--Ejecutar la consulta y llenar una estructura con el o los resultados obtenidos
            ResultSet rs = sql.executeQuery(consulta);
            
            
            vuelos Encontrado = new vuelos();
            while (rs.next() ) {
              Encontrado.setId( rs.getInt(1)); 
              Encontrado.setNumVuelo(rs.getString(2));
              Encontrado.setOrigen(rs.getString(3));
              Encontrado.setDestino(rs.getString(4));
              Encontrado.setFecha( rs.getDate(5));
              Encontrado.setFkAvion(rs.getInt(6));
            }
            
            return Encontrado;
            
        }catch (SQLServerException e){
            
            JOptionPane.showMessageDialog(null, e.toString());
            return null;
        }
    }
    
    public static ResultSet listarVuelos() throws SQLException    {
         try {
            //--Declarar la conexion a sql server 
            Statement sql = (Statement )Conexion.getConexion().createStatement();
            //-- Variable con la sentenia o script sql
            String consulta = " Select * " +
                              " From vuelos ";
            
            //--Ejecutar la consulta y llenar una estructura con el o los resultados obtenidos
            ResultSet rs = sql.executeQuery(consulta);
            return rs;
            

        }catch (SQLServerException e){
            
            JOptionPane.showMessageDialog(null, e.toString());
            return null;
        }
    }
    
    
    public static int insertVuelo (vuelos miVuelo) throws SQLException{
        int filasAfectadas = 0;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaSQL = sdf.format(miVuelo.getFecha());
        
        Statement sql = (Statement )Conexion.getConexion().createStatement();
        String insertar = " Insert into vuelos " +
                          " Values( " +  miVuelo.getId() + "," +
                          "'" + miVuelo.getNumVuelo() + "' ," +
                          "'" + miVuelo.getOrigen() + "' ," +
                          "'" + miVuelo.getDestino() + "' ,"+
                          "'" + fechaSQL + "' ," +
                          miVuelo.getFkAvion() + ")";
        filasAfectadas = sql.executeUpdate(insertar);
        
        return filasAfectadas;
    }
    
    public static int updateVuelos (vuelos miVuelo)throws SQLException{ //u = update
        int filasAfectadas = 0;
        
        Statement sql = (Statement )Conexion.getConexion().createStatement();
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaSQL = sdf.format(miVuelo.getFecha());
        
        String update =" Update vuelos" +
                       " Set num_vuelo = '" + miVuelo.getNumVuelo() + "'," +
                       " origen = '" + miVuelo.getOrigen() + "', " +
                       " destino = '" + miVuelo.getDestino() + "', " +
                       " fecha = '" + fechaSQL + "'," +
                       " avion = " + miVuelo.getFkAvion() + 
                       " where id_vuelo = " + miVuelo.getId();
        filasAfectadas = sql.executeUpdate(update);
        
        
        return filasAfectadas;
    }
    public static int deleteVuelos(int Id) throws SQLException{ //D = delete
        int filasAfectadas = 0;
        
        Statement sql = (Statement )Conexion.getConexion().createStatement();
        String delete =" Delete from vuelos" +
                       " where id_vuelo = " + Id;
        filasAfectadas = sql.executeUpdate(delete);
        
        return filasAfectadas;
    }
    
     //trae el siguiente numero consecutivo de las reservas
    public static int siguienteReserva()  throws SQLException{
        int resultado =1;
        try {
            //--Declarar la conexion a sql server 
            Statement sql = (Statement )Conexion.getConexion().createStatement();
            //-- Variable con la sentenia o script sql
            String consulta = " Select Max(id_reserva) as id  "+
                              " From reservas ";
            
            //--Ejecutar la consulta y llenar una estructura con el o los resultados obtenidos
            ResultSet rs = sql.executeQuery(consulta);
            while (rs.next() ) {
                resultado = ( rs.getInt(1) + 1 );
            }
            
        }catch (SQLServerException e){
            JOptionPane.showMessageDialog(null, e.toString());
        }

        return resultado;
    }
    
    //Metodo para levantar/cargar los datos de la reserva en un objeto
    public static reservas obtenerReservas(String id) throws SQLException   {
        
        try {
            //--Declarar la conexion a sql server 
            Statement sql = (Statement )Conexion.getConexion().createStatement();
            //-- Variable con la sentenia o script sql
            String consulta = " Select * " +
                              " From reservas " +
                              " Where id_reserva = " + id;
            
            //--Ejecutar la consulta y llenar una estructura con el o los resultados obtenidos
            ResultSet rs = sql.executeQuery(consulta);
            
            
            reservas Encontrado = new reservas();
            while (rs.next() ) {
              Encontrado.setId( rs.getInt(1)); 
              Encontrado.setFkVuelo(rs.getInt(2));
              Encontrado.setFkPasajero(rs.getInt(3));
              Encontrado.setNumAsiento(rs.getString(4));
              Encontrado.setEstado( rs.getString(5));
            }
            
            return Encontrado;
            
        }catch (SQLServerException e){
            
            JOptionPane.showMessageDialog(null, e.toString());
            return null;
        }
    }
    
    public static ResultSet listarReservas() throws SQLException    {
         try {
            //--Declarar la conexion a sql server 
            Statement sql = (Statement )Conexion.getConexion().createStatement();
            //-- Variable con la sentenia o script sql
            String consulta = " Select * " +
                              " From reservas ";
            
            //--Ejecutar la consulta y llenar una estructura con el o los resultados obtenidos
            ResultSet rs = sql.executeQuery(consulta);
            return rs;
            

        }catch (SQLServerException e){
            
            JOptionPane.showMessageDialog(null, e.toString());
            return null;
        }
    }
    
    
    public static int insertReservas (reservas miReserva) throws SQLException{
        int filasAfectadas = 0;
        
        Statement sql = (Statement )Conexion.getConexion().createStatement();
        String insertar = " Insert into reservas " +
                          " Values( " +  miReserva.getId() + "," +
                          miReserva.getFkVuelo() + ","+
                          miReserva.getFkPasajero() + "," +
                          "'" + miReserva.getNumAsiento() + "' ," +
                          "'" + miReserva.getEstado() + "')";
        filasAfectadas = sql.executeUpdate(insertar);
        
        return filasAfectadas;
    }
    
    public static int updateReservas (reservas miReserva)throws SQLException{ //u = update
        int filasAfectadas = 0;
        
        Statement sql = (Statement )Conexion.getConexion().createStatement();
        
        String update =" Update reservas" +
                       " Set id_vuelo = " + miReserva.getFkVuelo() + "," +
                       " id_pasajero = " + miReserva.getFkPasajero() + "," +
                       " num_asiento = '" + miReserva.getNumAsiento() + "', " +
                       " estado = '" + miReserva.getEstado() + "'" +
                       " where id_reserva = " + miReserva.getId();
        filasAfectadas = sql.executeUpdate(update);
        
        
        return filasAfectadas;
    }
    public static int deleteReservas(int Id) throws SQLException{ //D = delete
        int filasAfectadas = 0;
        
        Statement sql = (Statement )Conexion.getConexion().createStatement();
        String delete =" Delete from reservas" +
                       " where id_reserva = " + Id;
        filasAfectadas = sql.executeUpdate(delete);
        
        return filasAfectadas;
    }
}
