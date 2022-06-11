using TP_Cripto.Models;
using System.Data.SqlClient;
using System.Data;

namespace TP_Cripto.Datos
{
    public class CuentaDatos
    {
        //Read
        public List<ModelCuenta> ListarCuentaCliente(int idCliente)
        {
            var oLista = new List<ModelCuenta>();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();

                SqlCommand cmd = new SqlCommand("ListarCuentaCliente", conexion);
                cmd.Parameters.AddWithValue("idTitular", idCliente);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oLista.Add(new ModelCuenta()
                        {
                            Id = Convert.ToInt32(dr["id"]),
                            IdTitular = Convert.ToInt32(dr["idTitular"]),
                            IdMoneda = Convert.ToInt32(dr["idMoneda"]),
                            Moneda = dr["nombre"].ToString(),
                            CBU_UUID = dr["CBU_UUID"].ToString(),
                            Alias = dr["alias"].ToString(),
                            NumeroCuenta = Convert.ToInt32(dr["numeroCuenta"]),
                            Saldo = Convert.ToDecimal(dr["saldo"]),
                            Descripcion = dr["descripcion"].ToString(),
                            FechaAlta = DateOnly.Parse(Convert.ToDateTime(dr["fechaAlta"].ToString()).ToString("dd/MM/yyyy"))
                    });
                    }
                }
            }
            return oLista;
        }

        //Read by Id
        public ModelCuenta Obtener(int id)
        {
            var oCuenta = new ModelCuenta();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("ObtenerCuenta", conexion);
                cmd.Parameters.AddWithValue("id", id);//Recibe el parametro
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oCuenta.Id = Convert.ToInt32(dr["id"]);
                        oCuenta.IdTitular = Convert.ToInt32(dr["idTitular"]);
                        oCuenta.IdMoneda = Convert.ToInt32(dr["idMoneda"]);
                        oCuenta.Moneda = dr["nombre"].ToString();
                        oCuenta.CBU_UUID = dr["CBU_UUID"].ToString();
                        oCuenta.Alias = dr["alias"].ToString();
                        oCuenta.NumeroCuenta = Convert.ToInt32(dr["numeroCuenta"]);
                        oCuenta.Saldo = Convert.ToDecimal(dr["saldo"]);
                        oCuenta.Descripcion = dr["descripcion"].ToString();
                        oCuenta.FechaAlta = DateOnly.Parse(Convert.ToDateTime(dr["fechaAlta"].ToString()).ToString("dd/MM/yyyy"));
                    }
                }

            }

            return oCuenta;
        }

        //Create
        public bool Guardar(ModelCuenta oCuenta)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();
                using (var Conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    Conexion.Open();
                    SqlCommand cmd = new SqlCommand("GuardarCuenta", Conexion);
                    cmd.Parameters.AddWithValue("idTitular", oCuenta.IdTitular);
                    cmd.Parameters.AddWithValue("idMoneda", oCuenta.IdMoneda);
                    cmd.Parameters.AddWithValue("CBU_UUID", oCuenta.CBU_UUID);
                    cmd.Parameters.AddWithValue("alias", oCuenta.Alias);
                    cmd.Parameters.AddWithValue("numeroCuenta", oCuenta.NumeroCuenta);
                    cmd.Parameters.AddWithValue("saldo", oCuenta.Saldo);
                    cmd.Parameters.AddWithValue("descripcion", oCuenta.Descripcion);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }

                respuesta = true;

            }
            catch (Exception ex)
            {
                string error = ex.Message;
                respuesta = false;
            }

            return respuesta;
        }

        public bool ActualizarSaldo(ModelCuenta oCuenta)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("ActualizarSaldoCuenta", conexion);
                    cmd.Parameters.AddWithValue("id", oCuenta.Id);
                    cmd.Parameters.AddWithValue("saldo", oCuenta.Saldo);
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
