using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using TP_Cripto.Models;
using TP_Cripto.Datos;

namespace TP_Cripto.Controllers
{
    public class HomeController : Controller
    {
        ClienteDatos clienteDatos = new ClienteDatos();

        MonedaDatos monedaDatos = new MonedaDatos();

        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            var oLista = monedaDatos.Listar();

            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            return View(oLista);
        }

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(String usuario, String clave)
        {

            var respuesta = clienteDatos.Validar(usuario, clave);

            if (respuesta.Usuario != "")
            {
                HttpContext.Session.SetInt32("idCliente", respuesta.Id);
                HttpContext.Session.SetString("usuario", respuesta.Usuario);
                TempData["idCliente"] = HttpContext.Session.GetString("idCliente");
                return RedirectToAction("Index", "Cuenta");
            }

            TempData["Message"] = new String("Usuario o clave incorrecta ");

            return RedirectToAction();
        }

        public IActionResult Perfil()
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
                var oCliente = clienteDatos.Obtener((int)Convert.ToInt32(HttpContext.Session.GetInt32("idCliente")));

                if(oCliente.Usuario != "")
                {                
                    return View(oCliente);
                }
            }

            TempData["Respuesta"] = new String("No hay un cliente para editar, ingrese al sistema");
            return View();
        }

        [HttpPost]
        public IActionResult Perfil(ModelCliente oCliente)
        {
            if (!ModelState.IsValid)
            {
                TempData["Message"] = new String("Modelo invalido ");
                return View();
            }

            var respuesta = clienteDatos.Editar(oCliente);

            if (respuesta)
            {
                TempData["Respuesta"] = new String("Actualizado con Exito");
                return View();
            }

            TempData["Message"] = new String("Error al actualizar datos cliente ");

            return View();
        }

        //[HttpPost]
        public IActionResult Logout()
        {
            HttpContext.Session.SetInt32("idCliente", 0);
            HttpContext.Session.SetString("usuario", "");

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            return RedirectToAction("Index");
        }

        public IActionResult Registrar()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registrar(ModelCliente oCliente)
        {
            if (!ModelState.IsValid)
            {
                TempData["Message"] = new String("Model invalid ");
                return View();
            }

            var respuesta = clienteDatos.Validar( oCliente.Usuario, oCliente.Clave);

            if (respuesta.Usuario == "")
            {
                if(clienteDatos.Guardar(oCliente))
                {
                    TempData["Exito"] = new String("Resgistrado con Exito");
                    return View();
                }
                TempData["Message"] = new String("Error al guardar cliente ");
                return View();
            }

            TempData["Message"] = new String("Usuario ya resgistrado ");

            return View();
        }


        public IActionResult Privacy()
        {
            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}