using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using TP_Cripto.Models;
using TP_Cripto.Datos;

namespace TP_Cripto.Controllers
{
    public class HomeController : Controller
    {
        ClienteDatos clienteDatos = new ClienteDatos();

        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            return View();
        }

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(String usuario, String clave)
        {
            TempData["Message"] = new String("Usuario o clave incorrecta " + usuario + " " + clave + " fin");

            var respuesta = clienteDatos.Validar(usuario, clave);

            if (respuesta.Usuario != "")
            {
                HttpContext.Session.SetInt32("idCliente", respuesta.Id);
                HttpContext.Session.SetString("usuario", respuesta.Usuario);
                return RedirectToAction("Index");
            }

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