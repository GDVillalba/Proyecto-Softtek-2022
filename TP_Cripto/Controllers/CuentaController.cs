using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using TP_Cripto.Models;
using TP_Cripto.Datos;

namespace TP_Cripto.Controllers
{
    public class CuentaController : Controller
    {
        ClienteDatos clienteDatos = new ClienteDatos();
        CuentaDatos cuentaDatos = new CuentaDatos();

        public IActionResult Index()
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            if (HttpContext.Session.GetString("usuario") != null && HttpContext.Session.GetString("usuario") != "")
            {
                var oLista = cuentaDatos.ListarCuentaCliente((int)Convert.ToInt32(HttpContext.Session.GetInt32("idCliente")));

                return View(oLista);
            }

            return View();

        }
    }
}
