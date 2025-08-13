 Sistema de Gestión de Aerolíneas

Proyecto académico que integra **Microsoft SQL Server** (backend) y **Java con NetBeans** (frontend) para la gestión integral de un aeropuesto con vuelos, pasajeros y reservas.  
Incluye seguridad avanzada, cifrado de datos, auditoría y una interfaz gráfica intuitiva.



 Componentes del Proyecto

  Base de Datos (`Laboratorio.sql`)
- **Motor:** Microsoft SQL Server.
- **Tablas principales:**
  - `aerolineas`
  - `ciudades`
  - `aviones`
  - `vuelos`
  - `pasajeros`
  - `tarifas`
  - `reservas`
- **Funciones y vistas:**
  - `fn_calcular_edad`
  - `vw_AvionesAerolineas`
  - Funciones de ventana y múltiples `JOIN`.
  - Seguridad:
  - Roles (`rol_admin`, `rol_operador`, `rol_consulta`, `rol_seguridad`).
  - Permisos granulares por columnas.
  - Cifrado AES-256 de `pasaporte`.
- **Triggers:**
  - `trg_auditar_pasajero` para registrar inserciones.
- **Plan de backups:**
  - Completo, diferencial y log.



## Interfaz Gráfica (Java  / NetBeans)

#### Ventana Principal (`JFrame`)
- Botones de acceso rápido:
  - **Vuelos** (`btnVuelos`)
  - **Reservas** (`btnReservas`)
- Diseño con `AbsoluteLayout`.
- Barra de control con minimizar, maximizar y cerrar.
- Fondo e iconos personalizados.

# Panel de Gestión de Vuelos (`JPanel`)
- Campos:
  - Código (`txtId`)
  - Número de vuelo (`txtNumVuelo`)
  - Origen (`txtOrigen`)
  - Destino (`txtDestino`)
  - Fecha (`dtpFecha` - JDateChooser)
  - ID Avión (`txtFkAviones`)
- Tabla de resultados (`tblVuelos`).
- Botones:
  - Guardar
  - Nuevo
  - Borrar
  - Consultar
  - Buscar (con icono de lupa)

## Panel de Gestión de Reservas (`JPanel`)
- Campos:
  - Código (`txtId`)
  - ID Vuelo (`txtFkVuelo`)
  - ID Pasajero (`txtFkPasajero`)
  - Número de asiento (`txtAsiento`)
  - Estado (`txtEstado`)
- Tabla de resultados (`tblReservas`).
- Botones:
  - Guardar
  - Nuevo
  - Borrar
  - Consultar
  - Buscar (con icono de lupa)

---

# Requisitos

### Backend
- Microsoft SQL Server
- SQL Server Management Studio (SSMS20)

### Frontend
- Java JDK 8 o superior
- NetBeans IDE
- Librería `com.toedter.calendar` (para `JDateChooser`)
- Carpeta `/imagenes` con:
  - `cita.png`
  - `vuelo-directo.png`
  - `aeropuerto (2).png`
  - `03- Minimizar 32x32.png`
  - `02- Maximizar 32x32.png`
  - `01- Cerrar 32x32.png`
  - `fondo.png`
  - `Fondo principal.png`
  - `search.png`s

--Usos
- Iniciar el sistema desde la ventana principal.
- Desde el menú, acceder a **Vuelos** o **Reservas**.
- Utilizar los botones para realizar operaciones CRUD.
- La base de datos aplicará permisos y auditoría automáticamente.

##  Autores
**Mariangel Artavia Rojas** – [@MariArt08]((https://github.com/MariArt08))
**Fabian Bolaños Murillo** -  [@Fqbiannn ((https://github.com/fqbiannn))

