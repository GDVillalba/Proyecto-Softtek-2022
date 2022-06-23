using TP_Cripto.Models;
using System.Data.SqlClient;
using System.Data;

namespace TP_Cripto.Datos
{
    public class MovimientoDatos
    {
        //Read
        public List<ModelMovimiento> ListarMovimientos(int idCuenta)
        {
            var oLista = new List<ModelMovimiento>();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();

                SqlCommand cmd = new SqlCommand("ListarMovimientosCuenta", conexion);
                cmd.Parameters.AddWithValue("idCuenta", idCuenta);//Recibe el parametro
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oLista.Add(new ModelMovimiento()
                        {
                            Id = Convert.ToInt32(dr["id"]),
                            IdCuenta = Convert.ToInt32(dr["idCuenta"]),
                            Debito = Convert.ToDecimal(dr["debito"]),
                            Credito = Convert.ToDecimal(dr["credito"]),
                            Saldo = Convert.ToDecimal(dr["saldo"]),
                            Descripcion = dr["descripcion"].ToString(),
                            Fecha = DateOnly.ParseExact(Convert.ToDateTime(dr["fecha"]).ToString("dd/MM/yyyy"), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)
                        });
                    }
                }
            }
            return oLista;
        }

        //Read by Id
        public ModelMovimiento Obtener(int id)
        {
            var oMovimiento = new ModelMovimiento();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("ObtenerMovimiento", conexion);
                cmd.Parameters.AddWithValue("id", id);//Recibe el parametro
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oMovimiento.Id = Convert.ToInt32(dr["id"]);
                        oMovimiento.IdCuenta = Convert.ToInt32(dr["idCuenta"]);
                        oMovimiento.Debito = Decimal.Parse((string)dr["debito"], System.Globalization.CultureInfo.GetCultureInfo("en-US"));
                        oMovimiento.Credito = Decimal.Parse((string)dr["credito"], System.Globalization.CultureInfo.GetCultureInfo("en-US"));
                        oMovimiento.Saldo = Decimal.Parse((string)dr["saldo"], System.Globalization.CultureInfo.GetCultureInfo("en-US"));
                        oMovimiento.Descripcion = dr["descripcion"].ToString();
                        oMovimiento.Fecha = DateOnly.ParseExact(Convert.ToDateTime(dr["fecha"]).ToString("dd/MM/yyyy"), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    }
                }

            }

            return oMovimiento;
        }

        public bool Depositar(ModelMovimiento oMovimiento)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("Depositar", conexion);
                    cmd.Parameters.AddWithValue("idCuenta", oMovimiento.IdCuenta);
                    cmd.Parameters.AddWithValue("deposito", oMovimiento.Credito);
                    cmd.Parameters.AddWithValue("saldo", oMovimiento.Saldo);
                    cmd.Parameters.AddWithValue("descripcion", oMovimiento.Descripcion);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                respuesta = true;

            }
            catch (Exception e)
            {
                string error = e.Message;
                respuesta = false;
            }

            return respuesta;
        }

        public bool Extraer(ModelMovimiento oMovimiento)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("Extraer", conexion);
                    cmd.Parameters.AddWithValue("idCuenta", oMovimiento.IdCuenta);
                    cmd.Parameters.AddWithValue("extraccion", oMovimiento.Debito);
                    cmd.Parameters.AddWithValue("saldo", oMovimiento.Saldo);
                    cmd.Parameters.AddWithValue("descripcion", oMovimiento.Descripcion);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                respuesta = true;

            }
            catch (Exception e)
            {
                string error = e.Message;
                respuesta = false;
            }

            return respuesta;
        }


    }
}
