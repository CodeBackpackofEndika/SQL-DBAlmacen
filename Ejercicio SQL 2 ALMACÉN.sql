CREATE TABLE tipos_pieza(
   tipo CHAR(2) CONSTRAINT tipos_pieza_pk PRIMARY KEY,
   descripcion VARCHAR2(25) CONSTRAINT tipos_pieza_nn1 NOT NULL
);
CREATE TABLE piezas(
   tipo CHAR(2) CONSTRAINT piezas_fk1 REFERENCES tipos_pieza,
   modelo NUMBER(2),
   precio_venta NUMBER(11,5) CONSTRAINT precio_venta_nn1 NOT NULL,
   CONSTRAINT piezas_pk PRIMARY KEY(tipo,modelo)
);
CREATE TABLE suministros(
   tipo CHAR(2),
   modelo NUMBER(2),
   cif CHAR(9) CONSTRAINT suministros_fk2 REFERENCES empresas,
   precio_compra NUMBER(11,4) CONSTRAINT suministros_nn1 NOT NULL,
   CONSTRAINT suministros_pk PRIMARY KEY (tipo,modelo,cif),
   CONSTRAINT suministros_fk1 FOREIGN KEY (tipo,modelo) REFERENCES piezas
);
CREATE TABLE empresas(
    cif CHAR(9) CONSTRAINT empresas_pk PRIMARY KEY,
    nombre VARCHAR2(50) CONSTRAINT empresas_nn1 NOT NULL 
                        CONSTRAINT empresas_uk1 UNIQUE,
    telefono CHAR(9),
    direccion VARCHAR2(50),
    localidad VARCHAR2(50),
    provincia VARCHAR2(50)
);
CREATE TABLE pedidos(
    n_pedido NUMBER(4) CONSTRAINT pedidos_pk PRIMARY KEY,
    cif CHAR(9) CONSTRAINT pedidos_nn1 NOT NULL 
           CONSTRAINT pedidos_fk1 REFERENCES empresas,
    fecha DATE CONSTRAINT pedidos_nn2 NOT NULL
);
CREATE TABLE existencias(
    tipo CHAR(2),
    modelo NUMBER(2),
    n_almacen NUMBER(2) CONSTRAINT existencias_fk2 REFERENCES almacenes,
    cantidad NUMBER(9) CONSTRAINT existencias_nn1 NOT NULL,
    CONSTRAINT existencias_pk PRIMARY KEY (tipo,modelo,n_almacen),
    CONSTRAINT existencias_fk1 FOREIGN KEY (tipo,modelo) REFERENCES piezas
);
CREATE TABLE almacenes(
  n_almacen NUMBER(2) CONSTRAINT almacenes_pk PRIMARY KEY,
  descripcion VARCHAR2(1000) CONSTRAINT almacenes_nn1 NOT NULL,
  direccion VARCHAR2(100)
);
CREATE TABLE  lineas_pedido(
  tipo CHAR(2) CONSTRAINT lineas_pedido_nn1 NOT NULL,
  modelo NUMBER(2) CONSTRAINT lineas_pedido_nn2 NOT NULL,
  n_pedido NUMBER(4) CONSTRAINT lineas_pedido_fk1 REFERENCES pedidos, 
  n_linea NUMBER(2),
  cantidad NUMBER(5),
  precio NUMBER(11,4),
  CONSTRAINT lineas_pedido_pk PRIMARY KEY(n_pedido,n_linea),
  CONSTRAINT lineas_pedido_fk2 FOREIGN KEY(tipo,modelo) REFERENCES piezas
);  
  
