using TP_Cripto.Models;
using System.Data.SqlClient;
using System.Data;

namespace TP_Cripto.Datos
{
    public class ClienteDatos
    {
        //Read
        public List<ModelCliente> Listar()
        {
            var oLista = new List<ModelCliente>();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();

                SqlCommand cmd = new SqlCommand("ListarCliente", conexion);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oLista.Add(new ModelCliente()
                        {
                            Id = Convert.ToInt32(dr["id"]),
                            Usuario = dr["usuario"].ToString(),
                            Clave = dr["clave"].ToString(),
                            Nombre = dr["nombre"].ToString(),
                            Mail = dr["mail"].ToString(),
                            Telefono = dr["telefono"].ToString(),
                            FechaAlta = DateOnly.Parse(dr["fechaAlta"].ToString())
                        });
                    }
                }
            }
            return oLista;
        }

        //Read by Id
        public ModelCliente Obtener(int id)
        {
            var oCliente = new ModelCliente();
            //Conexion
            var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("ObtenerCliente", conexion);
                cmd.Parameters.AddWithValue("id", id);//Recibe el parametro
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oCliente.Id = Convert.ToInt32(dr["id"]);
                        oCliente.Usuario = dr["usuario"].ToString();
                        oCliente.Clave = dr["clave"].ToString();
                        oCliente.Nombre = dr["nombre"].ToString();
                        oCliente.Mail = dr["mail"].ToString();
                        oCliente.Telefono = dr["telefono"].ToString();
                        oCliente.FechaAlta = DateOnly.Parse( dr["fechaAlta"].ToString());
                    }
                }

            }

            return oCliente;
        }

        //Read by Usuario y Clave
        public ModelCliente Validar(string usuario, string  clave)
        {
            var oCliente = new ModelCliente();

            oCliente.Id = 0;
            oCliente.Usuario = "";

            try
            {
                //Conexion
                var cn = new Conexion();

            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("ValidarCliente", conexion);
                cmd.Parameters.AddWithValue("usuario", usuario);
                cmd.Parameters.AddWithValue("clave", clave);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oCliente.Id = Convert.ToInt32(dr["id"]);
                        oCliente.Usuario = dr["usuario"].ToString();
                        oCliente.Clave = dr["clave"].ToString();
                        oCliente.Nombre = dr["nombre"].ToString();
                        oCliente.Mail = dr["mail"].ToString();
                        oCliente.Telefono = dr["telefono"].ToString();
                        oCliente.FechaAlta = DateOnly.Parse(dr["fechaAlta"].ToString());
                    }
                }

            }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }

            return oCliente;
        }

        //Create
        public bool Guardar(ModelCliente oCliente)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();
                using (var Conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    Conexion.Open();
                    SqlCommand cmd = new SqlCommand("GuardarCliente", Conexion);
                    cmd.Parameters.AddWithValue("usuario", oCliente.Usuario);
                    cmd.Parameters.AddWithValue("clave", oCliente.Clave);
                    cmd.Parameters.AddWithValue("nombre", oCliente.Nombre);
                    cmd.Parameters.AddWithValue("mail", oCliente.Mail);
                    cmd.Parameters.AddWithValue("telefono", oCliente.Telefono);
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

        public bool Editar(ModelCliente oCliente)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("EditarCliente", conexion);
                    cmd.Parameters.AddWithValue("id", oCliente.Id);
                    cmd.Parameters.AddWithValue("clave", oCliente.Clave);
                    cmd.Parameters.AddWithValue("nombre", oCliente.Nombre);
                    cmd.Parameters.AddWithValue("mail", oCliente.Mail);
                    cmd.Parameters.AddWithValue("telefono", oCliente.Telefono);
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

        public bool Eliminar(int id)
        {
            bool respuesta = false;

            try
            {
                var cn = new Conexion();

                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("EliminarCliente", conexion);
                    cmd.Parameters.AddWithValue("id", id);
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
