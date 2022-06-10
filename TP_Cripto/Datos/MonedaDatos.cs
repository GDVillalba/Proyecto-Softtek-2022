using TP_Cripto.Models;
using System.Data.SqlClient;
using System.Data;


namespace TP_Cripto.Datos
{
    public class MonedaDatos
    {
        //Read
        public List<ModelMoneda> Listar()
        {
            var oLista = new List<ModelMoneda>();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();

                SqlCommand cmd = new SqlCommand("ListarMoneda", conexion);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oLista.Add(new ModelMoneda()
                        {
                            Id = Convert.ToInt32(dr["id"]),
                            Nombre = dr["nombre"].ToString(),
                            CotizacionEnUSD = Convert.ToDecimal( dr["cotizacionEnUSD"])
                        });
                    }
                }
            }
            return oLista;
        }

        //Read by Id
        public ModelMoneda Obtener(int id)
        {
            var oMoneda = new ModelMoneda();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("ObtenerMoneda", conexion);
                cmd.Parameters.AddWithValue("id", id);//Recibe el parametro
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oMoneda.Id = Convert.ToInt32(dr["id"]);
                        oMoneda.Nombre = dr["nombre"].ToString();
                        oMoneda.CotizacionEnUSD = Convert.ToDecimal(dr["cotizacionEnUSD"]);
                    }
                }

            }

            return oMoneda;
        }
    }
}
